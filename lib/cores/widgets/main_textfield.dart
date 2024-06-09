import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_color.dart';

class MainTextField extends StatefulWidget {
  final String? title;
  final Color? titleColor;
  final bool isRequired;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final bool obsecureText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double borderRadius;
  final bool isError;
  final String? errorText;
  final bool isCenterText;
  final FocusNode? focusNode;
  final double letterSpacing;
  final bool isAddress;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final Color? bgColor;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final bool isUppercase;
  final String? initialValue;
  const MainTextField({
    super.key,
    this.title,
    this.titleColor,
    this.isRequired = false,
    this.controller,
    this.onChange,
    this.onFieldSubmitted,
    this.obsecureText = false,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 8,
    this.isError = false,
    this.errorText,
    this.isCenterText = false,
    this.focusNode,
    this.letterSpacing = 1,
    this.isAddress = false,
    this.maxLines = 4,
    this.maxLength,
    this.enabled = true,
    this.bgColor,
    this.validator,
    this.textInputType,
    this.textInputFormatter,
    this.isUppercase = false,
    this.initialValue,
  });

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.prefixIcon != null ? 0 : 16,
          ),
          decoration: BoxDecoration(
            color: clrGreyF5,
            border: Border.all(
              color: clrGreyE5,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: widget.isError
                ? LinearGradient(
                    colors: [
                      clrRed,
                      clrRed.withOpacity(0.9),
                      clrRed.withOpacity(0.4),
                      // clrRed.withOpacity(0.25),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: TextFormField(
            textAlignVertical:
                (widget.suffixIcon == null) && (widget.prefixIcon == null) ? null : TextAlignVertical.center,
            controller: widget.controller,
            initialValue: widget.initialValue,
            keyboardType: widget.textInputType,
            inputFormatters: widget.textInputFormatter,
            textCapitalization: widget.isUppercase ? TextCapitalization.characters : TextCapitalization.none,
            style: TextStyle(
              color: widget.isError ? clrRed : null,
              letterSpacing: widget.letterSpacing,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            focusNode: widget.focusNode,
            textAlign: widget.isCenterText ? TextAlign.center : TextAlign.start,
            maxLines: widget.isAddress ? widget.maxLines : 1,
            maxLength: widget.maxLength,
            decoration: widget.isAddress
                ? InputDecoration.collapsed(
                    border: InputBorder.none,
                    fillColor: clrGreyF5,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: clrGreyHintA0.withOpacity(0.5),
                    ),
                  )
                : InputDecoration(
                    border: InputBorder.none,
                    fillColor: clrGreyF5,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: clrGreyHintA0.withOpacity(0.5),
                    ),
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.suffixIcon,
                    // suffixIconConstraints:
                  ),
            onChanged: widget.onChange,
            onFieldSubmitted: widget.onFieldSubmitted,
            validator: widget.validator,
            obscureText: widget.obsecureText,
            enabled: widget.enabled,
          ),
        ),
        if (widget.isError && widget.errorText != null) const SizedBox(height: 2),
        if (widget.isError && widget.errorText != null)
          Row(
            mainAxisAlignment: widget.isCenterText ? MainAxisAlignment.center : MainAxisAlignment.end,
            children: [
              const SizedBox(
                width: 6,
              ),
              Expanded(
                child: Text(
                  widget.errorText!,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: clrRed,
                  ),
                ),
              ),
              const SizedBox(
                width: 6,
              )
            ],
          )
      ],
    );
  }
}
