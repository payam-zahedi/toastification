import 'package:material_ui/material_ui.dart';
import 'package:toastification/toastification.dart';

extension ContextExt on BuildContext {
  ToastificationThemeData get toastTheme => ToastificationTheme.of(this);
}
