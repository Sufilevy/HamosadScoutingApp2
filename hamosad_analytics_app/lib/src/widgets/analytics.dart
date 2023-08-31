import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/app.dart';
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
    this.borderRadius,
    this.color = AnalyticsTheme.background2,
  }) : super(key: key);

  final Widget? child;
  final double? width, height;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final double? borderRadius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          (borderRadius ?? 5.0) * AnalyticsApp.size,
        ),
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
    this.width,
    this.height,
    this.color = AnalyticsTheme.background3,
  }) : super(key: key);

  final int flex;
  final double? width, height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: AnalyticsContainer(
        height: (height ?? 45.0) * AnalyticsApp.size,
        width: (width ?? 2.0) * AnalyticsApp.size,
        color: AnalyticsTheme.background3,
        borderRadius: 1.0 * AnalyticsApp.size,
      ),
    );
  }
}

class AnalyticsDataChip extends StatelessWidget {
  const AnalyticsDataChip(this.data, {Key? key, required this.title})
      : super(key: key);

  final String data, title;

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      width: 220.0 * AnalyticsApp.size,
      height: 70.0 * AnalyticsApp.size,
      color: AnalyticsTheme.background1,
      child: Row(
        children: [
          Expanded(
            flex: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0) * AnalyticsApp.size,
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
      width: 330.0 * AnalyticsApp.size,
      height: 70.0 * AnalyticsApp.size,
      color: AnalyticsTheme.background1,
      child: Row(
        children: [
          Expanded(
            flex: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0) * AnalyticsApp.size,
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
            child: AnalyticsText.data(
              average.toStringAsPrecision(3),
            ),
          ),
        ],
      );

  Widget _buildMinMax() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Icon(
                  Icons.arrow_circle_up_rounded,
                  size: 20.0 * AnalyticsApp.size,
                  color: AnalyticsTheme.foreground1,
                ),
              ),
              const EmptyExpanded(flex: 1),
              Expanded(
                flex: 30,
                child: AnalyticsText.dataSubtitle(
                  max.toString(),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Icon(
                  Icons.arrow_circle_down_rounded,
                  size: 20.0 * AnalyticsApp.size,
                  color: AnalyticsTheme.foreground1,
                ),
              ),
              const EmptyExpanded(flex: 1),
              Expanded(
                flex: 30,
                child: AnalyticsText.dataSubtitle(
                  min.toString(),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      );
}

class AnalyticsTwoRateChip extends StatelessWidget {
  const AnalyticsTwoRateChip({
    Key? key,
    required this.first,
    required this.second,
    this.title,
    this.inContainer = true,
    this.isPercent = true,
    this.firstColor = AnalyticsTheme.primary,
    this.secondColor = AnalyticsTheme.error,
  })  : assert(!inContainer || title != null),
        super(key: key);

  const AnalyticsTwoRateChip.pieces({
    super.key,
    required num cones,
    required num cubes,
    this.inContainer = true,
    this.isPercent = true,
    this.title,
  })  : assert(!inContainer || title != null),
        first = cones,
        second = cubes,
        firstColor = AnalyticsTheme.cones,
        secondColor = AnalyticsTheme.cubes;

  final String? title;
  final num first, second;
  final bool inContainer;
  final bool isPercent;
  final Color firstColor, secondColor;

  @override
  Widget build(BuildContext context) {
    return inContainer
        ? AnalyticsContainer(
            width: 220.0 * AnalyticsApp.size,
            height: 70.0 * AnalyticsApp.size,
            color: AnalyticsTheme.background1,
            child: Row(
              children: [
                Expanded(
                  flex: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0) *
                        AnalyticsApp.size,
                    child: AnalyticsText.dataSubtitle(
                      title!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const AnalyticsDataDivider(),
                Expanded(
                  flex: 50,
                  child: _buildRates(8.0 * AnalyticsApp.size, 4.0),
                ),
              ],
            ),
          )
        : _buildRates(3.0 * AnalyticsApp.size, 2.5);
  }

  Widget _buildRates(double gap, double barHeight) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 10,
                child: AnalyticsText.data(
                  (isPercent)
                      ? '${first.toDouble().toPercent().toStringAsPrecision(3)}%'
                      : first.toStringAsPrecision(3),
                  color: firstColor,
                  fontSize: 15.0 * AnalyticsApp.size,
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 25.0 * AnalyticsApp.size,
                  child: const VerticalDivider(
                    color: AnalyticsTheme.background3,
                    thickness: 2,
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: AnalyticsText.data(
                  (isPercent)
                      ? '${second.toDouble().toPercent().toStringAsPrecision(3)}%'
                      : second.toStringAsPrecision(3),
                  color: secondColor,
                  fontSize: 15.0 * AnalyticsApp.size,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0 * AnalyticsApp.size,
              right: 10.0 * AnalyticsApp.size,
              top: gap,
            ),
            child: (first == 0 && second == 0)
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
                        flex: (first * 10).toInt(),
                        child: Container(
                          height: barHeight,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(2.0),
                              bottomLeft: Radius.circular(2.0),
                            ),
                            color: firstColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: (second * 10).toInt(),
                        child: Container(
                          height: barHeight,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(2.0),
                              bottomRight: Radius.circular(2.0),
                            ),
                            color: secondColor,
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      );
}

class AnalyticsClimbsStatChip extends StatelessWidget {
  const AnalyticsClimbsStatChip(
    this.data, {
    Key? key,
    this.dockedByOther = true,
  }) : super(key: key);

  final ClimbingStateStat data;
  final bool dockedByOther;

  Widget _buildDivider() => Expanded(
        flex: 1,
        child: SizedBox(
          width: 15.0 * AnalyticsApp.size,
          height: 25.0 * AnalyticsApp.size,
          child: const VerticalDivider(
            color: AnalyticsTheme.background3,
            thickness: 2,
          ),
        ),
      );

  Widget _buildText(String text) => Expanded(
        flex: 10,
        child: Padding(
          padding: const EdgeInsets.all(12.0) * AnalyticsApp.size,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AnalyticsText.data(
              text,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      width: 400.0 * AnalyticsApp.size,
      height: 70.0 * AnalyticsApp.size,
      color: AnalyticsTheme.background1,
      child: Row(
        children: [
          _buildText(
              'No Attempt:\n${data.noAttemptRate.toPercent().toStringAsPrecision(3)}%'),
          _buildDivider(),
          _buildText(
              'Failed:\n${data.failedRate.toPercent().toStringAsPrecision(3)}%'),
          _buildDivider(),
          _buildText(
              'Docked:\n${data.dockedRate.toPercent().toStringAsPrecision(3)}%'),
          _buildDivider(),
          _buildText(
              'Engaged:\n${data.engagedRate.toPercent().toStringAsPrecision(3)}%'),
        ],
      ),
    );
  }
}

class AnalyticsDurationsStatChip extends StatelessWidget {
  const AnalyticsDurationsStatChip(
    this.data, {
    Key? key,
    required this.title,
  }) : super(key: key);

  final ActionDurationStat data;
  final String title;

  Widget _buildDivider() => SizedBox(
        width: 15.0 * AnalyticsApp.size,
        height: 25.0 * AnalyticsApp.size,
        child: const VerticalDivider(
          color: AnalyticsTheme.background3,
          thickness: 2.0,
        ),
      );

  Widget _buildText(String text, int index) => Expanded(
        flex: 8,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0) *
              AnalyticsApp.size,
          child: AnalyticsText.data(
            text,
            fontSize: 16.0 * AnalyticsApp.size,
            color: _durationColor(index / 2),
          ),
        ),
      );

  Color _durationColor(double t) => Color.lerp(
      AnalyticsTheme.primary, AnalyticsTheme.primary.withOpacity(0.65), t)!;

  Widget _buildBars() => Padding(
        padding: EdgeInsets.only(
          left: 10.0 * AnalyticsApp.size,
          right: 10.0 * AnalyticsApp.size,
          top: 4.0 * AnalyticsApp.size,
        ),
        child: (data.zeroToTwoRate == 0 &&
                data.twoToFiveRate == 0 &&
                data.fivePlusRate == 0.0)
            ? Container(
                height: 3.0,
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
                    flex: (data.zeroToTwoRate * 10).toInt(),
                    child: Container(
                      height: 3.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(2.0),
                          bottomLeft: Radius.circular(2.0),
                        ),
                        color: _durationColor(0.0),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (data.twoToFiveRate * 10).toInt(),
                    child: Container(
                      height: 3.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(2.0),
                          bottomRight: Radius.circular(2.0),
                        ),
                        color: _durationColor(0.5),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (data.fivePlusRate * 10).toInt(),
                    child: Container(
                      height: 3.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(2.0),
                          bottomRight: Radius.circular(2.0),
                        ),
                        color: _durationColor(1.0),
                      ),
                    ),
                  ),
                ],
              ),
      );

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      width: 400.0 * AnalyticsApp.size,
      height: 70.0 * AnalyticsApp.size,
      color: AnalyticsTheme.background1,
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnalyticsText.dataSubtitle(title),
            ),
          ),
          Expanded(
            flex: 1,
            child: _buildDivider(),
          ),
          Expanded(
            flex: 34,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildText(
                      '0-2:\n${data.zeroToTwoRate.toPercent().toStringAsPrecision(3)}%',
                      0,
                    ),
                    _buildDivider(),
                    _buildText(
                      '2-5:\n${data.twoToFiveRate.toPercent().toStringAsPrecision(3)}%',
                      1,
                    ),
                    _buildDivider(),
                    _buildText(
                      '5+:\n${data.fivePlusRate.toPercent().toStringAsPrecision(3)}%',
                      2,
                    ),
                  ],
                ),
                _buildBars(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnalyticsDefenseStatChip extends StatelessWidget {
  const AnalyticsDefenseStatChip(
    this.data, {
    Key? key,
    required this.title,
  }) : super(key: key);

  final DefenseIndexStat data;
  final String title;

  Widget _buildDivider() => SizedBox(
        width: 15.0 * AnalyticsApp.size,
        height: 25.0 * AnalyticsApp.size,
        child: const VerticalDivider(
          color: AnalyticsTheme.background3,
          thickness: 2.0,
        ),
      );

  Widget _buildText(String text, int index) => Expanded(
        flex: 8,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0) *
              AnalyticsApp.size,
          child: AnalyticsText.data(
            text,
            fontSize: 16.0 * AnalyticsApp.size,
            color: _durationColor(index / 2),
          ),
        ),
      );

  Color _durationColor(double t) => Color.lerp(
      AnalyticsTheme.primary, AnalyticsTheme.primary.withOpacity(0.65), t)!;

  Widget _buildBars() => Padding(
        padding: EdgeInsets.only(
          left: 10.0 * AnalyticsApp.size,
          right: 10.0 * AnalyticsApp.size,
          top: 4.0 * AnalyticsApp.size,
        ),
        child: (data.noneRate == 0 &&
                data.halfRate == 0 &&
                data.almostAllRate == 0.0)
            ? Container(
                height: 3.0,
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
                    flex: (data.noneRate * 10).toInt(),
                    child: Container(
                      height: 3.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(2.0),
                          bottomLeft: Radius.circular(2.0),
                        ),
                        color: _durationColor(0.0),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (data.halfRate * 10).toInt(),
                    child: Container(
                      height: 3.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(2.0),
                          bottomRight: Radius.circular(2.0),
                        ),
                        color: _durationColor(0.5),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (data.almostAllRate * 10).toInt(),
                    child: Container(
                      height: 3.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(2.0),
                          bottomRight: Radius.circular(2.0),
                        ),
                        color: _durationColor(1.0),
                      ),
                    ),
                  ),
                ],
              ),
      );

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      width: 400.0 * AnalyticsApp.size,
      height: 70.0 * AnalyticsApp.size,
      color: AnalyticsTheme.background1,
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnalyticsText.dataSubtitle(title),
            ),
          ),
          Expanded(
            flex: 1,
            child: _buildDivider(),
          ),
          Expanded(
            flex: 34,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildText(
                      'None:\n${data.noneRate.toPercent().toStringAsPrecision(3)}%',
                      0,
                    ),
                    _buildDivider(),
                    _buildText(
                      'Half:\n${data.halfRate.toPercent().toStringAsPrecision(3)}%',
                      1,
                    ),
                    _buildDivider(),
                    _buildText(
                      'Almost all:\n${data.almostAllRate.toPercent().toStringAsPrecision(3)}%',
                      2,
                    ),
                  ],
                ),
                _buildBars(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnalyticsNotes extends StatelessWidget {
  const AnalyticsNotes(
    this.team, {
    Key? key,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0) * AnalyticsApp.size,
        children: [
          if (team.summary.notes.isNotEmpty) ...[
            _buildTitle('Summary Notes'),
            _buildNotes(team.summary.notes),
          ],
          if (team.summary.fouls.isNotEmpty) ...[
            _buildTitle('Fouls'),
            _buildNotes(team.summary.fouls),
          ],
          if (team.summary.defenseNotes.isNotEmpty) ...[
            _buildTitle('Defense Notes'),
            _buildNotes(team.summary.defenseNotes),
          ],
          if (team.auto.notes.isNotEmpty) ...[
            _buildTitle('Auto Notes'),
            _buildNotes(team.auto.notes),
          ],
          if (team.teleop.notes.isNotEmpty) ...[
            _buildTitle('Teleop Notes'),
            _buildNotes(team.teleop.notes),
          ],
          if (team.endgame.notes.isNotEmpty) ...[
            _buildTitle('Endgame Notes'),
            _buildNotes(team.endgame.notes),
          ],
        ],
      ),
    );
  }

  Widget _buildTitle(String title) => Center(
        child: Padding(
          padding: const EdgeInsets.all(6.0) * AnalyticsApp.size,
          child: AnalyticsText.dataTitle(title),
        ),
      );

  Widget _buildNotes(List<String> notes) => Column(
        children: [
          ...notes
              .map(
                (note) => Padding(
                  padding:
                      const EdgeInsets.only(bottom: 12.0) * AnalyticsApp.size,
                  child: AnalyticsContainer(
                    color: AnalyticsTheme.background1,
                    width: 1100.0 * AnalyticsApp.size,
                    height: 70.0 * AnalyticsApp.size,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0) *
                          AnalyticsApp.size,
                      child: AnalyticsText.dataSubtitle(
                        note,
                        maxLines: 3,
                        fittedBox: false,
                        textAlign: TextAlign.center,
                        fontSize: 15.0 * AnalyticsApp.size,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      );
}

class AnalyticsText {
  static Text navigation(
    String data, {
    Color? color,
  }) {
    return Text(
      data,
      style: AnalyticsTheme.navigationTextStyle.copyWith(
        color: color,
      ),
    );
  }

  static Widget dataTitle(
    String data, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data,
        style: AnalyticsTheme.dataTitleTextStyle.copyWith(
          color: color,
          fontWeight: fontWeight,
        ),
        textAlign: textAlign,
      ),
    );
  }

  static Widget dataSubtitle(
    String data, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    TextAlign? textAlign,
    int? maxLines,
    bool fittedBox = true,
  }) {
    return fittedBox
        ? FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              data,
              style: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
                color: color,
                fontWeight: fontWeight,
                fontSize: fontSize,
              ),
              maxLines: maxLines,
              softWrap: true,
              textAlign: textAlign,
            ),
          )
        : Text(
            data,
            style: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
              color: color,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
            maxLines: maxLines,
            textAlign: textAlign,
          );
  }

  static Widget data(
    String data, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    double? fontSize,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data,
        style: AnalyticsTheme.dataTextStyle.copyWith(
          color: color,
          fontSize: fontSize,
        ),
        textAlign: textAlign,
      ),
    );
  }

  static Widget logo(
    String data, {
    Color? color,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data,
        style: AnalyticsTheme.logoTextStyle.copyWith(color: color),
      ),
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
        SizedBox(width: 30.0 * AnalyticsApp.size),
        SizedBox(
          width: 120.0 * AnalyticsApp.size,
          height: 30.0 * AnalyticsApp.size,
          child: Align(
            alignment: Alignment.centerRight,
            child: AnalyticsText.dataTitle(title),
          ),
        ),
        SizedBox(
          width: 50.0 * AnalyticsApp.size,
          height: 30.0 * AnalyticsApp.size,
          child: VerticalDivider(
            color: AnalyticsTheme.foreground1,
            thickness: 1.5,
            width: 30.0 * AnalyticsApp.size,
          ),
        ),
        SizedBox(
          width: 450.0 * AnalyticsApp.size,
          height: 30.0 * AnalyticsApp.size,
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnalyticsText.dataSubtitle(subtitle),
          ),
        ),
      ],
    );
  }
}
