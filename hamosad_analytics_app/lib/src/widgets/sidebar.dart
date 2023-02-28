import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamosad_analytics_app/src/app.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/database.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:sidebarx/sidebarx.dart';

class Sidebar extends ConsumerStatefulWidget {
  const Sidebar(
    this.sidebarController, {
    Key? key,
    required this.items,
  }) : super(key: key);

  final SidebarXController sidebarController;
  final List<SidebarXItem> items;

  @override
  ConsumerState<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends ConsumerState<Sidebar> {
  String? _dropdownValue;

  @override
  void initState() {
    _dropdownValue = ref.read(analyticsDatabaseProvider).districts.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: widget.sidebarController,
      showToggleButton: false,
      headerBuilder: (context, extended) => _buildSidebarLogo(),
      headerDivider: _buildHeaderDivider(),
      footerBuilder: (context, extended) => Column(
        children: [
          _buildSelectDistricts(),
          // _buildRefreshDataButton(),
        ],
      ),
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
        child: const RefreshDataButton(),
      );

  Widget _buildSelectDistricts() {
    final db = ref.read(analyticsDatabaseProvider);
    return Padding(
      padding: const EdgeInsets.all(40.0) * AnalyticsApp.size,
      child: TextButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => MultiSelectDialog(
            backgroundColor: AnalyticsTheme.background2,
            checkColor: AnalyticsTheme.foreground1,
            selectedColor: AnalyticsTheme.primaryVariant,
            unselectedColor: AnalyticsTheme.foreground2,
            itemsTextStyle: AnalyticsTheme.dataTitleTextStyle.copyWith(
              color: AnalyticsTheme.foreground2,
            ),
            selectedItemsTextStyle: AnalyticsTheme.dataTitleTextStyle.copyWith(
              color: AnalyticsTheme.foreground2,
            ),
            title: Text(
              'Select districts:',
              textAlign: TextAlign.center,
              style: AnalyticsTheme.dataTitleTextStyle.copyWith(
                fontSize: 26.0,
                color: AnalyticsTheme.foreground2,
              ),
            ),
            cancelText: Text(
              'CANCEL',
              style: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
                color: AnalyticsTheme.foreground2,
                fontWeight: FontWeight.w500,
              ),
            ),
            confirmText: Text(
              'CONFIRM',
              style: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
                color: AnalyticsTheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            height: 600.0 * AnalyticsApp.size,
            width: 500.0 * AnalyticsApp.size,
            onConfirm: (selectedDistricts) => db.setSelectedDistrict(
              selectedDistricts.mapNotNull((e) => e.toString()).toList(),
            ),
            items: db.districts
                .map((data) => MultiSelectItem(data, data))
                .toList(),
            initialValue: db.selectedDistricts,
          ),
        ),
        child: AnalyticsText.data('Select Districts'),
      ),
    );
  }

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

class RefreshDataButton extends ConsumerStatefulWidget {
  const RefreshDataButton({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RefreshDataButton> createState() => _RefreshDataButtonState();
}

class _RefreshDataButtonState extends ConsumerState<RefreshDataButton>
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
          await ref.read(analyticsDatabaseProvider).updateFromFirestore();
          _loading = false;
          setState(() {});
        },
      );
}
