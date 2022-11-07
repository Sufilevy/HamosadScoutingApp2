import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/constants.dart';

class MultiSelectionsButton extends StatelessWidget {
  const MultiSelectionsButton({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.button,
    required this.onChange,
  });

  final List<String> items;
  final List<String> selectedItems;
  final Widget button;
  final Function(List<String>) onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        dropdownDecoration: const BoxDecoration(
          color: Consts.sectionDefultColor,
        ),
        isExpanded: true,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            enabled: false,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final isSelected = selectedItems.contains(item);
                return InkWell(
                  onTap: () {
                    isSelected
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
                        isSelected
                            ? const Icon(Icons.check_box_outlined)
                            : const Icon(Icons.check_box_outline_blank),
                        const SizedBox(width: 16),
                        Text(
                          item,
                          style: const TextStyle(
                            color: Consts.secondaryDisplayColor,
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
        dropdownWidth: 200,
        //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
        value: selectedItems.isEmpty ? null : selectedItems.last,
        onChanged: (value) {},
        customButton: button,
        itemPadding: EdgeInsets.zero,
      ),
    );
  }
}
