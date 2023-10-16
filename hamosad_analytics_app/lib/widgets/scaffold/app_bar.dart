import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class AnalyticsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AnalyticsAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(60.0 * AnalyticsTheme.appSizeRatio);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: navigationTitleText(title),
      leading: _buildMenuButton(context),
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: IconButton(
        icon: const FaIcon(FontAwesomeIcons.barsStaggered),
        onPressed: Scaffold.of(context).openDrawer,
      ).pad(left: 20.0),
    );
  }
}
