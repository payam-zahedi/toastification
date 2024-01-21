import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

final iconListProvider = StateProvider<List<MapEntry<String, IconData>>>((ref) {
  return Iconsax.items.entries.toList();
});

final searchedIconQuery = StateProvider<String>((ref) => '');

final filteredListProvider =
    StateProvider<List<MapEntry<String, IconData>>>((ref) {
  String query = ref.watch(searchedIconQuery).toLowerCase();
  var iconList = ref.watch(iconListProvider);
  return iconList
      .where(
        (MapEntry<String, IconData> e) => e.key.toLowerCase().contains(query),
      )
      .toList();
});
