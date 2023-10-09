import 'package:flutter/material.dart';
import 'package:spesochat/core/constants/app_fonts.dart';
import 'package:spesochat/core/constants/colors.dart';

/// Base text with black color and letter spacing set
///  [AppTextBase]
class AppTextBase extends StatelessWidget {
  const AppTextBase(
    this.text, {
    this.style,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.visible,
    this.maxLines = 1,
    super.key,
  });
  final String? text;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    assert(text != null, 'test can not be null');
    return Text(
      text ?? '',
      style: const TextStyle(
        fontSize: 14,
      ).merge(style),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

///  [TextBold] .
class TextBold extends AppTextBase {
  TextBold(
    String super.text, {
    super.key,
    TextStyle? style,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
    super.textAlign,
    super.overflow,
    super.maxLines = 2,
  }) : super(
          style: TextStyle(
            fontFamily: AppFonts.montserrat,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? AppColors.black,
          ).merge(style),
        );
}

class AppTextSemiBold extends AppTextBase {
  AppTextSemiBold(
    String super.text, {
    super.key,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    super.maxLines = 2,
  }) : super(
          style: const TextStyle(
            fontFamily: AppFonts.montserrat,
          ).merge(style),
          textAlign: textAlign ?? TextAlign.left,
          overflow: overflow ?? TextOverflow.visible,
        );
}

class HeaderText extends AppTextBase {
  HeaderText(
    String super.text, {
    super.key,
    TextStyle? style,
    double fontSize = 34,
    TextAlign? textAlign,
    TextOverflow? overflow,
    Color? color,
    FontWeight fontWeight = FontWeight.w700,
    super.maxLines = 2,
    String fontFamily = AppFonts.montserrat,
  }) : super(
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            color: color ?? AppColors.black,
          ).merge(style),
          textAlign: textAlign ?? TextAlign.left,
          overflow: overflow ?? TextOverflow.visible,
        );
}

///  [TextRegular] .
class TextRegular extends AppTextBase {
  TextRegular(
    String super.text, {
    super.key,
    TextStyle? style,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    super.textAlign,
    super.overflow,
    String fontFamily = AppFonts.montserrat,
    super.maxLines = 2,
  }) : super(
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            color: color ?? AppColors.textColor,
          ).merge(style),
        );
}

class TextBody extends TextRegular {
  TextBody(
    super.text, {
    super.key,
    TextStyle? style,
    Color? color,
    double? fontSize,
    super.textAlign,
    super.overflow,
    super.maxLines,
    double? height,
  }) : super(
          style: TextStyle(
            fontSize: fontSize ?? 14,
            color: color ?? AppColors.textColor,
            fontWeight: FontWeight.w400,
            height: height,
          ).merge(style),
        );
}

class LongText extends StatelessWidget {
  const LongText(
    this.text, {
    this.style,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.visible,
    this.color = AppColors.black,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.maxLines = 1,
    super.key,
  });
  final String? text;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    assert(text != null, 'test can not be null');
    return Text(
      text ?? '',
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? AppColors.black,
        fontWeight: fontWeight,
        fontFamily: AppFonts.montserrat,
      ).merge(style),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

class LongerText extends StatelessWidget {
  const LongerText(
    this.text, {
    this.style,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.visible,
    this.color = AppColors.black,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    super.key,
  });
  final String? text;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    assert(text != null, 'test can not be null');
    return Text(
      text ?? '',
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? AppColors.black,
        fontWeight: fontWeight,
        fontFamily: AppFonts.montserrat,
      ).merge(style),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
