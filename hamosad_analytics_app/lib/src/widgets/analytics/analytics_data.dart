import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class AnalyticsDataChip extends StatelessWidget {
  const AnalyticsDataChip({Key? key, required this.title, required this.data})
      : super(key: key);

  final String title, data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: AnalyticsTheme.background1,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: AnalyticsText.dataSubtitle(
                title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 45.0,
              child: VerticalDivider(
                color: AnalyticsTheme.background3,
                thickness: 2,
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: AnalyticsText.data(data),
          ),
        ],
      ),
    );
  }
}

class AnalyticsDataWinRate extends StatelessWidget {
  const AnalyticsDataWinRate({Key? key, required this.won, required this.lost})
      : super(key: key);

  final int won, lost;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: AnalyticsTheme.background1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 10,
                child: AnalyticsText.data(
                  won.toString(),
                  color: AnalyticsTheme.secondary,
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
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: won,
                  child: Container(
                    height: 4.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.0),
                        bottomLeft: Radius.circular(2.0),
                      ),
                      color: AnalyticsTheme.secondary,
                    ),
                  ),
                ),
                Expanded(
                  flex: lost,
                  child: Container(
                    height: 4.0,
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
      ),
    );
  }
}
