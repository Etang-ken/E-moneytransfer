import 'package:flutter/material.dart';
import 'package:elcrypto/helper/app_utils.dart';

enum IconPosition { left, right }

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onClickBtn;
  final IconPosition? iconPosition;
  final Widget? btnIcon;
  final bool btnDisabled;

  PrimaryButton(
      {required this.buttonText,
      this.onClickBtn,
      this.btnIcon,
      this.iconPosition = IconPosition.right,
      this.btnDisabled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 50.0, // Minimum width in logical pixels
      ),
      // width: MediaQuery.of(context).size.width * 1,
      child: btnDisabled
          ? ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Color.fromARGB(255, 196, 195, 195),
                  foregroundColor: Theme.of(context).primaryColorLight,
                  elevation: 0.0,
                  shadowColor: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  iconPosition == IconPosition.left && btnIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: btnIcon,
                        )
                      : Container(width: 0, height: 0),
                  Text(
                    buttonText,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppUtils.White,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5),
                  ),
                  iconPosition == IconPosition.right && btnIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10.0),
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
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5),
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
