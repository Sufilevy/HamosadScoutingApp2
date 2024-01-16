import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '/services/utilities.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class AnalyticsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AnalyticsAppBar({
    super.key,
    required this.title,
    this.titleAvatar,
    this.actions = const <Widget>[],
  });

  final String title;
  final Widget? titleAvatar;
  final List<Widget> actions;

  @override
  Size get preferredSize => Size.fromHeight(55 * AnalyticsTheme.appSizeRatio);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _title().padRight(titleAvatar == null ? 0 : 50),
      leading: _menuButton(context),
      leadingWidth: 66 * AnalyticsTheme.appSizeRatio,
      actions: [
        ...actions,
        Gap(10 * AnalyticsTheme.appSizeRatio),
      ],
    );
  }

  Widget _title() {
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

  Widget _menuButton(BuildContext context) {
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
        children: [
          const DrawerHeader(),
          Gap(5 * AnalyticsTheme.appSizeRatio),
          _pageTile(
            context,
            'Team Details',
            FontAwesomeIcons.peopleGroup,
            '/team',
          ),
          _pageTile(
            context,
            'Compare Teams',
            FontAwesomeIcons.chartLine,
            '/compare',
          ),
        ],
      ),
    );
  }

  double _drawerWidth(double screenWidth) => math.max(screenWidth / 2, 300);

  Widget _pageTile(BuildContext context, String title, IconData icon, String pageUri) {
    return padSymmetric(
      vertical: 5,
      horizontal: 12,
      ListTile(
        leading: Icon(
          icon,
          color: AnalyticsTheme.primaryVariant,
        ),
        title: navigationTitleText(title),
        onTap: () {
          Scaffold.of(context).closeDrawer();
          context.go(pageUri);
        },
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100 * AnalyticsTheme.appSizeRatio,
      decoration: _headerDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _logo(),
          Gap(12 * AnalyticsTheme.appSizeRatio),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logoText('Hamosad Analytics'),
              _titleUnderline(),
            ],
          ),
          Gap(6 * AnalyticsTheme.appSizeRatio),
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

  Widget _logo() {
    return SvgPicture.asset(
      'assets/svg/logo.svg',
      width: 50 * AnalyticsTheme.appSizeRatioSquared,
      height: 50 * AnalyticsTheme.appSizeRatioSquared,
    );
  }

  Widget _titleUnderline() {
    return Container(
      width: 240 * AnalyticsTheme.appSizeRatio,
      height: 2 * AnalyticsTheme.appSizeRatio,
      decoration: BoxDecoration(
        color: AnalyticsTheme.primary.withOpacity(0.7),
        borderRadius: BorderRadius.circular(4),
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

class AnalyticsBottomNavigationBar extends StatefulWidget {
  const AnalyticsBottomNavigationBar({
    super.key,
    required this.items,
    this.onTap,
    this.showLabels = true,
  });

  final List<BottomNavigationBarItem> items;
  final void Function(int newIndex)? onTap;
  final bool showLabels;

  @override
  State<AnalyticsBottomNavigationBar> createState() => _AnalyticsBottomNavigationBarState();
}

class _AnalyticsBottomNavigationBarState extends State<AnalyticsBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: widget.items,
      currentIndex: _currentIndex,
      onTap: (newIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
        widget.onTap?.call(newIndex);
      },
      showSelectedLabels: widget.showLabels,
      showUnselectedLabels: widget.showLabels,
      backgroundColor: AnalyticsTheme.background1,
      selectedIconTheme: const IconThemeData(color: AnalyticsTheme.primary),
      unselectedIconTheme: const IconThemeData(color: AnalyticsTheme.foreground2),
      selectedLabelStyle: AnalyticsTheme.navigationStyle.copyWith(
        fontSize: 22 * AnalyticsTheme.appSizeRatio,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: AnalyticsTheme.navigationStyle.copyWith(
        fontSize: 22 * AnalyticsTheme.appSizeRatio,
        fontWeight: FontWeight.w400,
      ),
      selectedItemColor: AnalyticsTheme.primary,
      unselectedItemColor: AnalyticsTheme.foreground2,
      type: BottomNavigationBarType.shifting,
    );
  }
}
