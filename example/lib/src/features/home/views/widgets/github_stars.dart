import 'dart:convert';

import 'package:example/src/core/views/widgets/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

final starsCountProvider = FutureProvider<int>((ref) async {
  final url = Uri.parse(
    'https://api.github.com/repos/payam-zahedi/toastification',
  );

  final response = await http.get(url);

  final decodedResponse = jsonDecode(response.body);

  return decodedResponse['stargazers_count'] as int;
});

class GithubStars extends ConsumerWidget {
  const GithubStars({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final starsCount = ref.watch(starsCountProvider);

    final theme = Theme.of(context);

    return starsCount.maybeWhen(
      data: (data) => ColoredTag(
        icon: FontAwesomeIcons.github,
        text: '$data Stars on Github',
      ),
      orElse: () => TagContainer(
        child: SizedBox.square(
          dimension: 22,
          child: SpinKitPulse(
            color: theme.colorScheme.onTertiary,
            size: 22,
          ),
        ),
      ),
    );
  }
}
