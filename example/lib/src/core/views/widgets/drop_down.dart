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
  });

  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  final Widget? icon;
  final bool available;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButtonFormField<T>(
      icon: const Icon(Icons.keyboard_arrow_down),
      focusColor: theme.colorScheme.background,
      borderRadius: BorderRadius.circular(10),
      decoration: InputDecoration(
        prefixIcon: icon,
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
    );
  }
}
