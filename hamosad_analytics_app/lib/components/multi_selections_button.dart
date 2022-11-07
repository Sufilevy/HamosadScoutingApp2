import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MultiSelectionsButton extends StatelessWidget {
  const MultiSelectionsButton({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.button,
    required this.onChange,
    required this.hint,
  });

  final List<String> items;
  final List<String> selectedItems;
  final Widget button;
  final Function(List<String>) onChange;
  final Widget hint;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton2(
      isExpanded: true,
      hint: Align(
        alignment: AlignmentDirectional.center,
        child: hint,
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          //disable default onTap to avoid closing menu when selecting an item
          enabled: false,
          child: StatefulBuilder(
            builder: (context, menuSetState) {
              final _isSelected = selectedItems.contains(item);
              return InkWell(
                onTap: () {
                  _isSelected
                      ? selectedItems.remove(item)
                      : selectedItems.add(item);
                  onChange(selectedItems);
                  //This rebuilds the dropdownMenu Widget to update the check mark
                  menuSetState(() {});
                },
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      _isSelected
                          ? const Icon(Icons.check_box_outlined)
                          : const Icon(Icons.check_box_outline_blank),
                      const SizedBox(width: 16),
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
      //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
      value: selectedItems.isEmpty ? null : selectedItems.last,
      onChanged: (value) {},
      customButton: button,
      itemPadding: EdgeInsets.zero,
    ));
  }
}
