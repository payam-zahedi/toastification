import 'package:dart_style/dart_style.dart';
import 'package:example/src/features/home/views/ui_states/toast_detail_ui_state.dart';

class ToastCodeFormatter {
  static final _formatter = DartFormatter();

  static String format(ToastDetail toastDetail) {
    final StringBuffer code = StringBuffer();

    code.write('''
    toastification.show(
    context: context,
    type: ${toastDetail.type},
    style: ${toastDetail.style},
    title: '${toastDetail.title}',
  ''');

    if (toastDetail.description.isNotEmpty) {
      code.writeln('\tdescription: \'${toastDetail.description}\',');
    }

    code.writeln('\talignment: ${toastDetail.alignment},');

    if (toastDetail.autoCloseDuration != null &&
        toastDetail.autoCloseDuration!.inMilliseconds >= 500) {
      final duration = toastDetail.autoCloseDuration;

      final seconds = duration!.inSeconds;

      final milliseconds = seconds > 0
          ? duration.inMilliseconds - (seconds * 1000)
          : duration.inMilliseconds;

      code.write('\tautoCloseDuration: const Duration(');

      if (milliseconds > 0) {
        code.write('seconds: $seconds,');
        code.write('milliseconds: $milliseconds,');
      } else {
        code.write('seconds: $seconds');
      }

      code.writeln('),');
    }

    if (toastDetail.primaryColor != null) {
      code.writeln('\tprimaryColor: ${toastDetail.primaryColor},');
    }

    if (toastDetail.backgroundColor != null) {
      code.writeln('\tbackgroundColor: ${toastDetail.backgroundColor},');
    }

    if (toastDetail.foregroundColor != null) {
      code.writeln('\tforegroundColor: ${toastDetail.foregroundColor},');
    }

    if (toastDetail.iconColor != null) {
      code.writeln('\ticonColor: ${toastDetail.iconColor},');
    }

    if (toastDetail.icon != null) {
      code.writeln('\ticon: ${toastDetail.icon},');
    }

    if (toastDetail.borderRadius != null) {
      code.writeln('\tborderRadius: ${toastDetail.borderRadius},');
    }

    if (toastDetail.shadow != ShadowOptions.none) {
      code.writeln('\tboxShadow: ${toastDetail.shadow.name},');
    }

    if (toastDetail.showProgressBar == false) {
      code.writeln('\tshowProgressBar: ${toastDetail.showProgressBar},');
    }

    if (toastDetail.showCloseButton == false) {
      code.writeln('\tshowCloseButton: ${toastDetail.showCloseButton},');
    }

    if (toastDetail.closeOnClick == false) {
      code.writeln('\tcloseOnClick: ${toastDetail.closeOnClick},');
    }
    if (toastDetail.dragToClose == true) {
      code.writeln('\tdragToClose: ${toastDetail.dragToClose},');
    }

    if (toastDetail.pauseOnHover == false) {
      code.writeln('\tpauseOnHover: ${toastDetail.pauseOnHover},');
    }

    code.write(');');

    return _formatter.formatStatement(code.toString());
  }
}
