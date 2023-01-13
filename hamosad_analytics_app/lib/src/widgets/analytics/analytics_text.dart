import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';

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

  static Text data(String data,
      {Color? color, TextAlign textAlign = TextAlign.center}) {
    return Text(
      data,
      style: AnalyticsTheme.dataTextStyle.copyWith(color: color),
      textAlign: textAlign,
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
