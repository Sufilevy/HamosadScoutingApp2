import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hamosad_analytics_app/constants.dart';

class SearchBox<T> extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.items,
    required this.itemDisplay,
    required this.onChange,
    required this.inputController,
    required this.hintText,
    required this.suggestionsFilter,
  });

  final List<T> items;
  final String Function(T) itemDisplay;
  final void Function(T) onChange;
  final TextEditingController inputController;
  final String hintText;
  final List<T> Function(String) suggestionsFilter;

  @override
  Widget build(final BuildContext context) {
    return TypeAheadFormField<T>(
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
          borderRadius: BorderRadius.circular(Consts.defaultBorderRadiusSize),
          color: Consts.sectionDefultColor),
      textFieldConfiguration: TextFieldConfiguration(
        onSubmitted: ((String suggestion) {
          onChange(
              items.where((item) => itemDisplay(item) == suggestion).first);
        }),
        onTap: inputController.clear,
        controller: inputController,
        style:
            const TextStyle(color: Consts.secondaryDisplayColor, fontSize: 24),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Consts.defaultBorderRadiusSize),
          ),
          contentPadding: EdgeInsets.zero,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.0),
          ),
          filled: true,
          fillColor: Consts.sectionDefultColor,
          focusColor: Consts.secondaryDisplayColor,
          prefixIcon: const Icon(
            Icons.search,
            color: Consts.secondaryDisplayColor,
            size: 27,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Consts.secondaryDisplayColor, fontSize: 24),
        ),
      ),
      suggestionsCallback: suggestionsFilter,
      itemBuilder: (final BuildContext context, final T suggestion) => ListTile(
        title: Text(
          itemDisplay(suggestion),
          style: const TextStyle(color: Consts.secondaryDisplayColor),
        ),
      ),
      transitionBuilder: (
        final BuildContext context,
        final Widget suggestionsBox,
        final AnimationController? controller,
      ) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: controller!,
            curve: Curves.fastOutSlowIn,
          ),
          child: suggestionsBox,
        );
      },
      noItemsFoundBuilder: (final BuildContext context) => const SizedBox(
        height: 60,
        child: Center(
          child: Text(
            'No items found',
            style: TextStyle(fontSize: 16, color: Consts.secondaryDisplayColor),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      onSuggestionSelected: (final T suggestion) {
        inputController.text = itemDisplay(suggestion);
        onChange(suggestion);
      },
    );
  }
}
