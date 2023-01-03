import 'package:flutter/material.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  final double? width;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget? child;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.width,
    this.fontSize,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 0,
      textStyle: TextStyle(
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.w600,
      ),
      primary: backgroundColor ?? MyColors.primary,
      onPrimary: textColor ?? MyColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(MyDimensions.radius),
          ),
          side: BorderSide(
            color: onPressed == null ? MyColors.desc2 : borderColor ?? MyColors.primary,
            width: 1.5,
          )),
    );

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: width,
      ),
      child: ElevatedButton(
        onPressed: onPressed == null
            ? null
            : () {
                onPressed!();
              },
        child: child ?? Text(text.toString()),
        style: style,
      ),
    );
  }
}
