import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class AnalyticsFadeSwitcher extends StatelessWidget {
  const AnalyticsFadeSwitcher({
    Key? key,
    required this.child,
    this.duration,
  }) : super(key: key);

  final Widget child;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration ?? 250.milliseconds,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: child,
    );
  }
}

class AnalyticsContainer extends StatelessWidget {
  const AnalyticsContainer({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.border,
    this.borderRadius = 5.0,
    this.color = AnalyticsTheme.background2,
  }) : super(key: key);

  final Widget? child;
  final double? width, height;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final double borderRadius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
      ),
      alignment: alignment,
      child: child,
    );
  }
}

class AnalyticsDataDivider extends StatelessWidget {
  const AnalyticsDataDivider({
    Key? key,
    this.flex = 1,
    this.width = 2.0,
    this.height = 45.0,
    this.color = AnalyticsTheme.background3,
  }) : super(key: key);

  final int flex;
  final double width, height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: AnalyticsContainer(
        height: height,
        width: width,
        color: AnalyticsTheme.background3,
        borderRadius: 1.0,
      ),
    );
  }
}

class AnalyticsDataChip extends StatelessWidget {
  const AnalyticsDataChip({Key? key, required this.title, required this.data})
      : super(key: key);

  final String title, data;

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      width: 220,
      height: 70,
      color: AnalyticsTheme.background1,
      child: Row(
        children: [
          Expanded(
            flex: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: AnalyticsText.dataSubtitle(
                title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const EmptyExpanded(flex: 1),
          const AnalyticsDataDivider(),
          const EmptyExpanded(flex: 1),
          Expanded(
            flex: 30,
            child: AnalyticsText.data(data),
          ),
        ],
      ),
    );
  }
}

class AnalyticsStatChip extends StatelessWidget {
  const AnalyticsStatChip({
    Key? key,
    required this.title,
    required this.average,
    required this.min,
    required this.max,
  }) : super(key: key);

  AnalyticsStatChip.fromStat(Stat stat, {super.key, required this.title})
      : average = stat.average,
        min = stat.min,
        max = stat.max;

  final String title;
  final num average, min, max;

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      width: 330,
      height: 70,
      color: AnalyticsTheme.background1,
      child: Row(
        children: [
          Expanded(
            flex: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: AnalyticsText.dataSubtitle(
                title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const EmptyExpanded(flex: 5),
          const AnalyticsDataDivider(),
          const EmptyExpanded(flex: 5),
          Expanded(
            flex: 40,
            child: _buildAverage(),
          ),
          const EmptyExpanded(flex: 5),
          const AnalyticsDataDivider(),
          const EmptyExpanded(flex: 5),
          Expanded(
            flex: 40,
            child: _buildMinMax(),
          ),
        ],
      ),
    );
  }

  Widget _buildAverage() => Row(
        children: [
          Expanded(
            flex: 5,
            child: AnalyticsText.dataSubtitle(
              'Avg.',
              color: AnalyticsTheme.primary,
            ),
          ),
          Expanded(
            flex: 4,
            child: AnalyticsText.data(average.toString()),
          ),
        ],
      );

  Widget _buildMinMax() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const Expanded(
                flex: 5,
                child: Icon(
                  Icons.arrow_circle_up_rounded,
                  size: 20.0,
                  color: AnalyticsTheme.foreground1,
                ),
              ),
              const EmptyExpanded(flex: 1),
              Expanded(
                flex: 8,
                child: AnalyticsText.dataSubtitle(max.toString()),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                flex: 5,
                child: Icon(
                  Icons.arrow_circle_down_rounded,
                  size: 20.0,
                  color: AnalyticsTheme.foreground1,
                ),
              ),
              const EmptyExpanded(flex: 1),
              Expanded(
                flex: 8,
                child: AnalyticsText.dataSubtitle(min.toString()),
              ),
            ],
          ),
        ],
      );
}

class AnalyticsDataWinRate extends StatelessWidget {
  const AnalyticsDataWinRate({
    Key? key,
    required this.won,
    required this.lost,
    this.inContainer = true,
  }) : super(key: key);

  final int won, lost;
  final bool inContainer;

  @override
  Widget build(BuildContext context) {
    return inContainer
        ? AnalyticsContainer(
            width: 220,
            height: 70,
            color: AnalyticsTheme.background1,
            child: _buildWinRate(8.0, 4.0),
          )
        : _buildWinRate(3.0, 2.5);
  }

  Widget _buildWinRate(double gap, double barHeight) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 10,
                child: AnalyticsText.data(
                  won.toString(),
                  color: AnalyticsTheme.primary,
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 25.0,
                  child: VerticalDivider(
                    color: AnalyticsTheme.background3,
                    thickness: 2,
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: AnalyticsText.data(
                  lost.toString(),
                  color: AnalyticsTheme.error,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: gap),
            child: (won == 0 && lost == 0)
                ? Container(
                    height: barHeight,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.0),
                        bottomLeft: Radius.circular(2.0),
                      ),
                      color: AnalyticsTheme.background3,
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: won,
                        child: Container(
                          height: barHeight,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.0),
                              bottomLeft: Radius.circular(2.0),
                            ),
                            color: AnalyticsTheme.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: lost,
                        child: Container(
                          height: barHeight,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(2.0),
                              bottomRight: Radius.circular(2.0),
                            ),
                            color: AnalyticsTheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      );
}

class AnalyticsText {
  static Text navigation(String data) {
    return Text(
      data,
      style: AnalyticsTheme.navigationTextStyle,
    );
  }

  static Text dataTitle(
    String data, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return Text(
      data,
      style: AnalyticsTheme.dataTitleTextStyle.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }

  static Text dataSubtitle(
    String data, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return Text(
      data,
      style: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }

  static Text data(
    String data, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      data,
      style: AnalyticsTheme.dataTextStyle.copyWith(color: color),
      textAlign: textAlign,
    );
  }

  static Text logo(
    String data, {
    Color? color,
  }) {
    return Text(
      data,
      style: AnalyticsTheme.logoTextStyle.copyWith(color: color),
    );
  }
}

class AnalyticsPageTitle extends StatelessWidget {
  const AnalyticsPageTitle({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          height: 30,
          child: Align(
            alignment: Alignment.centerRight,
            child: AnalyticsText.dataTitle(title),
          ),
        ),
        const SizedBox(
          width: 20,
          height: 30,
          child: VerticalDivider(
            color: AnalyticsTheme.foreground1,
            thickness: 1.5,
            width: 30,
          ),
        ),
        SizedBox(
          width: 450,
          height: 30,
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnalyticsText.dataSubtitle(subtitle),
          ),
        ),
      ],
    );
  }
}
