import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/services/utilities.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class AnalyticsDrawer extends StatelessWidget {
  const AnalyticsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: getScreenSize(context).width / 2.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AnalyticsTheme.darkBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 4.0,
            spreadRadius: 2.0,
            offset: Offset.zero,
          )
        ],
      ),
      child: padSymmetric(
        vertical: 8.0,
        Stack(
          children: [
            _buildLogo(),
            Align(
              alignment: Alignment.topRight,
              child: _buildMenuButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        padSymmetric(
          horizontal: 20.0,
          SvgPicture.asset(
            'assets/svg/logo.svg',
            width: 50.0 * AnalyticsTheme.appSizeRatio,
            height: 50.0 * AnalyticsTheme.appSizeRatio,
          ),
        ),
        logoText('Hamosad\nAnalytics'),
      ],
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return IconButton(
      icon: const FaIcon(FontAwesomeIcons.barsStaggered),
      onPressed: Scaffold.of(context).closeDrawer,
    ).padRight(20.0);
  }
}
