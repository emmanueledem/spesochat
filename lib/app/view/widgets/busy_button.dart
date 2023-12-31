import 'package:flutter/cupertino.dart';
import 'package:spesochat/app/app.dart';
import 'package:spesochat/core/constants/colors.dart';

class BusyButton extends StatefulWidget {
  const BusyButton({
    required this.title,
    required this.onpress,
    super.key,
    this.deactivate = false,
    this.width,
    this.height,
    this.loading = false,
    this.fontSize = 16,
  });
  final String title;
  final bool? deactivate;
  final bool loading;

  final VoidCallback onpress;
  final double? width;
  final double? height;
  final double fontSize;
  @override
  State<BusyButton> createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ignore: use_if_null_to_convert_nulls_to_bools
      onTap: widget.deactivate == true ? null : widget.onpress,
      child: Container(
        height: widget.height ?? 56,
        width: widget.width ?? double.infinity,
        decoration: BoxDecoration(
          // ignore: use_if_null_to_convert_nulls_to_bools
          color: widget.deactivate == true
              ? AppColors.deactivatedBtn
              : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        child: Center(
          child: widget.loading
              ? const CupertinoActivityIndicator()
              : TextRegular(
                  widget.title,
                  fontSize: widget.fontSize,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
        ),
      ),
    );
  }
}

class SecondaryBusyButton extends StatefulWidget {
  const SecondaryBusyButton({
    required this.title,
    required this.onpress,
    super.key,
    this.width,
    this.borderColor = AppColors.primaryColor,
    this.textColor = AppColors.primaryColor,
    this.deactivate = false,
    this.loading = false,
  });
  final String title;

  final VoidCallback onpress;
  final double? width;
  final Color borderColor;
  final Color textColor;
  final bool? deactivate;
  final bool loading;

  @override
  State<SecondaryBusyButton> createState() => _SecondaryBusyButtonState();
}

class _SecondaryBusyButtonState extends State<SecondaryBusyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpress,
      child: Container(
        height: 51,
        width: widget.width ?? double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
            88.77,
          ),
          border: Border.all(
            color: widget.deactivate == false
                ? widget.borderColor
                : AppColors.deactivatedColor,
          ),
        ),
        child: Center(
          child: widget.loading
              ? const CupertinoActivityIndicator()
              : TextRegular(
                  widget.title,
                  color: widget.deactivate == false
                      ? widget.textColor
                      : AppColors.deactivatedColor,
                  fontWeight: FontWeight.w600,
                ),
        ),
      ),
    );
  }
}
