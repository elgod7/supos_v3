import 'package:flutter/material.dart';
import 'package:supos_v3/utils/constants/app_colors.dart';
import 'package:supos_v3/utils/constants/app_sizes.dart';

ButtonStyle primaryButtonStyle(BuildContext context, bool isSmall) =>
    ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.primaryColor),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      maximumSize: WidgetStateProperty.all<Size>(
          AppSizes.maximumButtonSize(context, isSmall)),
      minimumSize: WidgetStateProperty.all<Size>(
          AppSizes.minimumButtonSize(context, isSmall)),
      fixedSize: WidgetStateProperty.all<Size>(
          AppSizes.defaultButtonSize(context, isSmall)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius),
        ),
      ),
      foregroundColor: WidgetStateProperty.all<Color>(AppColors.lightColor),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );

ButtonStyle secondaryButtonStyle(BuildContext context, bool isSmall) =>
    ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.lightColor),
      side: WidgetStateProperty.all<BorderSide>(
        const BorderSide(color: AppColors.primaryColor),
      ),
      maximumSize: WidgetStateProperty.all<Size>(
          AppSizes.maximumButtonSize(context, isSmall)),
      minimumSize: WidgetStateProperty.all<Size>(
          AppSizes.minimumButtonSize(context, isSmall)),
      fixedSize: WidgetStateProperty.all<Size>(
          AppSizes.defaultButtonSize(context, isSmall)),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius),
        ),
      ),
    );

TextStyle primaryTextStyle() => const TextStyle(
      color: AppColors.darkColor,
      fontSize: 16,
    );

TextStyle secondaryTextStyle() => const TextStyle(
      color: AppColors.primaryColor,
      fontSize: 16,
    );

TextStyle headingTextStyle() => const TextStyle(
      color: AppColors.darkColor,
      fontSize: 24,
      fontWeight: FontWeight.w900,
    );

TextStyle subheadingTextStyle() => const TextStyle(
      color: AppColors.darkColor,
      fontSize: 14,
    );

TextStyle normalTextStyle() => TextStyle(
      color: AppColors.darkColor,
      fontSize: 12,
    );

TextStyle normalTextButtonStyle() => TextStyle(
      color: AppColors.primaryColor,
      fontSize: 12,
    );

InputDecoration textFieldDecoration(String label) => InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius),
    ),
    labelText: label,
    labelStyle: subheadingTextStyle());
