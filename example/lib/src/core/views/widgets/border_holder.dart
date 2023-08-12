import 'package:flutter/material.dart';

const topHolderPadding = EdgeInsets.fromLTRB(40, 40, 40, 32);
const middleHolderPadding = EdgeInsets.fromLTRB(40, 32, 40, 32);
const bottomHolderPadding = EdgeInsets.fromLTRB(40, 32, 40, 40);

class TopBorderHolder extends StatelessWidget {
  const TopBorderHolder({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: topHolderPadding,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: child,
    );
  }
}

class MiddleBorderHolder extends StatelessWidget {
  const MiddleBorderHolder({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: middleHolderPadding,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.outline,
          ),
          right: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.outline,
          ),
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      child: child,
    );
  }
}

class BottomBorderHolder extends StatelessWidget {
  const BottomBorderHolder({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: bottomHolderPadding,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: child,
    );
  }
}
