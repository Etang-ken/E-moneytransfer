import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';
class CheckBoxInput extends StatefulWidget {
  final bool isChecked;
  final Function(bool?) onChangeChecked;
  final Color? checkedBgColor;
  
  CheckBoxInput({required this.isChecked, required this.onChangeChecked, this.checkedBgColor = AppUtils.PrimaryColor});

  @override
  State<CheckBoxInput> createState() => _CheckBoxInputState();
}

class _CheckBoxInputState extends State<CheckBoxInput> {

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
        MaterialState.selected
      };
      if (states.any(interactiveStates.contains)) {
        return widget.checkedBgColor!;
      }
      return Colors.transparent;
    }

    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        border: Border.all(width: 0.0, color: Colors.white),
        color: widget.isChecked ? widget.checkedBgColor : Colors.white,
        borderRadius: BorderRadius.circular(3)
        
      ),
      child: Checkbox(
          value: widget.isChecked,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          onChanged: widget.onChangeChecked),
    );
  }
}
