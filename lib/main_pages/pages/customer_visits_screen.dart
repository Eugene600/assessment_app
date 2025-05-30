import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../activities/activities.dart';
import '../../customers/customers.dart';
import '../../visits/visits.dart';

class CustomerVisitsScreen extends ConsumerStatefulWidget {
  const CustomerVisitsScreen({super.key});

  @override
  ConsumerState<CustomerVisitsScreen> createState() =>
      _CustomerVisitsScreenState();
}

class _CustomerVisitsScreenState extends ConsumerState<CustomerVisitsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  String? _selectedStatus;
  DateTimeRange? _selectedDateRange;

  final List<String> _statusOptions = ['Completed', 'Pending', 'Cancelled'];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(visitListNotifierProvider.notifier).getVisits();
      ref.read(customerNotifierProvider.notifier).fetchCustomers();
      ref.read(activityNotifierProvider.notifier).fetchActivities();
    });

    _searchController.addListener(() {
      setState(() {
        _searchTerm = _searchController.text.toLowerCase().trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visitsAsync = ref.watch(visitListNotifierProvider);
    final customersAsync = ref.watch(customerNotifierProvider);
    final activitiesAsync = ref.watch(activityNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("📋 Customer Visits")),
      body: visitsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error loading visits: $e")),
        data: (visits) {
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
                  final customerMap = {for (var c in customers) c.id: c.name};

                  final filteredVisits =
                      visits.where((visit) {
                        final name =
                            customerMap[visit.customerId]?.toLowerCase() ?? '';
                        final location = visit.location.toLowerCase();
                        final matchesSearch =
                            name.contains(_searchTerm) ||
                            location.contains(_searchTerm);
                        final matchesStatus =
                            _selectedStatus == null ||
                            visit.status == _selectedStatus;

                        final visitDate = DateTime.parse(visit.visitDate);
                        final matchesDate =
                            _selectedDateRange == null ||
                            (visitDate.isAfter(
                                  _selectedDateRange!.start.subtract(
                                    const Duration(days: 1),
                                  ),
                                ) &&
                                visitDate.isBefore(
                                  _selectedDateRange!.end.add(
                                    const Duration(days: 1),
                                  ),
                                ));

                        return matchesSearch && matchesStatus && matchesDate;
                      }).toList();

                  final theme = Theme.of(context);

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search by customer or location...',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon:
                                    _searchTerm.isNotEmpty
                                        ? IconButton(
                                          onPressed:
                                              () => _searchController.clear(),
                                          icon: const Icon(Icons.clear),
                                        )
                                        : null,
                              ),
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<String>(
                              value: _selectedStatus,
                              items: [
                                const DropdownMenuItem(
                                  value: null,
                                  child: Text("All Statuses"),
                                ),
                                ..._statusOptions.map(
                                  (status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ),
                                ),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Filter by status',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _selectedStatus = value;
                                });
                              },
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _selectedDateRange == null
                                        ? 'Filter by visit date range'
                                        : 'From: ${DateFormat('yyyy-MM-dd').format(_selectedDateRange!.start)}\nTo:   ${DateFormat('yyyy-MM-dd').format(_selectedDateRange!.end)}',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final pickedRange =
                                        await showDateRangePicker(
                                          context: context,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 365),
                                          ),
                                          initialDateRange: _selectedDateRange,
                                        );
                                    if (pickedRange != null) {
                                      setState(() {
                                        _selectedDateRange = pickedRange;
                                      });
                                    }
                                  },
                                  child: const Text('Select Range'),
                                ),
                                if (_selectedDateRange != null)
                                  IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        _selectedDateRange = null;
                                      });
                                    },
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child:
                            filteredVisits.isEmpty
                                ? const Center(
                                  child: Text("No matching visits found."),
                                )
                                : ListView.separated(
                                  padding: const EdgeInsets.all(16),
                                  itemCount: filteredVisits.length,
                                  separatorBuilder:
                                      (_, __) => const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final visit = filteredVisits[index];
                                    final customerName =
                                        customerMap[visit.customerId] ??
                                        "Unknown Customer";

                                    return Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          child: Text(customerName[0]),
                                        ),
                                        title: Text(customerName),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Status: ${visit.status}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "Date: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(visit.visitDate))}",
                                            ),
                                            Text("Location: ${visit.location}"),
                                            const SizedBox(height: 8),
                                            Wrap(
                                              spacing: 8,
                                              runSpacing: 4,
                                              children:
                                                  visit.activitiesDone.map((
                                                    activityId,
                                                  ) {
                                                    final name =
                                                        activityMap[activityId] ??
                                                        "Unknown Activity";
                                                    return Chip(
                                                      label: Text(name),
                                                      backgroundColor:
                                                          theme
                                                              .colorScheme
                                                              .primaryContainer,
                                                    );
                                                  }).toList(),
                                            ),
                                          ],
                                        ),
                                        isThreeLine: true,
                                        trailing: Tooltip(
                                          message: visit.status,
                                          child: Icon(
                                            visit.status == "Completed"
                                                ? Icons.check_circle_outline
                                                : visit.status == "Pending"
                                                ? Icons.access_time
                                                : Icons.cancel,
                                            color:
                                                visit.status == "Completed"
                                                    ? Colors.green
                                                    : visit.status == "Pending"
                                                    ? Colors.amber
                                                    : Colors.red,
                                          ),
                                        ),

                                        onTap: () {
                                          // Future enhancement: navigate to visit details
                                        },
                                      ),
                                    );
                                  },
                                ),
                      ),
                    ],
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
