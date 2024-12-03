import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uni_country_city_picker/src/core/features/widgets/uni_widgets.dart';

Future primaryCupertinoBottomSheet({
  required BuildContext context,
  required Widget child,
  bool isShowCloseIcon = true,
  bool haveBarrierColor = false,
  bool enableDragDismiss = true,
  bool showSwipeCloseIndicator = false,
  double? height,
  EdgeInsets? padding,
  Widget? bottomBarWidget,
  Color? backgroundColor,
  Widget? backButtonWidget,
  Function()? onClosePressed,
  Function()? onBackPressed,
}) async {
  return await showCupertinoModalBottomSheet(
    barrierColor: haveBarrierColor ? Colors.black.withOpacity(0.8) : null,
    context: context,
    backgroundColor: backgroundColor ?? Colors.white,
    topRadius: const Radius.circular(14),
    isDismissible: true,
    duration: const Duration(milliseconds: 300),
    enableDrag: enableDragDismiss,
    builder: (_) {
      return Container(
        width: double.infinity,
        height: height ?? .92 * MediaQuery.of(context).size.height,
        padding: padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
        ),
        child: Material(
          surfaceTintColor: Colors.white,
          shadowColor: Colors.white,
          color: Colors.white,
          child: Stack(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Visibility(
                    visible: showSwipeCloseIndicator,
                    child: Container(
                      width: 24,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 24),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        // color: Colors.gray30,
                      ),
                    ),
                  ),
                  Expanded(child: child),
                ],
              ),
              if (isShowCloseIcon)
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.only(start: 20, top: 31),
                    child: UniWidgets.closeButton(),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}
