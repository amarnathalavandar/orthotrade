/*
import 'package:flutter/material.dart';

import '../../../../../common/widgets/dropdown/dropdown.dart';





class DropdownExample extends StatefulWidget {

  final List<String> dropdownItems;
  final String selectedValue;
  DropdownExample({
    required this.dropdownItems,
    required this.selectedValue});

  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}


class _DropdownExampleState extends State<DropdownExample> {

 */
/* String selectedValue = '1';
  List<String> dropdownItems = ['1','2'];*//*


  @override
  void initState() {
    super.initState();
    innerSelectedDropdownValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return StatelessDropdown(
      selectedValue: innerSelectedDropdownValue,
      dropdownItems: widget.dropdownItems,
        onValueChanged: (String? value) {
      // Update the selected value in the parent widget's state
      setState(() {
        innerSelectedDropdownValue = value!;
      });
    },

    );
  }


}*/
