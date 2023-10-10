// ignore_for_file: inference_failure_on_function_return_type

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:spesochat/core/constants/app_assets.dart';
import 'package:spesochat/core/constants/app_fonts.dart';
import 'package:spesochat/core/constants/colors.dart';

class InputField extends StatefulWidget {
  const InputField({
    required this.controller,
    required this.placeholder,
    this.label,
    this.enterPressed,
    this.fieldFocusNode,
    this.nextFocusNode,
    this.additionalNote,
    this.onChanged,
    this.maxLines = 1,
    this.validationMessage,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.password = false,
    this.isReadOnly = false,
    this.smallVersion = true,
    this.suffix,
    this.onTap,
    this.prefix,
    this.validationColor = AppColors.inputBorderColor,
    this.prefixSizedBoxWidth = 20,
    super.key,
  });

  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool password;
  final bool isReadOnly;
  final String placeholder;
  final String? validationMessage;
  final Function? enterPressed;
  final bool smallVersion;
  final FocusNode? fieldFocusNode;
  final Function? onTap;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  final String? additionalNote;
  final String? label;
  final double prefixSizedBoxWidth;
  final Function(String)? onChanged;

  final int? maxLines;
  final Widget? suffix;
  final Widget? prefix;
  final Color validationColor;

  @override
  // ignore: library_private_types_in_public_api
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool? isPassword;
  double fieldHeight = 52;

  @override
  void initState() {
    super.initState();
    isPassword = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // HeaderText(
        //   widget.label.toString(),
        //   fontSize: 16,
        //   fontWeight: FontWeight.w600,
        // ),
        const Gap(10),
        GestureDetector(
          child: Container(
            height: fieldHeight,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.inputColor,
              border: Border.all(
                color: widget.validationColor,
              ),
            ),
            child: Row(
              children: <Widget>[
                widget.prefix ?? const SizedBox(),
                const Gap(19.02),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    keyboardType: widget.textInputType,
                    focusNode: widget.fieldFocusNode,
                    textInputAction: widget.textInputAction,
                    onChanged: widget.onChanged,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.ash,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFonts.montserrat,
                    ),
                    obscureText: isPassword!,
                    readOnly: widget.isReadOnly,
                    decoration: InputDecoration(
                      hintText: widget.placeholder,
                      border: InputBorder.none,

                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.montserrat,
                      ),
                      // suffix:
                    ),
                  ),
                ),
                widget.suffix ??
                    GestureDetector(
                      onTap: () => setState(() {
                        isPassword = !isPassword!;
                      }),
                      child: widget.password
                          ? Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              child: isPassword!
                                  ? SvgPicture.asset(AppAssets.eye)
                                  : SvgPicture.asset(AppAssets.eyeSlash),
                            )
                          : Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                            ),
                    ),
              ],
            ),
          ),
        ),
        if (widget.validationMessage != null)
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.validationMessage!,
              style: const TextStyle(
                color: AppColors.kDanger,
                fontSize: 12,
                fontFamily: AppFonts.montserrat,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
