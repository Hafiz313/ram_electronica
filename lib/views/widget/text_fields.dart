
import 'package:flutter/material.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';

import '../../consts/colors.dart';
import '../../consts/fonts.dart';

class CustomTxtField extends StatelessWidget {
  final String? hintTxt;
  final bool isHiddenPassword;
  final bool enabled;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  final TextEditingController? textEditingController;

  const CustomTxtField(
      {Key? key,
      this.hintTxt,
      this.validator,
      this.keyboardType,
      this.textInputAction = TextInputAction.next,
      this.textEditingController,
      this.isHiddenPassword = false, this.prefixIcon, this.suffixIcon,  this.enabled=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      enabled: enabled,
      cursorColor: AppColors.accent,
      keyboardType:keyboardType ,
      controller: textEditingController,
      obscureText: isHiddenPassword,
      validator: validator,
      style: const TextStyle(
          color: AppColors.textColor,
          fontFamily: FontFamily.satoshi,
          fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        border:  OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.textColor),
            borderRadius: BorderRadius.circular(20)
        ),
        enabledBorder:  OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.textColor),
            borderRadius: BorderRadius.circular(20)
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.textColor),
          borderRadius: BorderRadius.circular(20)
        ),
        errorBorder:  OutlineInputBorder(
          borderSide: const BorderSide(
              width: 1, color: AppColors.redColor),
            borderRadius: BorderRadius.circular(20)
        ),
        prefixIcon:prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintTxt,
        hintStyle: TextStyle(
            color: AppColors.textColor.withOpacity(0.5),
            fontFamily: FontFamily.satoshi,
            fontWeight: FontWeight.w200),
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      ),
    );
  }
}
