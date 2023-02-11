import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/constants.dart';

class SelectionButton<T> extends StatelessWidget {
  const SelectionButton({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.onChange,
    required this.textStyle,
    this.borderRadius,
    this.hint,
  }) : super(key: key);

  final Map<Widget, T> items;
  final Function(T?) onChange;
  final Widget? hint;
  final T? selectedValue;
  final TextStyle textStyle;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<T>> dropdownItems = [];
    items.forEach((Widget title, T value) {
      dropdownItems.add(DropdownMenuItem(value: value, child: title));
    });

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Consts.sectionDefultColor,
        border: Border.all(color: Colors.transparent, width: 2),
        borderRadius: BorderRadius.circular(
          borderRadius ?? Consts.defaultBorderRadiusSize,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: DropdownButton<T>(
          style: textStyle,
          hint: hint,
          dropdownColor: Consts.sectionDefultColor,
          value: selectedValue,
          onChanged: onChange,
          items: dropdownItems,
          isExpanded: true,
          underline: Container(),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}
