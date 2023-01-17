import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/database.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sidebarx/sidebarx.dart';

class Sidebar extends StatefulWidget {
  const Sidebar(
    this.sidebarController, {
    Key? key,
    required this.items,
    this.onRefreshData,
  }) : super(key: key);

  final SidebarXController sidebarController;
  final List<SidebarXItem> items;
  final VoidCallback? onRefreshData;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: widget.sidebarController,
      showToggleButton: false,
      headerBuilder: (context, extended) => _sidebarLogo(),
      headerDivider: _headerDivider(),
      footerBuilder: (context, extended) => _refreshDataButton(),
      theme: _theme(),
      extendedTheme: const SidebarXTheme(
        width: 200.0,
        decoration: BoxDecoration(color: AnalyticsTheme.background2),
      ),
      items: widget.items,
    );
  }

  Widget _sidebarLogo() => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 9.0,
              left: 9.0,
              right: 12.0,
            ),
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: SvgPicture.asset('assets/svg/logo.svg'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 9.0),
            child: Text(
              'Hamosad\nAnalytics',
              style: AnalyticsTheme.logoTextStyle,
            ),
          ),
        ],
      );

  Widget _headerDivider() => Container(
        height: 1.5,
        width: 114,
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.5),
          color: AnalyticsTheme.primary,
        ),
        margin: const EdgeInsets.only(left: 34.0, top: 3.0, bottom: 15.0),
      );

  Widget _refreshDataButton() => const Padding(
        padding: EdgeInsets.all(40.0),
        child: RefreshDataButton(),
      );

  SidebarXTheme _theme() => SidebarXTheme(
        width: 68.0,
        decoration: const BoxDecoration(color: AnalyticsTheme.background2),
        hoverColor: AnalyticsTheme.background2,
        textStyle: AnalyticsTheme.navigationTextStyle,
        selectedTextStyle: AnalyticsTheme.navigationTextStyle,
        itemMargin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        selectedItemMargin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        itemTextPadding: const EdgeInsets.only(left: 7.0),
        selectedItemTextPadding: const EdgeInsets.only(left: 7.0),
        itemDecoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: AnalyticsTheme.background3,
        ),
        iconTheme: const IconThemeData(
          color: AnalyticsTheme.foreground1,
          size: 28.0,
        ),
        selectedIconTheme: const IconThemeData(
          color: AnalyticsTheme.foreground1,
          size: 28.0,
        ),
      );
}

class RefreshDataButton extends StatefulWidget {
  const RefreshDataButton({Key? key}) : super(key: key);

  @override
  State<RefreshDataButton> createState() => _RefreshDataButtonState();
}

class _RefreshDataButtonState extends State<RefreshDataButton>
    with SingleTickerProviderStateMixin {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) => RotationTransition(
        turns: Tween(begin: -0.4, end: -1.0).animate(animation),
        child: ScaleTransition(
          scale: animation,
          alignment: Alignment.center,
          child: child,
        ),
      ),
      child: Container(
        key: ValueKey<bool>(_loading),
        alignment: Alignment.center,
        child: _loading ? _loadingIndicator() : _refreshButton(),
      ),
    );
  }

  Widget _loadingIndicator() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: AnalyticsTheme.primary,
          size: 70.0,
        ),
      );

  Widget _refreshButton() => IconButton(
        iconSize: 70.0,
        icon: const Icon(
          Icons.refresh_rounded,
          color: AnalyticsTheme.primary,
          size: 70.0,
        ),
        onPressed: () async {
          setState(() {});
          _loading = true;
          await Future.wait([
            Future.delayed(const Duration(milliseconds: 1000)),
            getData(),
          ]);
          _loading = false;
          setState(() {});
        },
      );
}
