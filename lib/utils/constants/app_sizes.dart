import 'package:flutter/material.dart';
import 'package:supos_v3/utils/constants/type.dart';
import 'package:supos_v3/utils/helpers/extensions.dart';

class AppSizes {
  const AppSizes._();

  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 20.0;
  static const double defaultGap = 20.0;
  static const double defaultButtonHeight = 50.0;
  static const double defaultButtonWidth = 250.0;
  static const double defaultContainerHeight = 50.0;
  static const double defaultContainerWidth = 300.0;
  static const SizedBox defaultHorizontalSpace = SizedBox(
    width: defaultGap,
  );
  static const SizedBox defaultVerticalSpace = SizedBox(
    height: defaultGap,
  );

// size it can be either small, medium, or large
  static Size defaultButtonSize(BuildContext context, SizeOption size) =>
      size == SizeOption.small
          ? Size(context.widthFraction(sizeFraction: 0.3),
              context.heightFraction(sizeFraction: 0.06))
          : size == SizeOption.large
              ? Size(context.widthFraction(sizeFraction: 0.6),
                  context.heightFraction(sizeFraction: 0.06))
              : Size(context.widthFraction(sizeFraction: 0.3),
                  context.heightFraction(sizeFraction: 0.06));

  static Size maximumButtonSize(BuildContext context, SizeOption size) =>
      size == SizeOption.small
          ? Size(defaultButtonWidth * 0.4, defaultButtonHeight)
          : size == SizeOption.large
              ? Size(defaultButtonWidth, defaultButtonHeight)
              : Size(defaultButtonWidth * 0.5, defaultButtonHeight);

  static Size minimumButtonSize(BuildContext context, SizeOption size) =>
      size == SizeOption.small
          ? Size(defaultButtonWidth * 0.4, defaultButtonHeight)
          : size == SizeOption.large
              ? Size(defaultButtonWidth, defaultButtonHeight)
              : Size(defaultButtonWidth * 0.5, defaultButtonHeight);
}
