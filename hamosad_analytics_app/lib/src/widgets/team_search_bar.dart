import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hamosad_analytics_app/src/app.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/widgets/analytics.dart';

class TeamSearchBar extends StatelessWidget {
  TeamSearchBar({
    Key? key,
    required this.suggestions,
    this.onSubmitted,
    this.hintText,
    this.borderColor,
    this.cursorColor,
    this.searchIconColor,
    this.underlineBorder = false,
    this.searchOnIconPressed = true,
    String currentQuery = '',
  })  : _controller = TextEditingController(text: currentQuery),
        super(key: key);

  final void Function(String)? onSubmitted;
  final String? hintText;
  final Color? borderColor, cursorColor, searchIconColor;
  final bool underlineBorder, searchOnIconPressed;
  final List<String> suggestions;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      suggestionsCallback: (query) {
        if (query.isEmpty) {
          return suggestions;
        }

        return suggestions.where(
          (suggestion) =>
              suggestion.toLowerCase().contains(query.toLowerCase()),
        );
      },
      hideOnLoading: true,
      hideOnError: true,
      hideOnEmpty: true,
      getImmediateSuggestions: true,
      onSuggestionSelected: (value) => onSubmitted?.call(value),
      itemBuilder: (context, itemData) => AnalyticsContainer(
        borderRadius: 0.0,
        padding: const EdgeInsets.all(6.0) * AnalyticsApp.size,
        child: AnalyticsText.dataSubtitle(itemData),
      ),
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        color: AnalyticsTheme.background2,
        borderRadius: BorderRadius.circular(20.0) * AnalyticsApp.size,
        constraints: BoxConstraints(
          maxHeight: 600.0 * AnalyticsApp.size,
        ),
      ),
      animationDuration: 250.milliseconds,
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        cursorColor: cursorColor ?? AnalyticsTheme.primary,
        style: AnalyticsTheme.dataTitleTextStyle.copyWith(
          color: AnalyticsTheme.foreground2,
        ),
        autocorrect: false,
        maxLines: 1,
        onSubmitted: onSubmitted,
        cursorRadius: const Radius.circular(1.0) * AnalyticsApp.size,
        cursorWidth: 1.5 * AnalyticsApp.size,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0) * AnalyticsApp.size,
          suffixIcon: IconButton(
            onPressed: searchOnIconPressed
                ? () => onSubmitted?.call(_controller.text)
                : null,
            icon: const Icon(Icons.search_rounded),
            iconSize: 32.0 * AnalyticsApp.size,
            color: searchIconColor ?? AnalyticsTheme.foreground2,
            disabledColor: searchIconColor ?? AnalyticsTheme.foreground2,
            splashRadius: 1.0,
          ),
          hintText: hintText,
          hintStyle: AnalyticsTheme.dataTitleTextStyle.copyWith(
            color: AnalyticsTheme.foreground2,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? AnalyticsTheme.primaryVariant,
              width: 2.0,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(1.0),
            borderSide: BorderSide(
              width: 2,
              color: underlineBorder
                  ? AnalyticsTheme.foreground2
                  : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
