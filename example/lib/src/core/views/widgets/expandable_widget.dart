import 'package:flutter/material.dart';

typedef ExpandableWidgetCallback = void Function(bool isExpanded);

typedef ExpandableWidgetHeaderBuilder = Widget Function(
  BuildContext context,
  bool isExpanded,
);

class ExpandableWidget extends StatefulWidget {
  const ExpandableWidget({
    super.key,
    required this.headerBuilder,
    required this.body,
    required this.isExpanded,
    this.expansionCallback,
    this.animationDuration = kThemeAnimationDuration,
    this.borderRadius,
    this.borderSide,
  });

  /// The widget builder that builds the expandable widget's header.
  final ExpandableWidgetHeaderBuilder headerBuilder;

  /// The body of the expandable widget that's displayed below the header.
  ///
  /// This widget is visible only when the panel is expanded.
  final Widget body;

  /// Whether the panel is expanded.
  ///
  /// Defaults to false.
  final bool isExpanded;

  /// The callback that gets called whenever one of the expand/collapse buttons
  /// is pressed. The arguments passed to the callback are the index of the
  /// pressed panel and whether the panel is currently expanded or not.
  final ExpandableWidgetCallback? expansionCallback;

  /// The duration of the expansion animation.
  final Duration animationDuration;

  /// The border radius of the expandable widget.
  final BorderRadius? borderRadius;

  /// The border side of the expandable widget.
  final BorderSide? borderSide;

  @override
  State<StatefulWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  void _handlePressed(bool isExpanded) {
    widget.expansionCallback?.call(isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final Widget headerWidget = widget.headerBuilder(
      context,
      widget.isExpanded,
    );

    Widget expandIconContainer = ExpandIcon(
      color: Theme.of(context).colorScheme.onSurface,
      disabledColor: Theme.of(context).colorScheme.onSurface,
      padding: EdgeInsets.zero,
      isExpanded: widget.isExpanded,
      onPressed: null,
    );

    Widget header = Row(
      children: <Widget>[
        expandIconContainer,
        Expanded(
          child: AnimatedContainer(
            duration: widget.animationDuration,
            curve: Curves.fastOutSlowIn,
            margin: EdgeInsets.zero,
            child: headerWidget,
          ),
        ),
      ],
    );

    header = InkWell(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
      hoverColor: Colors.transparent,
      onTap: () => _handlePressed(widget.isExpanded),
      child: header,
    );

    if (widget.borderSide != null) {
      header = Material(
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
          side: widget.borderSide!,
        ),
        child: header,
      );
    }

    return Column(
      children: <Widget>[
        header,
        AnimatedCrossFade(
          firstChild: Container(height: 0.0),
          secondChild: widget.body,
          firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: widget.isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: widget.animationDuration,
        ),
      ],
    );
  }
}
