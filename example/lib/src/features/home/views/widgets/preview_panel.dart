import 'package:example/src/core/views/code/code_viewer.dart';
import 'package:example/src/core/views/widgets/expandable_widget.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:example/src/features/home/views/ui_states/extra.dart';
import 'package:example/src/features/home/views/ui_states/toast_code_formatter.dart';
import 'package:example/src/features/home/views/ui_states/toast_detail_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:toastification/toastification.dart';

class PreviewPanel extends StatelessWidget {
  const PreviewPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            ToastPreview(),
            SizedBox(height: 16),
            CodePreview(),
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
    final isTablet = ResponsiveWrapper.of(context).isSmallerThan(TABLET);

    final toastDetail = ref.watch(toastDetailControllerProvider);

    return Material(
      shape: Theme.of(context).cardTheme.shape,
      color: Theme.of(context).cardTheme.color,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 350,
                minHeight: isTablet ? 120 : 132,
              ),
              child: Center(child: _buildToastWidget(toastDetail)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToastWidget(ToastDetail toastDetail) {
    switch (toastDetail.style) {
      case ToastificationStyle.flat:
        return FlatToastWidget(
          type: toastDetail.type,
          title: toastDetail.title,
          description: toastDetail.description,
          backgroundColor: toastDetail.backgroundColor == null
              ? null
              : ToastHelper.createMaterialColor(
                  toastDetail.backgroundColor!,
                ),
          foregroundColor: toastDetail.foregroundColor,
          icon: toastDetail.icon,
          borderRadius: toastDetail.borderRadius,
          boxShadow: toastDetail.shadow.shadow,
          direction: toastDetail.direction,
          onCloseTap: toastDetail.onCloseTap ?? () {},
          showCloseButton: toastDetail.showCloseButton,
          showProgressBar: toastDetail.showProgressBar,
        );
      case ToastificationStyle.fillColored:
        return FilledToastWidget(
          type: toastDetail.type,
          title: toastDetail.title,
          description: toastDetail.description,
          backgroundColor: toastDetail.backgroundColor == null
              ? null
              : ToastHelper.createMaterialColor(
                  toastDetail.backgroundColor!,
                ),
          foregroundColor: toastDetail.foregroundColor,
          icon: toastDetail.icon,
          borderRadius: toastDetail.borderRadius,
          boxShadow: toastDetail.shadow.shadow,
          direction: toastDetail.direction,
          onCloseTap: toastDetail.onCloseTap ?? () {},
          showCloseButton: toastDetail.showCloseButton,
          showProgressBar: toastDetail.showProgressBar,
        );
      case ToastificationStyle.flatColored:
        return FlatColoredToastWidget(
          type: toastDetail.type,
          title: toastDetail.title,
          description: toastDetail.description,
          backgroundColor: toastDetail.backgroundColor == null
              ? null
              : ToastHelper.createMaterialColor(
                  toastDetail.backgroundColor!,
                ),
          foregroundColor: toastDetail.foregroundColor,
          icon: toastDetail.icon,
          borderRadius: toastDetail.borderRadius,
          boxShadow: toastDetail.shadow.shadow,
          direction: toastDetail.direction,
          onCloseTap: toastDetail.onCloseTap ?? () {},
          showCloseButton: toastDetail.showCloseButton,
          showProgressBar: toastDetail.showProgressBar,
        );
      case ToastificationStyle.minimal:
        return MinimalToastWidget(
          type: toastDetail.type,
          title: toastDetail.title,
          description: toastDetail.description,
          backgroundColor: toastDetail.backgroundColor == null
              ? null
              : ToastHelper.createMaterialColor(
                  toastDetail.backgroundColor!,
                ),
          foregroundColor: toastDetail.foregroundColor,
          icon: toastDetail.icon,
          borderRadius: toastDetail.borderRadius,
          boxShadow: toastDetail.shadow.shadow,
          direction: toastDetail.direction,
          onCloseTap: toastDetail.onCloseTap ?? () {},
          showCloseButton: toastDetail.showCloseButton,
          showProgressBar: toastDetail.showProgressBar,
        );
    }
  }
}

class CodePreview extends StatelessWidget {
  const CodePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveWrapper.of(context).isSmallerThan(TABLET);

    if (isTablet) {
      return const ExpandableCodePreview();
    }

    return const _RawCodePreview();
  }
}

class _RawCodePreview extends StatelessWidget {
  const _RawCodePreview({this.showCopyButton = true});

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

    return Material(
      shape: Theme.of(context).cardTheme.shape,
      color: Theme.of(context).cardTheme.color,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          maxHeight: 380,
        ),
        child: child,
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
                      color: theme.colorScheme.onBackground,
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

    final codeTheme = Map<String, TextStyle>.from(defaultTheme);

    codeTheme.update(
      'root',
      (value) => value.copyWith(
        backgroundColor: Theme.of(context).cardTheme.color,
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
      padding: const EdgeInsets.all(0),
      tabSize: 8,
      // Specify text style
      textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.9),
    );
  }
}
