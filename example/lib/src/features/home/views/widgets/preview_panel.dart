import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/core/views/code/code_viewer.dart';
import 'package:example/src/core/views/widgets/expandable_widget.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:example/src/features/home/views/ui_states/extra.dart';
import 'package:example/src/features/home/views/ui_states/toast_code_formatter.dart';
import 'package:example/src/features/home/views/ui_states/toast_detail_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:toastification/toastification.dart';

class PreviewPanel extends StatelessWidget {
  const PreviewPanel({
    super.key,
    this.expanded = false,
  });

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            const ToastPreview(),
            const SizedBox(height: 16),
            if (expanded)
              const Expanded(child: CodePreview())
            else
              const CodePreview(),
          ],
        ),
      ),
    );
  }
}

class ToastPreview extends ConsumerWidget {
  const ToastPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toastDetail = ref.watch(toastDetailControllerProvider);

    final edgeInsets = context.isInMobileZone
        ? const EdgeInsets.fromLTRB(10, 12, 10, 12)
        : const EdgeInsets.fromLTRB(12, 14, 12, 14);
    return Container(
      decoration: BoxDecoration(
        borderRadius: context.cardsBorderRadius,
        color: Theme.of(context).cardTheme.color,
        image: toastDetail.applyBlurEffect
            ? const DecorationImage(
                image: AssetImage('assets/img/logo.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment(0.0, -.75),
              )
            : null,
      ),
      child: SizedBox(
        child: Padding(
          padding: edgeInsets,
          child: Center(
            child: _buildToastWidget(toastDetail),
          ),
        ),
      ),
    );
  }

  BuiltInToastBuilder _buildToastWidget(ToastDetail toastDetail) {
    return BuiltInToastBuilder(
      style: toastDetail.style,
      type: toastDetail.type,
      title: toastDetail.title,
      description: toastDetail.description,
      primaryColor: toastDetail.primaryColor,
      foregroundColor: toastDetail.foregroundColor,
      backgroundColor: toastDetail.backgroundColor,
      icon: toastDetail.icon == null ? null : Icon(toastDetail.icon?.iconData),
      borderRadius: toastDetail.borderRadius,
      borderSide: toastDetail.borderSide,
      boxShadow: toastDetail.shadow.shadow,
      direction: toastDetail.direction,
      showProgressBar: toastDetail.showProgressBar,
      applyBlurEffect: toastDetail.applyBlurEffect,
      closeButtonShowType: toastDetail.closeButtonShowType,
      onCloseTap: () {},
    );
  }
}

class CodePreview extends StatelessWidget {
  const CodePreview({super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.isInDesktopZone) {
      return const ExpandableCodePreview();
    }
    return const _RawCodePreview(expanded: true);
  }
}

class _RawCodePreview extends StatelessWidget {
  const _RawCodePreview({
    this.showCopyButton = true,
    this.expanded = false,
  });

  final bool expanded;

  final bool showCopyButton;
  @override
  Widget build(BuildContext context) {
    Widget child = SingleChildScrollView(
      primary: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: const CodePreviewer(),
      ),
    );

    if (showCopyButton) {
      child = Stack(
        children: [
          child,
          Positioned.directional(
            textDirection: Directionality.of(context),
            end: 16,
            top: 16,
            child: Consumer(
              builder: (context, ref, _) {
                return IconButton(
                  onPressed: () {
                    copyCode(context, ref.read(toastDetailControllerProvider));
                  },
                  icon: const Icon(Iconsax.document_copy_copy, size: 20),
                );
              },
            ),
          ),
        ],
      );
    }

    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: context.cardsBorderRadius,
          side: BorderSide(color: Theme.of(context).colorScheme.surfaceContainerHighest),
        ),
        color: const Color(0xffFBFCFD),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: 380,
            maxHeight: expanded ? double.infinity : 380,
          ),
          child: child,
        ),
      ),
    );
  }
}

class ExpandableCodePreview extends StatefulWidget {
  const ExpandableCodePreview({super.key});

  final bool initialExpanded = false;

  @override
  State<ExpandableCodePreview> createState() => _ExpandableCodePreviewState();
}

class _ExpandableCodePreviewState extends State<ExpandableCodePreview> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();

    isExpanded = widget.initialExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpandableWidget(
      borderRadius: context.cardsBorderRadius,
      borderSide: BorderSide(color: theme.colorScheme.outline),
      expansionCallback: (isExpanded) {
        setState(() {
          this.isExpanded = !isExpanded;
        });
      },
      headerBuilder: (context, isExpanded) {
        return Container(
          height: 56,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Code Preview',
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    return IconButton(
                      onPressed: () {
                        copyCode(
                            context, ref.read(toastDetailControllerProvider));
                      },
                      icon: const Icon(Iconsax.document_copy_copy, size: 20),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: _RawCodePreview(showCopyButton: false),
      ),
      isExpanded: isExpanded,
    );
  }
}

class CodePreviewer extends ConsumerWidget {
  const CodePreviewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toastDetail = ref.watch(toastDetailControllerProvider);

    final code = ToastCodeFormatter.format(toastDetail);
    final codeTheme = Map<String, TextStyle>.from(githubTheme);

    codeTheme.update(
      'root',
      (value) => value.copyWith(
        backgroundColor: const Color(0xffFBFCFD),
      ),
    );

    return CodeViewer(
      // The original code to be highlighted
      source: code,

      // Specify language
      // It is recommended to give it a value for performance
      language: 'dart',

      // Specify highlight theme
      // All available themes are listed in `themes` folder
      theme: codeTheme,

      // Specify padding
      padding: const EdgeInsets.all(8),
      tabSize: 2,
      // Specify text style
      textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.9),
    );
  }
}
