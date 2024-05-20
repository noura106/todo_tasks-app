import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData? icon;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final Color? enableBorderColor;
  final double? suffixIconSize;
  final double? borderRadius;
  final String? imageData;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final bool? general;
  final bool? required;
  final bool? enabled;
  final bool? readOnly;
  final bool? withTitle;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final InputDecoration? inputDecoration;
  final Function()? onEditingComplete;
  final Color? fillColor;

  const CustomTextField(
      {Key? key,
        this.labelText = "",
        required this.hintText,
        this.icon,
        this.fillColor = AppColors.white,
        this.readOnly = false,
        this.onEditingComplete,
        this.imageData,
        this.borderRadius = 5,
        this.suffixIcon,
        this.suffixIconColor = AppColors.primaryColor,
        this.enableBorderColor = AppColors.lightGrey,
        this.suffixIconSize = 15,
        this.validator,
        this.focusNode,
        this.onChanged,
        this.obscureText = false,
        this.textInputAction,
        this.keyboardType,
        this.autofocus = false,
        this.controller,
        this.general = false,
        this.withTitle = false,
        this.required = false,
        this.enabled = true,
        this.maxLength,
        this.maxLines = 1,
        this.minLines,
        this.onTap,
        this.inputDecoration})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isSeen = false;
  late InputDecoration _inputDecoration;

  @override
  void initState() {
    super.initState();
    if (widget.inputDecoration == null) {
      _inputDecoration = !widget.general!
          ? AppTheme.inputDecoration.copyWith(
          counterText: "",
          prefixIcon: widget.icon != null
              ? Icon(
            widget.icon,
            color: AppColors.grey,
            size: 20,
          )
              : widget.imageData != null
              ? ImageIcon(
            AssetImage(widget.imageData!),
            color: AppColors.grey,
            size: 20,
          )
              : null,
          fillColor: AppColors.lightGrey)
          : InputDecoration(
          counterText: "",
          label: Row(
            children: [
              Text(widget.labelText),
              if (widget.required!)
                const Text(
                  ' *',
                  style: TextStyle(color: Colors.red),
                )
            ],
          ));
    } else {
      _inputDecoration = widget.inputDecoration!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.withTitle!
            ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.labelText,
                style: AppTheme.bodyText2
                    .copyWith(color: AppColors.primaryColor)))
            : Container(),
        TextFormField(
          focusNode: widget.focusNode,
          readOnly: widget.readOnly!,
          enabled: widget.enabled!,
          onTap: widget.onTap,
          expands: widget.maxLength == 0 ? true : false,
          controller: widget.controller ?? TextEditingController(),
          decoration: _inputDecoration.copyWith(
              fillColor: widget.fillColor,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                borderSide: const BorderSide(
                  color: AppColors.lightBlueColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                borderSide: BorderSide(
                  color: widget.enableBorderColor!,
                  width: 0.5,
                ),
              ),
              hintText:
              !widget.required! ? widget.hintText : widget.hintText + ' *',
              hintStyle: AppTheme.subtitle2.copyWith(
                fontWeight: FontWeight.w200,
                color: AppColors.lightGrey,
              ),
              suffixIcon: widget.obscureText!
                  ? IconButton(
                onPressed: () {
                  setState(() {
                    isSeen = !isSeen;
                  });
                },
                icon: Icon(
                  isSeen
                      ? context.platformIcons.eyeSolid
                      : context.platformIcons.eyeSlashSolid,
                  size: 15,
                  color:widget.suffixIconColor!=null?widget.suffixIconColor:isSeen?AppColors.primaryColor:AppColors.grey ,
                ),
              )
                  : widget.suffixIcon != null
                  ? Icon(widget.suffixIcon,
                  size: widget.suffixIconSize,
                  color: widget.suffixIconColor)
                  : null),
          validator: widget.validator,
          obscureText: !isSeen ? widget.obscureText! : false,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          onEditingComplete: widget.onEditingComplete,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          autofocus: widget.autofocus!,
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
        ),
      ],
    );
  }
}
