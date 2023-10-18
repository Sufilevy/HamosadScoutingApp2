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
        children: const [
          DrawerHeader(),
        ],
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0 * AnalyticsTheme.appSizeRatio,
      decoration: _headerDecoration,
      child: padSymmetric(
        vertical: 8.0,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogo(),
            _buildMenuButton(context),
          ],
        ),
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
          left: 20.0,
          right: 10.0,
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
      20.0 * AnalyticsTheme.appSizeRatio,
      IconButton(
        iconSize: 26.0 * AnalyticsTheme.appSizeRatio,
        icon: const FaIcon(
          FontAwesomeIcons.barsStaggered,
        ),
        onPressed: Scaffold.of(context).closeDrawer,
      ),
    );
  }
}
