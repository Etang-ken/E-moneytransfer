import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';

enum IconPosition { left, right }

class GeneralButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onClickBtn;
  final IconPosition? iconPosition;
  final Widget? btnIcon;
  final bool btnDisabled;
  final Color btnBgColor;
  final Color btnTextColor;
  final Color borderColor;
  final double? btnFontSize;

  GeneralButton(
      {required this.buttonText,
      this.onClickBtn,
      this.btnIcon,
      this.btnFontSize = 14.5,
      this.iconPosition = IconPosition.right,
      this.btnBgColor = AppUtils.PrimaryColor,
      this.btnTextColor = Colors.white,
      Color? borderColor,

      this.btnDisabled = true})
      : borderColor = borderColor ?? btnBgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 50.0, // Minimum width in logical pixels
      ),
      child: btnDisabled == false
          ? ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.5),
                  foregroundColor: Theme.of(context).primaryColorLight,
                  elevation: 0.0,
                  shadowColor: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  iconPosition == IconPosition.left && btnIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: btnIcon,
                        )
                      : Container(width: 0, height: 0),
                  Text(
                    buttonText,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.w600,
                        fontSize: btnFontSize),
                  ),
                  iconPosition == IconPosition.right && btnIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: btnIcon,
                        )
                      : Container(width: 0, height: 0),
                ],
              ),
            )
          : ElevatedButton(
              onPressed: onClickBtn,
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: borderColor)
                  ),
                  backgroundColor: btnBgColor,
                  foregroundColor: btnTextColor,
                
                  elevation: 0.0,
                  shadowColor: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  iconPosition == IconPosition.left && btnIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: btnIcon,
                        )
                      : Container(width: 0, height: 0),
                  Text(
                    buttonText,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: btnTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: btnFontSize),
                  ),
                  iconPosition == IconPosition.right && btnIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: btnIcon,
                        )
                      : Container(width: 0, height: 0),
                ],
              ),
            ),
    );
  }
}
