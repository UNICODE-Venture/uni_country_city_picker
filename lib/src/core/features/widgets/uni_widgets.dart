import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni_country_city_picker/src/constants/assets_path.dart';

class UniWidgets {
  //* Singleton __________________________________
  UniWidgets._();
  static UniWidgets? _instance;
  static final _lock = Completer<void>();

  static UniWidgets get instance {
    if (_instance == null) {
      if (!_lock.isCompleted) _lock.complete();
      _instance = UniWidgets._();
    }
    return _instance!;
  }

  static SizedBox verticalSpace(double size) => SizedBox(height: size);

  static SizedBox horizontalSpace(double size) => SizedBox(width: size);

  static Widget closeButton(
      {Function()? onTap, bool isWithCircle = false, Color? iconColor}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: isWithCircle ? const EdgeInsets.all(11) : EdgeInsets.zero,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isWithCircle ? Colors.black.withOpacity(.2) : null),
        child: const Icon(
          Icons.close,
          size: 20,
        ),
      ),
    );
  }

  static Widget svgIcon(
    String iconName, {
    Function()? onTap,
    bool isDirectional = false,
    double? width,
    double? height,
    double? size,
    Color? color,
    BoxFit? fit,
    bool isRotated = false,
    double borderRadius = 0,
  }) {
    return InkWell(
      onTap: onTap,
      child: Transform.rotate(
        angle: isRotated ? pi : 0,
        child: Container(
          width: size ?? (width ?? 24),
          height: size ?? (height ?? 24),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: SvgPicture.asset(
            '${UniAssetsPath.icons}/$iconName.svg',
            matchTextDirection: isDirectional,
            fit: fit ?? BoxFit.cover,
            color: color,
            //* for the images in the package
            package: 'uni_country_city_picker',
          ),
        ),
      ),
    );
  }
}
