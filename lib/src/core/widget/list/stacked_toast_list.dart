import 'package:flutter/widgets.dart';
import 'package:toastification/src/core/widget/list/toast_stack.dart';
import 'package:toastification/toastification.dart';

/// A toast of a [StackedToastList] with its enter and exit animation.
class _StackEntry {
  _StackEntry(this.item, this.controller);

  final ToastificationItem item;

  final AnimationController controller;

  bool get isExiting => controller.status == AnimationStatus.reverse;
}

/// Shows the toasts in a compact stack that expands to a list when the
/// pointer hovers over it or when it is tapped.
///
/// use [StackedToastListState.insertItem] and
/// [StackedToastListState.removeItem] to change the toasts.
class StackedToastList extends StatefulWidget {
  const StackedToastList({
    super.key,
    required this.reverse,
    required this.clipBehavior,
    required this.itemBuilder,
    required this.onExitEnd,
  });

  /// whether the stack grows from the bottom to the top.
  final bool reverse;

  final Clip clipBehavior;

  final Widget Function(ToastificationItem item, Animation<double> animation)
  itemBuilder;

  /// called when the exit animation of a toast ends.
  final VoidCallback onExitEnd;

  @override
  State<StackedToastList> createState() => StackedToastListState();
}

class StackedToastListState extends State<StackedToastList>
    with TickerProviderStateMixin {
  /// the toasts of the stack, newest first. a toast stays here until its exit
  /// animation ends.
  final List<_StackEntry> _entries = [];

  /// 0 when the stack is collapsed, 1 when it is expanded to the list.
  late final _expansion = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final _expansionCurve = _expansion.drive(
    CurveTween(curve: Curves.easeInOut),
  );

  /// whether the exit animation of a toast is still running.
  bool get isExiting => _entries.any((entry) => entry.isExiting);

  /// adds the [item] in front of the other toasts and animates it in.
  void insertItem(ToastificationItem item, Duration duration) {
    final controller = AnimationController(duration: duration, vsync: this)
      ..forward();

    setState(() {
      _entries.insert(0, _StackEntry(item, controller));
    });
  }

  /// animates out the [item] and removes it.
  ///
  /// a zero [duration] removes it without an animation.
  void removeItem(ToastificationItem item, Duration duration) {
    final entry = _entries.firstWhere((entry) => entry.item == item);

    if (duration == Duration.zero) {
      _drop(entry);
      return;
    }

    entry.controller.duration = duration;
    entry.controller.reverse().then((_) {
      _drop(entry);
      widget.onExitEnd();
    });
  }

  void _drop(_StackEntry entry) {
    setState(() {
      _entries.remove(entry);
    });
    entry.controller.dispose();
  }

  @override
  void dispose() {
    for (final entry in _entries) {
      entry.controller.dispose();
    }
    _expansion.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: widget.reverse,
      clipBehavior: widget.clipBehavior,
      child: TapRegion(
        onTapOutside: (event) => _expansion.reverse(),
        child: MouseRegion(
          onEnter: (event) => _expansion.forward(),
          onExit: (event) => _expansion.reverse(),
          child: GestureDetector(
            // the margins of the toasts expand the stack too.
            behavior: HitTestBehavior.opaque,
            onTap: _expansion.forward,
            child: ToastStack(
              expansion: _expansionCurve,
              relayout: Listenable.merge([
                _expansion,
                for (final entry in _entries) entry.controller,
              ]),
              reverse: widget.reverse,
              children: [
                for (final entry in _entries)
                  ToastStackSlot(
                    key: ValueKey(entry.item.id),
                    animation: entry.controller,
                    child: widget.itemBuilder(entry.item, entry.controller),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
