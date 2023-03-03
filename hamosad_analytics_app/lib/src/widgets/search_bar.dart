import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/app.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/widgets/analytics.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.suggestions,
    this.onSubmitted,
    this.hintText,
    this.borderColor,
    this.cursorColor,
    this.searchIconColor,
    this.underlineBorder = false,
    String currentQuery = '',
  }) : super(key: key);

  final void Function(String)? onSubmitted;
  final String? hintText;
  final Color? borderColor, cursorColor, searchIconColor;
  final bool underlineBorder;
  final List<String> suggestions;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      onSelected: (value) {
        if (onSubmitted != null) onSubmitted!(value);
      },
      optionsBuilder: (query) {
        if (query.text.isEmpty) {
          return const Iterable<String>.empty();
        }

        return suggestions.where(
          (suggestion) =>
              suggestion.toLowerCase().contains(query.text.toLowerCase()),
        );
      },
      optionsMaxHeight: 600.0 * AnalyticsApp.size,
      optionsViewBuilder: (context, onSelected, options) => ListView.builder(
        itemBuilder: (context, index) => AnalyticsText.dataSubtitle(
          options.elementAt(index),
        ),
      ),
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              TextField(
        controller: textEditingController,
        onSubmitted: onSubmitted,
        cursorColor: cursorColor ?? AnalyticsTheme.primary,
        maxLines: 1,
        style: AnalyticsTheme.dataTitleTextStyle.copyWith(
          color: AnalyticsTheme.foreground2,
        ),
        autocorrect: false,
        strutStyle: StrutStyle.fromTextStyle(AnalyticsTheme.dataTitleTextStyle),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0 * AnalyticsApp.size),
          focusedBorder: underlineBorder
              ? UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(1.5),
                  borderSide: BorderSide(
                    width: 3.0,
                    color: borderColor ?? AnalyticsTheme.foreground2,
                  ),
                )
              : OutlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor ?? AnalyticsTheme.primaryVariant,
                    width: 2.0,
                  ),
                ),
          suffixIcon: IconButton(
            onPressed: onFieldSubmitted,
            icon: const Icon(Icons.search_rounded),
            iconSize: 32.0 * AnalyticsApp.size,
            color: searchIconColor ?? AnalyticsTheme.foreground2,
            splashRadius: 1.0,
          ),
          hintText: hintText,
          hintStyle: AnalyticsTheme.dataTitleTextStyle.copyWith(
            color: AnalyticsTheme.foreground2,
          ),
          enabledBorder: underlineBorder
              ? UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(1.5),
                  borderSide: const BorderSide(
                    width: 3.0,
                    color: AnalyticsTheme.foreground2,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
