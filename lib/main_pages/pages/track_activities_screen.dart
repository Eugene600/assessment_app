// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';

// import '../../activities/activities.dart';
// import '../../customers/customers.dart';
// import '../../visits/visits.dart';

// class ActivityTrackingScreen extends ConsumerStatefulWidget {
//   const ActivityTrackingScreen({super.key});

//   @override
//   ConsumerState<ActivityTrackingScreen> createState() =>
//       _ActivityTrackingScreenState();
// }

// class _ActivityTrackingScreenState
//     extends ConsumerState<ActivityTrackingScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       ref.read(customerNotifierProvider.notifier).fetchCustomers();
//       ref.read(activityNotifierProvider.notifier).fetchActivities();
//       ref.read(visitListNotifierProvider.notifier).getVisits();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     final visitsAsync = ref.watch(visitListNotifierProvider);
//     final customersAsync = ref.watch(customerNotifierProvider);
//     final activitiesAsync = ref.watch(activityNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text("📊 Activities Completed in Visits")),
//       body: visitsAsync.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (e, _) => Center(child: Text("Error loading visits: $e")),
//         data: (visits) {
//           return customersAsync.when(
//             loading: () => const Center(child: CircularProgressIndicator()),
//             error: (e, _) => Center(child: Text("Error loading customers: $e")),
//             data: (customers) {
//               return activitiesAsync.when(
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 error:
//                     (e, _) =>
//                         Center(child: Text("Error loading activities: $e")),
//                 data: (activities) {
//                   final customerMap = {for (var c in customers) c.id: c.name};
//                   final activityMap = {
//                     for (var a in activities) a.id.toString(): a.description,
//                   };

//                   if (visits.isEmpty) {
//                     return const Center(child: Text("No visits available."));
//                   }

//                   return ListView.separated(
//                     padding: const EdgeInsets.all(16),
//                     itemCount: visits.length,
//                     separatorBuilder: (_, __) => const SizedBox(height: 12),
//                     itemBuilder: (context, index) {
//                       final visit = visits[index];
//                       final customerName =
//                           customerMap[visit.customerId] ?? "Unknown Customer";

//                       return Card(
//                         elevation: 2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           title: Text(customerName),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Status: ${visit.status}",
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               Text(
//                                 "Date: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(visit.visitDate))}",
//                               ),
//                               Text("Location: ${visit.location}"),
//                               const SizedBox(height: 8),
//                               Wrap(
//                                 spacing: 8,
//                                 runSpacing: 4,
//                                 children:
//                                     visit.activitiesDone.map((activityId) {
//                                       final name =
//                                           activityMap[activityId] ??
//                                           "Unknown Activity";
//                                       return Chip(
//                                         label: Text(name),
//                                         backgroundColor: theme.colorScheme.primaryContainer,
//                                       );
//                                     }).toList(),
//                               ),
//                             ],
//                           ),
//                           isThreeLine: true,
//                           trailing: const Icon(
//                             Icons.check_circle_outline,
//                             color: Colors.green,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
