import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key, required this.onSubmitted}) : super(key: key);

  final void Function(String) onSubmitted;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      child: TextField(
        controller: _controller,
        cursorColor: AnalyticsTheme.primary,
        maxLines: 1,
        style: AnalyticsTheme.dataTitleTextStyle.copyWith(
          color: AnalyticsTheme.foreground2,
        ),
        autocorrect: false,
        strutStyle: StrutStyle.fromTextStyle(AnalyticsTheme.dataTitleTextStyle),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AnalyticsTheme.primaryVariant,
              width: 2.0,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              onSubmitted(_controller.text);
              _controller.clear();
            },
            icon: const Icon(Icons.search_rounded),
            iconSize: 32.0,
            color: AnalyticsTheme.foreground2,
            splashRadius: 1.0,
          ),
          hintText: 'Search for a team...',
          hintStyle: AnalyticsTheme.dataTitleTextStyle.copyWith(
            color: AnalyticsTheme.foreground2,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: AnalyticsTheme.background2,
              width: 1.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(width: 2.0),
          ),
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
