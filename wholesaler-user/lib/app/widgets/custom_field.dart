import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
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
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String? initialValue;

  CustomTextField({
    this.labelText,
    this.hintText,
    this.controller,
    this.onSaved,
    this.onChanged,
    this.focusNode,
    this.nextNode,
    this.validator,
    this.backgroundColor,
    this.keyboardType,
    this.textInputAction,
    this.obscureText,
    this.suffixIcon,
    this.autoValidateMode,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.readOnly,
    this.inputFormatters,
    this.onTap,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    bool? temp ;
    temp=readOnly??false;
    return TextFormField(
      initialValue: initialValue,
      focusNode: focusNode,
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
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusColor: MyColors.primary,
          labelText: labelText,
          labelStyle: const TextStyle(color: MyColors.secondaryColor, fontSize: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(MyDimensions.radius),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.grey6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyColors.black1, width: 1),
          ),
          filled: true,
          fillColor: temp?Colors.black12:Colors.transparent,
          hintStyle: const TextStyle(color: MyColors.desc),
          alignLabelWithHint: true,
          hintText: hintText,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8.0)),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
