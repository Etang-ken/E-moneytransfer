import 'package:flutter/material.dart';
import 'package:elcrypto/helper/app_utils.dart';

class TextInputField extends StatefulWidget {
  final String? placeholderText;
  final int maxLines;
  final TextInputType? textInputType;
  final bool hideText;
  final bool enabled;
  final TextEditingController? inputController;
  final EdgeInsetsGeometry? contentPadding;
  final Color? bgColor;
  final String? Function(String?)? inputValidator;
  final void Function(String?)? onChanged;

  TextInputField({
    this.placeholderText,
    this.textInputType,
    this.inputController,
    this.contentPadding,
    this.bgColor,
    this.hideText = false,
    this.onChanged,
    this.inputValidator,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(minHeight: 50),
      // height: 54,
      child: TextFormField(

        decoration: InputDecoration(

          contentPadding: widget.contentPadding,
          labelText: widget.placeholderText,
          labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppUtils.DarkColor.withOpacity(0.8),
                fontSize: 14.0,
              ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.2,
                color: Color.fromARGB(66, 65, 65, 65),
              ),
              borderRadius: BorderRadius.circular(8.0)),
          errorStyle: TextStyle(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppUtils.PrimaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1.2,
              color: Color.fromARGB(66, 65, 65, 65),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          constraints: const BoxConstraints(minHeight: 52.0),
          filled: true,
          fillColor: widget.enabled?(widget.bgColor ?? Colors.transparent):Color(0xfff1f1f1)
        ),
        controller: widget.inputController,
        maxLines: widget.maxLines,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.w600),
        cursorColor: AppUtils.PrimaryColor,
        enabled: widget.enabled,
        validator: widget.inputValidator,
        obscureText: widget.hideText,
        keyboardType: widget.textInputType,
        onChanged: widget.onChanged,
      ),
    );
  }
}
