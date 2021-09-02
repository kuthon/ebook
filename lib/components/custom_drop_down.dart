import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final String selectedValue;
  final List<String> values;
  final void Function(String newValue) onChange;

  CustomDropDown({required this.values, required this.selectedValue, required this.onChange});

  @override
  _CustomDropDownState createState() => _CustomDropDownState(selectedValue, values, onChange);
}

class _CustomDropDownState extends State<CustomDropDown> {
  String selectedValue;
  List<String> values;
  void Function(String newValue) onChange;

  _CustomDropDownState(this.selectedValue, this.values, this.onChange);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: DropdownButton(
        value: selectedValue,
        underline: SizedBox.shrink(),
        onChanged: (String? newValue) {
          setState(() {
            onChange(newValue!);
            selectedValue = newValue;
          });
        },
        items: values.map((location) {
          return DropdownMenuItem(
            child: new Text(
              location,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            value: location,
          );
        }).toList(),
      ),
    );
  }
}
