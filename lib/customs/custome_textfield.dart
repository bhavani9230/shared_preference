import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preference/customs/mytext.dart';

import 'colors.dart';

class CustomTextField extends StatefulWidget {
  final TextAlignVertical? textalignVertical;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final Color? cursorColor;
  final IconData? prefix;
  final IconButton? suffixIcon;
  final String? hintText;
  final Widget? labelText;
  bool? isObsecre;
  bool? focus;
  bool? enabled;
  bool? readOnly;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final FormFieldValidator<String>? validator;
  void Function(String)? onChanged;
  String? errorText;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final int? maxlength;
  final VoidCallback? onTap;

  CustomTextField(
      {super.key,
        this.textalignVertical,
        this.contentPadding,
        this.controller,
        this.cursorColor,
        this.prefix,
        this.suffixIcon,
        this.hintText,
        this.isObsecre = false,
        this.enabled = true,
        this.textInputType,
        this.validator,
        this.inputFormatter,
        this.onChanged,
        this.errorText,
        this.labelText,
        this.border,
        this.enabledBorder,
        this.focusedBorder,
        this.errorBorder,
        this.disabledBorder,
        this.maxlength,
        this.focus = false,
        this.readOnly,
        this.onTap,
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onTap: widget.onTap ?? (){},
        readOnly: widget.readOnly ?? false,
        autofocus: widget.focus!,
        maxLength: widget.maxlength,
        inputFormatters: widget.inputFormatter,
        keyboardType: widget.textInputType,
        enabled: widget.enabled,
        controller: widget.controller,
        obscureText: widget.isObsecre!,
        validator: widget.validator,
        onChanged: widget.onChanged,
        textAlignVertical: widget.textalignVertical,
        decoration: InputDecoration(
          contentPadding:
          widget.contentPadding ?? EdgeInsets.symmetric(vertical: 0),
          errorText: widget.errorText,
          border: widget.border ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: lightGreyColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: lightGreyColor)),
          focusedBorder: widget.focusedBorder ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: blueColor)),
          errorBorder: widget.errorBorder ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: redColor)),
          disabledBorder: widget.disabledBorder ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: lightGreyColor)),
          prefixIcon: Icon(
            widget.prefix,
            color: blueColor,
            size: 20,
          ),
          suffix: widget.suffixIcon,
          hintText: widget.hintText,
          label: widget.labelText ?? CustomText(text: ''),
        ),
      ),
    );
  }
}