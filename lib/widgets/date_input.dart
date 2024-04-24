import 'package:flutter/material.dart';
import 'package:emoneytransfer/helper/app_utils.dart';

class DateInputField extends StatefulWidget {
  final TextInputType? textInputType;
  final bool hideText;
  final TextEditingController? inputController;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? inputValidator;
  final void Function(String?)? onChanged;
  final VoidCallback? onTap;

  DateInputField(
      {
      this.textInputType,
      this.inputController,
      this.contentPadding,
      this.hideText = false,
      this.onChanged,
      this.onTap,
      this.inputValidator});

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // constraints: BoxConstraints(maxHeight: 50),
      height: 54,
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          contentPadding: widget.contentPadding,

          labelText: 'Choose Date',
          labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppUtils.DarkColor.withOpacity(0.8),
                fontSize: 14.0,
              ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.2,
                color: Color.fromARGB(66, 65, 65, 65),
              ),
              borderRadius: BorderRadius.circular(5.0)),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppUtils.RedColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorStyle: TextStyle(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: AppUtils.DarkColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1.2,
              color: Color.fromARGB(66, 65, 65, 65),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          // constraints: const BoxConstraints(minHeight: 52.0),
          filled: true,
          fillColor: Colors.transparent,
          suffixIcon: Icon(Icons.calendar_month_outlined),
        ),
        controller: widget.inputController,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.w500),
        cursorColor: Colors.black,
        validator: widget.inputValidator,
        obscureText: widget.hideText,
        keyboardType: widget.textInputType,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
      ),
    );
  }
}
