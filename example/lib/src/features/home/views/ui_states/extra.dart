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
          type: ToastificationType.success,
          style: ToastificationStyle.flatColored,
          title: const Text('Clipboard'),
          description: const Text('Code copied to clipboard'),
          autoCloseDuration: const Duration(seconds: 4),
          alignment: detail.alignment,
          animationDuration: detail.animationDuration,
          animationBuilder: detail.animationType.builder,
          boxShadow: detail.shadow.shadow,
        );
      } else {
        toastification.show(
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          title: const Text('Ops!'),
          description: const Text('Something went wrong'),
          autoCloseDuration: const Duration(seconds: 4),
          alignment: detail.alignment,
          animationDuration: detail.animationDuration,
          animationBuilder: detail.animationType.builder,
          boxShadow: detail.shadow.shadow,
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
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: const Text('Ops!'),
        description: const Text('Something went wrong'),
        autoCloseDuration: const Duration(seconds: 4),
      );
    }
  }
}

void openGithubIssues(BuildContext context) async {
  const url = 'https://github.com/payam-zahedi/toastification/issues';
  if (!await launchUrl(Uri.parse(url))) {
    if (context.mounted) {
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: const Text('Ops!'),
        description: const Text('Something went wrong'),
        autoCloseDuration: const Duration(seconds: 4),
      );
    }
  }
}

void openGithubPullRequests(BuildContext context) async {
  const url = 'https://github.com/payam-zahedi/toastification/pulls';
  if (!await launchUrl(Uri.parse(url))) {
    if (context.mounted) {
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: const Text('Ops!'),
        description: const Text('Something went wrong'),
        autoCloseDuration: const Duration(seconds: 4),
      );
    }
  }
}

void showCurrentToast(BuildContext context, ToastDetail toastDetail) {
  toastification.show(
    alignment: toastDetail.alignment,
    title: toastDetail.title,
    description: toastDetail.description,
    type: toastDetail.type,
    style: toastDetail.style,
    autoCloseDuration: toastDetail.autoCloseDuration,
    animationDuration: toastDetail.animationDuration,
    animationBuilder: toastDetail.animationType.builder,
    icon: toastDetail.icon == null ? null : Icon(toastDetail.icon?.iconData),
    primaryColor: toastDetail.primaryColor,
    foregroundColor: toastDetail.foregroundColor,
    backgroundColor: toastDetail.backgroundColor,
    borderRadius: toastDetail.borderRadius,
    boxShadow: toastDetail.shadow.shadow,
    direction: toastDetail.direction,
    closeOnClick: toastDetail.closeOnClick,
    dragToClose: toastDetail.dragToClose,
    pauseOnHover: toastDetail.pauseOnHover,
    showProgressBar: toastDetail.showProgressBar,
    applyBlurEffect: toastDetail.applyBlurEffect,
    closeButtonShowType: toastDetail.closeButtonShowType,
  );
}
