import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../activities/activities.dart';


class ActivityCheckboxGroup extends ConsumerWidget {
  const ActivityCheckboxGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(activityNotifierProvider);

    return activityState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => const Text(
        "Error fetching activities",
        style: TextStyle(color: Colors.red),
      ),
      data: (activities) {
        return FormBuilderCheckboxGroup<String>(
          name: 'activities_done',
          decoration: const InputDecoration(labelText: 'Activities Done'),
          options: activities.map((Activity activity) {
            return FormBuilderFieldOption(
              value: activity.id.toString(),
              child: Text(activity.description),
            );
          }).toList(),
          validator: FormBuilderValidators.minLength(1,
              errorText: 'Select at least one activity'),
        );
      },
    );
  }
}
