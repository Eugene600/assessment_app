import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../visits/visits.dart';
import '../../activities/activities.dart';
import '../../customers/customers.dart';
import '../widgets/widgets.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitsAsync = ref.watch(visitListNotifierProvider);
    final activitiesAsync = ref.watch(activityNotifierProvider);
    final customersAsync = ref.watch(customerNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("📊 Insights & Stats")),
      body: visitsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error loading visits: $e")),
        data: (visits) {
          final totalVisits = visits.length;
          final completed = visits.where((v) => v.status == "Completed").length;
          final pending = visits.where((v) => v.status == "Pending").length;
          final cancelled = visits.where((v) => v.status == "Cancelled").length;

          final now = DateTime.now();
          final currentMonthVisits =
              visits.where((v) {
                final date = DateTime.parse(v.visitDate);
                return date.year == now.year && date.month == now.month;
              }).length;

          final upcomingVisits =
              visits
                  .where(
                    (v) => DateTime.parse(v.visitDate).isAfter(DateTime.now()),
                  )
                  .length;

          final activityCounts = <String, int>{};
          for (var visit in visits) {
            for (var activity in visit.activitiesDone) {
              activityCounts[activity] = (activityCounts[activity] ?? 0) + 1;
            }
          }

          final avgActivities =
              visits.isEmpty
                  ? 0
                  : visits
                          .map((v) => v.activitiesDone.length)
                          .reduce((a, b) => a + b) /
                      visits.length;

          return activitiesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error:
                (e, _) => Center(child: Text("Error loading activities: $e")),
            data: (activities) {
              final activityMap = {
                for (var a in activities) a.id.toString(): a.description,
              };

              return customersAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (e, _) =>
                        Center(child: Text("Error loading customers: $e")),
                data: (customers) {
                  final customerVisitCounts = <int, int>{};
                  for (var visit in visits) {
                    customerVisitCounts[visit.customerId] =
                        (customerVisitCounts[visit.customerId] ?? 0) + 1;
                  }

                  final topCustomers =
                      customerVisitCounts.entries.toList()
                        ..sort((a, b) => b.value.compareTo(a.value));

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Overview", style: theme.textTheme.headlineMedium),
                        const SizedBox(height: 16),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          children: [
                            StatCard(
                              title: "Total Visits",
                              value: totalVisits.toString(),
                              icon: Icons.calendar_today,
                              color: Colors.blue,
                            ),
                            StatCard(
                              title: "Completed",
                              value: completed.toString(),
                              icon: Icons.check_circle,
                              color: Colors.green,
                            ),
                            StatCard(
                              title: "Pending",
                              value: pending.toString(),
                              icon: Icons.access_time,
                              color: Colors.amber,
                            ),
                            StatCard(
                              title: "Cancelled",
                              value: cancelled.toString(),
                              icon: Icons.cancel,
                              color: Colors.red,
                            ),
                            StatCard(
                              title: "This Month",
                              value: currentMonthVisits.toString(),
                              icon: Icons.date_range,
                              color: Colors.teal,
                            ),
                            StatCard(
                              title: "Upcoming",
                              value: upcomingVisits.toString(),
                              icon: Icons.upcoming,
                              color: Colors.indigo,
                            ),
                            StatCard(
                              title: "Avg Visit",
                              value: avgActivities.toStringAsFixed(1),
                              icon: Icons.timeline,
                              color: Colors.purple,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Text(
                          "🔥 Most Common Activities",
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              activityCounts.entries
                                  .toList()
                                  .sorted((a, b) => b.value.compareTo(a.value))
                                  .where((e) => activityMap[e.key] != null)
                                  .take(4)
                                  .mapIndexed((index, e) {
                                    final name = activityMap[e.key]!;
                                    final count = e.value;
                                    return Chip(
                                      avatar: Icon(
                                        Icons.check_circle_outline,
                                        size: 16,
                                        color:
                                            theme
                                                .colorScheme
                                                .onSecondaryContainer,
                                      ),
                                      backgroundColor:
                                          theme.colorScheme.secondaryContainer,
                                      label: Text(
                                        "$name ($count)",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color:
                                                  theme
                                                      .colorScheme
                                                      .onSecondaryContainer,
                                            ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    );
                                  })
                                  .toList(),
                        ),

                        const SizedBox(height: 32),
                        Text(
                          "👥 Top Customers",
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        ...topCustomers.take(5).map((e) {
                          final name =
                              customers.firstWhere((c) => c.id == e.key).name;
                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(name),
                              trailing: Text("${e.value} visits"),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

extension SortedList<E> on List<E> {
  List<E> sorted([int Function(E a, E b)? compare]) {
    final list = List<E>.from(this);
    list.sort(compare);
    return list;
  }
}
