import 'package:example/src/core/usecase/responsive/responsive.dart';
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
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.cardsBorderRadiusValue),
          topRight: Radius.circular(context.cardsBorderRadiusValue),
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
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          right: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
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
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(context.cardsBorderRadiusValue),
          bottomRight: Radius.circular(context.cardsBorderRadiusValue),
        ),
      ),
      child: child,
    );
  }
}
