import 'package:example/src/features/home/views/ui_states/toast_code_formatter.dart';
import 'package:example/src/features/home/views/ui_states/toast_detail_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> setOnClipboard(ToastDetail detail) async {
  final code = ToastCodeFormatter.format(detail);
  try {
    await Clipboard.setData(ClipboardData(text: code));

    return true;
  } on Exception catch (_) {
    return false;
  }
}

void copyCode(BuildContext context, ToastDetail detail) async {
  setOnClipboard(detail).then(
    (result) {
      if (result) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          style: ToastificationStyle.flat,
          title: 'Clipboard',
          description: 'Code copied to clipboard',
          autoCloseDuration: const Duration(seconds: 4),
        );
      } else {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          style: ToastificationStyle.flat,
          title: 'Ops!',
          description: 'Something went wrong',
          autoCloseDuration: const Duration(seconds: 4),
        );
      }
    },
  );
}

void openGithub(BuildContext context) async {
  const url = 'https://github.com/payam-zahedi/toastification';
  if (!await launchUrl(Uri.parse(url))) {
    if (context.mounted) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: 'Ops!',
        description: 'Something went wrong',
        autoCloseDuration: const Duration(seconds: 4),
      );
    }
  }
}
