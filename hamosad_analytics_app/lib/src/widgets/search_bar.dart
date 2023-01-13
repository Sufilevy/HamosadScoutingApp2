import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key, required this.onSubmitted}) : super(key: key);

  final void Function(String) onSubmitted;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AnalyticsTheme.background2,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: TextField(
        controller: _controller,
        cursorColor: AnalyticsTheme.primary,
        maxLines: 1,
        style: AnalyticsTheme.dataTitleTextStyle.copyWith(
          color: AnalyticsTheme.foreground2,
        ),
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: AnalyticsTheme.foreground2,
              size: 32.0,
            ),
          ),
          suffix: IconButton(
            onPressed: () {
              _controller.clear();
              onSubmitted(_controller.text);
            },
            icon: const Icon(Icons.clear_rounded),
            iconSize: 32.0,
            color: AnalyticsTheme.foreground2,
            padding: EdgeInsets.zero,
          ),
          hintText: 'Search for a team...',
          hintStyle: AnalyticsTheme.dataTitleTextStyle.copyWith(
            color: AnalyticsTheme.foreground2,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(
              color: AnalyticsTheme.background2,
              width: 1.0,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(width: 2.0),
          ),
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
