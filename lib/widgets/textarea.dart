import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';

class TextAreaField extends StatefulWidget {
  final String? placeholderText;
  final TextInputType? textInputType;
  final bool hideText;
  final TextEditingController? inputController;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? inputValidator;
  final void Function(String?)? onChanged;

  TextAreaField(
      {this.placeholderText,
      this.textInputType,
      this.inputController,
      this.contentPadding,
      this.hideText = false,
      this.onChanged,
      this.inputValidator});

  @override
  State<TextAreaField> createState() => _TextAreaFieldState();
}

class _TextAreaFieldState extends State<TextAreaField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: widget.contentPadding,

          labelText: widget.placeholderText,
          labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppUtils.DarkColor.withOpacity(0.8),
                fontSize: 14.0,
              
              ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          alignLabelWithHint: true, 
          isDense: true, 
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
        maxLines: 5,
      ),
    );
  }
}
