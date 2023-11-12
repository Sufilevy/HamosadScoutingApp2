import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class AnalyticsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AnalyticsAppBar({super.key, required this.title, this.titleAvatar});

  final String title;
  final Widget? titleAvatar;

  @override
  Size get preferredSize => Size.fromHeight(55 * AnalyticsTheme.appSizeRatio);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _buildTitle().padRight(titleAvatar == null ? 0 : 50),
      leading: _buildMenuButton(context),
      leadingWidth: 66 * AnalyticsTheme.appSizeRatio,
    );
  }

  Widget _buildTitle() {
    if (titleAvatar == null) {
      return navigationTitleText(title);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        titleAvatar!,
        navigationTitleText(title),
      ],
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return pad(
      left: 20,
      top: 6,
      bottom: 6,
      IconButton(
        iconSize: 24 * AnalyticsTheme.appSizeRatio,
        icon: const FaIcon(
          FontAwesomeIcons.barsStaggered,
        ),
        onPressed: Scaffold.of(context).openDrawer,
      ),
    );
  }
}
