import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';

class DropdownMenuField extends StatefulWidget {
  final List<String> values;
  final void Function(String?)? onChanged;

  DropdownMenuField({required this.values, this.onChanged});
  @override
  State<DropdownMenuField> createState() => _DropdownMenuFieldState();
}

class _DropdownMenuFieldState extends State<DropdownMenuField> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      height: 55.0,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Color.fromARGB(66, 65, 65, 65),
            width: 1.0,
          )),
      child: DropdownButton<String>(
        value: selectedValue ??
            widget.values.first, // The currently selected option
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        icon: const Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 27.0,
            ),
          ),
        ),

        // elevation: 16,
        style: const TextStyle(
          color: AppUtils.DarkColor,
        ),
        onChanged: (String? newValue) {
          // Callback function when a new option is selected
          // You can use this callback to update the state or perform other actions
          setState(() {
            selectedValue = newValue;
          });
          widget.onChanged!(newValue);
        },
        items: widget.values.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
