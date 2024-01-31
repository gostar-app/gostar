import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/ui_helper.dart';
import '../custom_widgets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    this.title = '',
    this.isTitleCentered,
    this.hasBackButton = true,
    this.isHeroAnimated = true,
    this.actions,
  });

  ///Title of text
  final String title;

  ///Should the title be centered
  ///
  ///[Default is null]
  final bool? isTitleCentered;

  ///Platform adaptive back icon
  ///
  ///[Default is true]
  final bool hasBackButton;

  ///The widgets are rendered from end
  final List<Widget>? actions;

  ///Is Hero animated
  final bool isHeroAnimated;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: isHeroAnimated ? 'app_bar' : 'no_hero_animation',
      child: Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        height: Scaffold.of(context).appBarMaxHeight,
        padding: EdgeInsets.only(
          top: (50).h,
          bottom: (15).h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: <Widget>[
                //Back Button
                if (hasBackButton)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: PlatformIcon(),
                  ),

                //Main Heading and Title
                Align(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),

                //Actions
                if (actions != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: actions!,
                    ),
                  ),
              ],
            ),
            //Back Button
          ],
        ),
      ),
    );
  }
}

class PlatformIcon extends StatelessWidget {
  const PlatformIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CIconButton(
        icon: CupertinoIcons.back,
        label: 'Back Button',
        padding: const EdgeInsets.only(right: 12),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } else {
      return CIconButton(
        icon: Icons.arrow_back_sharp,
        label: 'Back Button',
        padding: const EdgeInsets.only(right: 12),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
  }
}
