
import 'package:flutter/material.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import 'package:ram_elettronica/views/widget/text.dart';

import '../../consts/colors.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.onPressed,
    required this.title,
    this.backgroundColor,
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final Function()? onPressed;
  final String title;
  final Color? backgroundColor;
  final double? width;

  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.percentWidth * 85,
      height: height ?? context.percentWidth * 11,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? AppColors.btnBgColor,
              // backgroundColor ?? Theme.of(context).colorScheme.secondary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: subText2(
            title,
            color: AppColors.btnTxtColor,
          ),
        ),
      ),
    );
  }
}
