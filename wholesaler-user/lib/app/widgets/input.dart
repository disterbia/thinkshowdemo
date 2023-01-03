import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';

class InputWidget extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Color? backgroundColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final Widget? suffixIcon;
  final AutovalidateMode? autoValidateMode;
  final int? minLines;
  final int? maxLines;
  final bool? readOnly;
  bool? isRtl;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  InputWidget(
      {Key? key,
      required this.labelText,
      this.hintText,
      this.controller,
      this.onSaved,
      this.onChanged,
      this.validator,
      this.backgroundColor,
      this.keyboardType,
      this.textInputAction,
      this.obscureText,
      this.suffixIcon,
      this.autoValidateMode,
      this.minLines,
      this.maxLines,
      this.isRtl,
      this.maxLength,
      this.readOnly,
      this.inputFormatters,
      this.onTap})
      : super(key: key) {
    isRtl ??= false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: isRtl! ? TextDirection.rtl : TextDirection.ltr,
      onTap: onTap,
      inputFormatters: inputFormatters,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      obscureText: obscureText ?? false,
      controller: controller,
      autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: MyColors.desc, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(MyDimensions.radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyColors.primary, width: 2),
          ),
          filled: true,
          fillColor: Colors.transparent,
          hintStyle: const TextStyle(color: MyColors.desc),
          alignLabelWithHint: true,
          hintText: hintText,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0)),
    );
  }
}
