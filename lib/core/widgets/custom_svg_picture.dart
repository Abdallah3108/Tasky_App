import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/theme_controller.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({
    super.key,
    required this.path,
    required this.withColorFilter,
    this.width,
    this.height,
  });

  //Named Constructor
  const CustomSvgPicture.withoutColor({
    super.key,
    required this.path,
    this.width,
    this.height,
  }) : withColorFilter = false;

  final String path;
  final bool withColorFilter;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter:
          withColorFilter
              ? ColorFilter.mode(
                ThemeController.isLight()
                    ? Color(0xff3A4640)
                    : Color(0xffC6C6C6),
                BlendMode.srcIn,
              )
              : null,
      width: width,
      height: height,
    );
  }
}
