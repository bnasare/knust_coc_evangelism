import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// `CustomTextFormField` is a custom widget that extends the StatelessWidget.
/// It encapsulates a TextFormField widget and provides additional customization options.
///
/// The following parameters can be passed to the `CustomTextFormField` constructor:
/// * `validator` - A function that takes a string and returns a string. It is used to validate the input.
/// * `onChanged` - A function that is called whenever the text field's content changes.
/// * `controller` - A TextEditingController that can be used to control the text field's text.
/// * `hintText` - A string that is shown as a hint in the text field when it is empty.
/// * `keyboardType` - The type of keyboard to show for the text field.
/// * `readOnly` - A boolean that determines whether the text field is read only. Defaults to false.
/// * `enabled` - A boolean that determines whether the text field is enabled. Defaults to true.
/// * `autofocus` - A boolean that determines whether the text field should automatically get focus. Defaults to false.
/// * `suffixIcon` - A widget to display as the suffix icon of the text field.
/// * `inputFormatters` - A list of TextInputFormatter that determines how the input should be formatted.
/// * `focusNode` - A FocusNode that can be used to control the focus of the text field.
/// * `onFieldSubmitted` - A function that is called when the user submits the text field (usually by pressing the "done" button on the keyboard).
/// * `suffix` - A widget that is displayed at the rightmost side of the TextFormField.
/// * `onEditingComplete` - A function that is called when the user submits the text field (usually by pressing the "done" button on the keyboard).
///
/// The `build` method returns a TextFormField widget with the passed parameters and additional styling.
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.validator,
    this.onChanged,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.suffixIcon,
    this.inputFormatters,
    this.focusNode,
    this.onFieldSubmitted,
    this.suffix,
    this.onTap,
    this.onEditingComplete,
  });

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool? enabled;
  final bool autofocus;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final Widget? suffix;
  final void Function()? onTap;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText != null ? ' $hintText' : null,
        suffixIcon: suffixIcon,
      ),
      cursorColor: Colors.black,
      cursorHeight: 20,
      cursorOpacityAnimates: true,
      cursorWidth: 1,
      style: const TextStyle(fontSize: 14),
      onEditingComplete: onEditingComplete,
    );
  }
}
