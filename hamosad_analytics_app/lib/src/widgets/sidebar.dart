import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamosad_analytics_app/src/app.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';
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
      headerBuilder: (context, extended) => _buildSidebarLogo(),
      headerDivider: _buildHeaderDivider(),
      footerBuilder: (context, extended) => _buildRefreshDataButton(),
      theme: _theme(),
      extendedTheme: SidebarXTheme(
        width: 200.0 * AnalyticsApp.size,
        decoration: const BoxDecoration(color: AnalyticsTheme.background2),
      ),
      items: widget.items,
    );
  }

  Widget _buildSidebarLogo() => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                  top: 9.0,
                  left: 9.0,
                  right: 12.0,
                ) *
                AnalyticsApp.size,
            child: SizedBox(
              width: 50.0 * AnalyticsApp.size,
              height: 50.0 * AnalyticsApp.size,
              child: SvgPicture.asset('assets/svg/logo.svg'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 9.0 * AnalyticsApp.size),
            child: AnalyticsText.logo('Hamosad\nAnalytics'),
          ),
        ],
      );

  Widget _buildHeaderDivider() => Container(
        height: 1.5 * AnalyticsApp.size,
        width: 114.0 * AnalyticsApp.size,
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.5),
          color: AnalyticsTheme.primary,
        ),
        margin: EdgeInsets.only(
          left: 34.0 * AnalyticsApp.size,
          top: 3.0 * AnalyticsApp.size,
          bottom: 15.0 * AnalyticsApp.size,
        ),
      );

  Widget _buildRefreshDataButton() => Padding(
        padding: EdgeInsets.all(40.0 * AnalyticsApp.size),
        child: RefreshDataButton(onPressed: widget.onRefreshData),
      );

  SidebarXTheme _theme() => SidebarXTheme(
        width: 68.0 * AnalyticsApp.size,
        decoration: const BoxDecoration(color: AnalyticsTheme.background2),
        hoverColor: AnalyticsTheme.background2,
        textStyle: AnalyticsTheme.navigationTextStyle,
        selectedTextStyle: AnalyticsTheme.navigationTextStyle,
        itemMargin: EdgeInsets.symmetric(
          vertical: 10.0 * AnalyticsApp.size,
          horizontal: 10.0 * AnalyticsApp.size,
        ),
        selectedItemMargin: EdgeInsets.symmetric(
          vertical: 10.0 * AnalyticsApp.size,
          horizontal: 10.0 * AnalyticsApp.size,
        ),
        itemTextPadding: EdgeInsets.only(left: 7.0 * AnalyticsApp.size),
        selectedItemTextPadding: EdgeInsets.only(left: 7.0 * AnalyticsApp.size),
        itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0 * AnalyticsApp.size)),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0 * AnalyticsApp.size),
          color: AnalyticsTheme.background3,
        ),
        iconTheme: IconThemeData(
          color: AnalyticsTheme.foreground1,
          size: 28.0 * AnalyticsApp.size,
        ),
        selectedIconTheme: IconThemeData(
          color: AnalyticsTheme.foreground1,
          size: 28.0 * AnalyticsApp.size,
        ),
      );
}

class RefreshDataButton extends StatefulWidget {
  const RefreshDataButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  State<RefreshDataButton> createState() => _RefreshDataButtonState();
}

class _RefreshDataButtonState extends State<RefreshDataButton>
    with SingleTickerProviderStateMixin {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 250.milliseconds,
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
        child: _loading ? _buildLoadingIndicator() : _buildRefreshButton(),
      ),
    );
  }

  Widget _buildLoadingIndicator() => Padding(
        padding: EdgeInsets.all(8.0 * AnalyticsApp.size),
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: AnalyticsTheme.primary,
          size: 70.0 * AnalyticsApp.size,
        ),
      );

  Widget _buildRefreshButton() => IconButton(
        iconSize: 70.0 * AnalyticsApp.size,
        icon: Icon(
          Icons.refresh_rounded,
          color: AnalyticsTheme.primary,
          size: 70.0 * AnalyticsApp.size,
        ),
        onPressed: () async {
          setState(() {});
          _loading = true;
          await Future.wait([
            Future.delayed(1500.milliseconds),
          ]);
          if (widget.onPressed != null) widget.onPressed!();
          _loading = false;
          setState(() {});
        },
      );
}
