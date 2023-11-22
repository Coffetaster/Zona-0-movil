import 'package:flutter/material.dart';

mixin DropItem{
  String get titleDrop;
}

class CustomDropdownButton<T extends DropItem> extends StatelessWidget {
  const CustomDropdownButton({super.key, required this.items, required this.hint, this.onChanged, this.value, this.error});
  final List<T> items;
  final String hint;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    border: error != null ? Border.all(color: colors.error) : null,
                    borderRadius: BorderRadius.circular(20)),
                child: DropdownButton<T>(
                    isExpanded: true,
                    value: value,
                    underline: Container(),
                    onChanged: onChanged,
                    hint: Text(hint),
                    items: items
                        .map((item) => DropdownMenuItem<T>(
                            value: item, child: Text(item.titleDrop)))
                        .toList()),
              ),
              if(error != null)
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(error!,style: TextStyle(color: colors.error, fontSize: 13)),
                )
            ],
          ),
        ));
  }
}
