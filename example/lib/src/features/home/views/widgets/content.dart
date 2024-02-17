import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:example/src/core/views/widgets/picker/icon/icon.dart';
import 'package:example/src/core/views/widgets/soon.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return !context.isInMobileZone
        ? const _ContentDesktop()
        : const _ContentMobile();
  }
}

class _ContentDesktop extends ConsumerWidget {
  const _ContentDesktop();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textDirection = ref.watch(toastDetailControllerProvider).direction ??
        Directionality.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 164,
          child: Column(
            // three bordered containers
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
                    // soon to be icon
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
                    child: TextField(
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
                  const SizedBox(width: 10),
                  const IconPicker(),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 106,
                child: TextField(
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    hintText: 'Type the body text here..',
                  ),
                  onChanged: (value) {
                    ref
                        .read(toastDetailControllerProvider.notifier)
                        .changeDescription(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContentMobile extends ConsumerWidget {
  const _ContentMobile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textDirection = ref.watch(toastDetailControllerProvider).direction ??
        Directionality.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          // three bordered containers
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

                    // soon to be icon
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
        TextField(
          decoration: const InputDecoration(
            hintText: 'Type the title text here..',
          ),
          onChanged: (value) {
            ref.read(toastDetailControllerProvider.notifier).changeTitle(value);
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 106,
          child: TextField(
            expands: true,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              hintText: 'Type the body text here..',
            ),
            onChanged: (value) {
              ref
                  .read(toastDetailControllerProvider.notifier)
                  .changeDescription(value);
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          // three bordered containers
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
