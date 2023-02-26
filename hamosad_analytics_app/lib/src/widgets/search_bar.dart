import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
    this.onSubmitted,
    this.hintText,
    this.borderColor,
    this.cursorColor,
    this.searchIconColor,
    this.underlineBorder = false,
    TextEditingController? controller,
    String currentQuery = '',
  })  : _controller = controller ?? TextEditingController(text: currentQuery),
        super(key: key);

  final void Function(String)? onSubmitted;
  final String? hintText;
  final Color? borderColor, cursorColor, searchIconColor;
  final bool underlineBorder;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      child: TextField(
        controller: _controller,
        onSubmitted: onSubmitted,
        cursorColor: cursorColor ?? AnalyticsTheme.primary,
        maxLines: 1,
        style: AnalyticsTheme.dataTitleTextStyle.copyWith(
          color: AnalyticsTheme.foreground2,
        ),
        autocorrect: false,
        strutStyle: StrutStyle.fromTextStyle(AnalyticsTheme.dataTitleTextStyle),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16.0),
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
            onPressed: () {
              if (onSubmitted != null) onSubmitted!(_controller.text);
            },
            icon: const Icon(Icons.search_rounded),
            iconSize: 32.0,
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
