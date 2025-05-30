import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../activities/activities.dart';
import '../../customers/customers.dart';
import '../../visits/visits.dart';
import '../../utils/utils.dart';
import '../widgets/widgets.dart';

class AddVisitsScreen extends ConsumerStatefulWidget {
  const AddVisitsScreen({super.key});

  @override
  ConsumerState<AddVisitsScreen> createState() => _AddVisitsScreenState();
}

class _AddVisitsScreenState extends ConsumerState<AddVisitsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> _statusOptions = ['Completed', 'Pending', 'Cancelled'];

  void submitVisit() async {
    final isValid = _formKey.currentState?.saveAndValidate() ?? false;

    if (!isValid) {
      debugPrint("Form is invalid.");
      return;
    }

    final formData = _formKey.currentState!.value;

    final visit = Visit(
      customerId: formData['customer_id'],
      visitDate: (formData['visit_date'] as DateTime).toUtc().toIso8601String(),
      status: formData['status'],
      location: formData['location'],
      notes: formData['notes'],
      activitiesDone: List<String>.from(formData['activities_done']),
    );

    final result = await ref
        .read(visitDetailNotifierProvider.notifier)
        .postVisit(visit);

    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add visit: $error'),
            backgroundColor: Colors.red,
          ),
        );
      },
      (createdVisit) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Visit added successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        _formKey.currentState?.reset();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(customerNotifierProvider.notifier).fetchCustomers();
      ref.read(activityNotifierProvider.notifier).fetchActivities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "📝 Schedule a New Visit",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ResponsiveWidgetFormLayout(
        buildPageContent:
            (BuildContext context, Color? color) => SafeArea(
              child: Container(
                padding: const EdgeInsets.all(Constants.spacing * 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Constants.roundness),
                ),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const CustomerDropdownField(),
                      const SizedBox(height: 16),
                      FormBuilderDateTimePicker(
                        name: 'visit_date',
                        inputType: InputType.both,
                        decoration: const InputDecoration(
                          labelText: 'Visit Date',
                        ),
                        initialDate: DateTime.now(),
                        format: DateFormat("yyyy-MM-dd HH:mm"),
                        validator: FormBuilderValidators.required(),
                      ),
                      const SizedBox(height: 16),
                      FormBuilderDropdown<String>(
                        name: 'status',
                        decoration: const InputDecoration(labelText: 'Status'),
                        items:
                            _statusOptions
                                .map(
                                  (status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ),
                                )
                                .toList(),
                        validator: FormBuilderValidators.required(),
                      ),
                      const SizedBox(height: 16),
                      FormBuilderTextField(
                        name: 'location',
                        decoration: const InputDecoration(
                          labelText: 'Location',
                        ),
                        validator: FormBuilderValidators.required(),
                      ),
                      const SizedBox(height: 16),
                      FormBuilderTextField(
                        name: 'notes',
                        decoration: const InputDecoration(labelText: 'Notes'),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      const ActivityCheckboxGroup(),
                      const SizedBox(height: 22),
                      FilledButton(
                        onPressed: submitVisit,
                        child: const Text("Submit Visit"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
