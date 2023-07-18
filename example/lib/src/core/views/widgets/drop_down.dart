import 'package:example/src/core/views/widgets/soon.dart';
import 'package:flutter/material.dart';

class BorderedDropDown<T> extends StatelessWidget {
  const BorderedDropDown({
    super.key,
    required this.hint,
    this.value,
    required this.items,
    this.onChanged,
    this.icon,
    this.available = true,
    this.isExpanded = true,
  });

  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  final Widget? icon;
  final bool available;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        focusColor: theme.colorScheme.outline,
      ),
      child: DropdownButtonFormField<T>(
        icon: const Icon(Icons.keyboard_arrow_down),
        focusColor: theme.colorScheme.background,
        isExpanded: isExpanded,
        borderRadius: BorderRadius.circular(10),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
            child: icon,
          ),
          prefixIconColor: theme.colorScheme.onSurface.withOpacity(.2),
          hintText: hint,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            height: 1.1,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: theme.colorScheme.outline,
            ),
          ),
          filled: false,
        ),
        hint: !available
            ? Row(
                children: [
                  Text(
                    hint,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const SoonWidget(),
                ],
              )
            : null,
        value: value,
        items: items,
        onChanged: available ? onChanged : null,
        selectedItemBuilder: (context) {
          return items.map((item) {
            if (!isExpanded) {
              return Text(
                item.value.toString(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.1,
                  fontWeight: FontWeight.w400,
                ),
              );
            }

            return Row(
              children: [
                Expanded(
                  child: Text(
                    hint,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.1,
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  item.value.toString(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.1,
                    color: theme.colorScheme.onSurface.withOpacity(.3),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            );
          }).toList();
        },
      ),
    );
  }
}
