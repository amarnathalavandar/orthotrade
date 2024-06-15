import 'package:flutter/material.dart';


class StatelessDropdown extends StatelessWidget {
  final String selectedValue;
  final List<String> dropdownItems;
  final Function(String?) onValueChanged;

  const StatelessDropdown({super.key, 
    required this.selectedValue,
    required this.dropdownItems,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return  DropdownButton<String>(
        style: const TextStyle(color: Colors.black54,fontSize: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),

      value: selectedValue,
      onChanged: (String? value) {
        // Notify the parent widget about the change in selected value
        onValueChanged(value);
      },
      items: dropdownItems.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),

            );
          }).toList(),

    );
  }
}
