import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../customers/customers.dart';

class CustomerDropdownField extends ConsumerWidget {
  const CustomerDropdownField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerState = ref.watch(customerNotifierProvider);

    return customerState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (e, _) => const Text(
            "Error fetching customers",
            style: TextStyle(color: Colors.red),
          ),
      data: (customers) {
        return FormBuilderSearchableDropdown<int>(
          name: 'customer_id',
          decoration: const InputDecoration(labelText: 'Customer'),
          items: customers.map((c) => c.id).toList(),
          itemAsString: (id) {
            final customer = customers.firstWhere((c) => c.id == id);
            return customer.name;
          },
          popupProps: const PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(hintText: 'Search customer...'),
            ),
          ),
          compareFn: (a, b) => a == b,
          validator: FormBuilderValidators.required(),
        );
      },
    );
  }
}
