import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/services/utilities.dart';
import '/theme.dart';
import '/widgets/padding.dart';
import '/widgets/text.dart';

class AnalyticsDrawer extends StatelessWidget {
  const AnalyticsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: _drawerWidth(getScreenSize(context).width),
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(),
        ],
      ),
    );
  }

  double _drawerWidth(double screenWidth) => math.max(screenWidth / 2.0, 300.0);
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0 * AnalyticsTheme.appSizeRatio,
      decoration: _headerDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          _buildMenuButton(context),
        ],
      ),
    );
  }

  BoxDecoration get _headerDecoration => const BoxDecoration(
        color: AnalyticsTheme.darkBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 4.0,
            spreadRadius: 2.0,
            offset: Offset.zero,
          ),
        ],
      );

  Widget _buildLogo() {
    return Row(
      children: [
        pad(
          left: 16.0,
          right: 8.0,
          SvgPicture.asset(
            'assets/svg/logo.svg',
            width: 50.0 * AnalyticsTheme.appSizeRatioSquared,
            height: 50.0 * AnalyticsTheme.appSizeRatioSquared,
          ),
        ),
        logoText('Hamosad\n Analytics'),
      ],
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return padRight(
      16.0 * AnalyticsTheme.appSizeRatio,
      Transform.rotate(
        angle: math.pi / 2,
        child: IconButton(
          iconSize: 26.0 * AnalyticsTheme.appSizeRatio,
          icon: const FaIcon(
            FontAwesomeIcons.barsStaggered,
          ),
          onPressed: Scaffold.of(context).closeDrawer,
        ),
      ),
    );
  }
}
