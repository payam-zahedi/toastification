import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:example/src/core/views/widgets/picker/icon/icon.dart';
import 'package:example/src/core/views/widgets/soon.dart';
import 'package:example/src/core/views/widgets/toggle_tile.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return !context.isInMobileZone
        ? const _ContentDesktop()
        : const _ContentMobile();
  }
}

class _ContentDesktop extends ConsumerStatefulWidget {
  const _ContentDesktop();

  @override
  ConsumerState<_ContentDesktop> createState() => _ContentDesktopState();
}

class _ContentDesktopState extends ConsumerState<_ContentDesktop> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    // Initialize the controllers
    final toastDetail = ref.read(toastDetailControllerProvider);
    _titleController = TextEditingController(
      text: (toastDetail.title as Text).data != 'Component updates available.'
          ? (toastDetail.title as Text).data
          : '',
    );
    _descriptionController = TextEditingController(
      text: (toastDetail.description as Text).data !=
              'Component updates available.'
          ? (toastDetail.description as Text).data
          : '',
    );

    // Add listeners to update the provider when text changes
    _titleController.addListener(() {
      ref
          .read(toastDetailControllerProvider.notifier)
          .changeTitle(_titleController.text);
    });

    _descriptionController.addListener(() {
      ref
          .read(toastDetailControllerProvider.notifier)
          .changeDescription(_descriptionController.text);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = ref.watch(toastDetailControllerProvider).direction ??
        Directionality.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 164,
          child: Column(
            children: [
              const BorderedContainer(
                height: 48,
                padding: EdgeInsets.symmetric(horizontal: 16),
                enabled: false,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Add Section'),
                    SoonWidget(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              BorderedContainer(
                height: 48,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onTap: () {
                  ref
                      .read(toastDetailControllerProvider.notifier)
                      .changeDirection(TextDirection.ltr);
                },
                active: textDirection == TextDirection.ltr,
                child: Row(
                  children: [
                    const Expanded(child: Text('LTR layout')),
                    Offstage(
                      offstage: textDirection != TextDirection.ltr,
                      child: const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              BorderedContainer(
                height: 48,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onTap: () {
                  ref
                      .read(toastDetailControllerProvider.notifier)
                      .changeDirection(TextDirection.rtl);
                },
                active: textDirection == TextDirection.rtl,
                child: Row(
                  children: [
                    const Expanded(child: Text('RTL layout')),
                    Offstage(
                      offstage: textDirection != TextDirection.rtl,
                      child: const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ToggleTile(
                      title: 'Show Icon',
                      value: ref.watch(toastDetailControllerProvider).showIcon,
                      soon: false,
                      onChanged: (value) {
                        ref
                            .read(toastDetailControllerProvider.notifier)
                            .changeShowIcon(value ?? true);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  const IconPicker(),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: 'Type the title text here..',
                        ),
                        onChanged: (value) {
                          ref
                              .read(toastDetailControllerProvider.notifier)
                              .changeTitle(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 106,
                child: TextField(
                  controller: _descriptionController,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    hintText: 'Type the body text here..',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContentMobile extends ConsumerStatefulWidget {
  const _ContentMobile();

  @override
  ConsumerState<_ContentMobile> createState() => _ContentMobileState();
}

class _ContentMobileState extends ConsumerState<_ContentMobile> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    // Initialize the controllers
    final toastDetail = ref.read(toastDetailControllerProvider);
    _titleController = TextEditingController(
      text: (toastDetail.title as Text).data != 'Component updates available.'
          ? (toastDetail.title as Text).data
          : '',
    );
    _descriptionController = TextEditingController(
      text: (toastDetail.description as Text).data !=
              'Component updates available.'
          ? (toastDetail.description as Text).data
          : '',
    );

    // Add listeners to update the provider when text changes
    _titleController.addListener(() {
      ref
          .read(toastDetailControllerProvider.notifier)
          .changeTitle(_titleController.text);
    });

    _descriptionController.addListener(() {
      ref
          .read(toastDetailControllerProvider.notifier)
          .changeDescription(_descriptionController.text);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = ref.watch(toastDetailControllerProvider).direction ??
        Directionality.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          children: [
            Expanded(
              child: BorderedContainer(
                height: 48,
                padding: EdgeInsets.symmetric(horizontal: 16),
                enabled: false,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Add Section',
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: SoonWidget(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(child: IconPicker()),
          ],
        ),
        const SizedBox(height: 16),
        ToggleTile(
          title: 'Show Icon',
          value: ref.watch(toastDetailControllerProvider).showIcon,
          soon: false,
          onChanged: (value) {
            ref
                .read(toastDetailControllerProvider.notifier)
                .changeShowIcon(value ?? true);
          },
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            hintText: 'Type the title text here..',
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 106,
          child: TextField(
            controller: _descriptionController,
            expands: true,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              hintText: 'Type the body text here..',
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: BorderedContainer(
                height: 48,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onTap: () {
                  ref
                      .read(toastDetailControllerProvider.notifier)
                      .changeDirection(TextDirection.ltr);
                },
                active: textDirection == TextDirection.ltr,
                child: Row(
                  children: [
                    const Expanded(child: Text('LTR layout')),
                    Offstage(
                      offstage: textDirection != TextDirection.ltr,
                      child: const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: BorderedContainer(
                height: 48,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onTap: () {
                  ref
                      .read(toastDetailControllerProvider.notifier)
                      .changeDirection(TextDirection.rtl);
                },
                active: textDirection == TextDirection.rtl,
                child: Row(
                  children: [
                    const Expanded(child: Text('RTL layout')),
                    Offstage(
                      offstage: textDirection != TextDirection.rtl,
                      child: const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
