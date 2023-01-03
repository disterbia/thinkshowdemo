import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wholesaler_user/app/widgets/custom_field.dart';

import 'custom_button.dart';

/// [CustomField] may contain label, textfield, and button.
class CustomField extends StatelessWidget {
  final String? fieldLabel;
  final String fieldText;
  final TextEditingController fieldController;
  final String? buttonText;
  final int? maxLines;
  final bool? isTextKeyboard;
  final Function()? onTap;
  final double? fontSize;
  bool? hasButton;
  bool? readOnly;
  bool? isObscureText;
  List<TextInputFormatter>? inputFormatters;

  CustomField({
    this.fieldLabel,
    this.maxLines,
    this.fontSize,
    required this.fieldText,
    required this.fieldController,
    this.isTextKeyboard,
    this.buttonText,
    this.onTap,
    this.readOnly,
    this.isObscureText,
    this.inputFormatters,
  }) {
    if (buttonText != null && onTap != null) {
      hasButton = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _fieldLabel(),
        _field(),
      ],
    );
  }

  Widget _field() {
    return hasButton ?? false ? _fieldAndButton() : _onlyField();
  }

  Widget _fieldAndButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomTextField(
            keyboardType: isTextKeyboard ?? false
                ? TextInputType.number
                : TextInputType.text,
            readOnly: readOnly,
            maxLines: maxLines ?? 1,
            labelText: fieldText,
            controller: fieldController,
            inputFormatters: inputFormatters ?? [],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 80,
          child: CustomButton(
            fontSize: fontSize ?? 16,
            onPressed: onTap,
            text: buttonText,
          ),
        )
      ],
    );
  }

  Widget _onlyField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomTextField(
            readOnly: readOnly,
            maxLines: maxLines ?? 1,
            keyboardType: isTextKeyboard ?? false
                ? TextInputType.number
                : TextInputType.text,
            labelText: fieldText,
            controller: fieldController,
            obscureText: isObscureText ?? false,
            inputFormatters: inputFormatters ?? [],
          ),
        ),
      ],
    );
  }

  Widget _fieldLabel() {
    return fieldLabel != null
        ? Align(
            alignment: Alignment.centerLeft,
            child: Text(fieldLabel!),
          )
        : SizedBox.shrink();
  }
}
