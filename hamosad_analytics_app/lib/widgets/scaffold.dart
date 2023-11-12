import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/services/utilities.dart';
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

class AnalyticsDrawer extends StatelessWidget {
  const AnalyticsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: _drawerWidth(context.screenSize.width),
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(),
        ],
      ),
    );
  }

  double _drawerWidth(double screenWidth) => math.max(screenWidth / 2, 300);
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100 * AnalyticsTheme.appSizeRatio,
      decoration: _headerDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildLogo(),
          _buildMenuButton(context),
        ],
      ),
    );
  }

  BoxDecoration get _headerDecoration {
    return const BoxDecoration(
      color: AnalyticsTheme.darkBackground,
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 4,
          spreadRadius: 2,
          offset: Offset.zero,
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Row(
      children: <Widget>[
        pad(
          left: 16,
          right: 8,
          SvgPicture.asset(
            'assets/svg/logo.svg',
            width: 50 * AnalyticsTheme.appSizeRatioSquared,
            height: 50 * AnalyticsTheme.appSizeRatioSquared,
          ),
        ),
        logoText('Hamosad\n Analytics'),
      ],
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return padRight(
      16 * AnalyticsTheme.appSizeRatio,
      Transform.rotate(
        angle: math.pi / 2,
        child: IconButton(
          iconSize: 26 * AnalyticsTheme.appSizeRatio,
          icon: const FaIcon(
            FontAwesomeIcons.barsStaggered,
          ),
          onPressed: Scaffold.of(context).closeDrawer,
        ),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AnalyticsTheme.background1,
      child: const Center(
        child: CircularProgressIndicator(
          color: AnalyticsTheme.primary,
        ),
      ),
    );
  }
}
