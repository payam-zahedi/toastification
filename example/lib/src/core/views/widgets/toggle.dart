import 'package:flutter/material.dart';

class RoundToggle extends StatelessWidget {
  const RoundToggle({
    Key? key,
    required this.value,
    this.onChanged,
    this.enabledThumbColor,
    this.enabledTrackColor,
    this.disabledTrackColor,
    this.disabledThumbColor,
    this.thumbRadius,
    this.backgroundRadius,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  ///type of [Color] used for the active thumb color
  final Color? enabledThumbColor;

  ///type of [Color] used for the inactive thumb color
  final Color? disabledThumbColor;

  ///type of [Color] used for the active track color
  final Color? enabledTrackColor;

  ///type of [Color] used for the inactive thumb color
  final Color? disabledTrackColor;

  ///type of [BorderRadius] used to define the radius of the thumb
  final BorderRadius? thumbRadius;

  ///type of [BorderRadius] used to define the radius of the background
  final BorderRadius? backgroundRadius;

  ///type of animation [Duration] called when the switch animates during the specific duration
  final Duration duration;

  /// This property must not be null. Used to set the current state of toggle
  final bool value;

  /// Called when the user toggles the switch on or off.
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    bool enabled = onChanged != null;

    final thumbColor = value
        ? enabledThumbColor ?? theme.colorScheme.onPrimary
        : disabledThumbColor ?? theme.colorScheme.onPrimary;

    final thumbRadius =
        this.thumbRadius ?? const BorderRadius.all(Radius.circular(6));
    final backgroundRadius =
        this.backgroundRadius ?? const BorderRadius.all(Radius.circular(8));

    final backgroundColor = value && enabled
        ? enabledTrackColor ?? theme.colorScheme.primary
        : disabledTrackColor ?? theme.disabledColor;

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: () {
        onChanged?.call(!value);
      },
      child: AnimatedContainer(
        duration: duration,
        width: 40,
        height: 20,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: backgroundRadius,
        ),
        padding: const EdgeInsets.all(2),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            color: thumbColor,
            borderRadius: thumbRadius,
          ),
        ),
      ),
    );
  }
}
