import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:example/src/features/home/views/ui_states/toast_detail_ui_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import 'package:toastification/toastification.dart';

part 'database.g.dart';

class ToastDetailsSchema extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get type => integer()();
  IntColumn get style => integer()();
  TextColumn get alignment => text()();
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get icon => text().nullable()();
  TextColumn get primaryColor => text().nullable()();
  TextColumn get backgroundColor => text().nullable()();
  TextColumn get foregroundColor => text().nullable()();
  TextColumn get iconColor => text().nullable()();
  TextColumn get borderRadius => text().nullable()();
  IntColumn get shadow => integer()();
  IntColumn get direction => integer().nullable()();
  IntColumn get autoCloseDuration => integer().nullable()();
  IntColumn get animationDuration => integer().nullable()();
  TextColumn get animationType => text()();
  IntColumn get closeButtonShowType => integer().nullable()();
  BoolColumn get useContext => boolean().withDefault(const Constant(true))();
  BoolColumn get showProgressBar =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get closeOnClick => boolean().withDefault(const Constant(true))();
  BoolColumn get pauseOnHover => boolean().withDefault(const Constant(true))();
  BoolColumn get dragToClose => boolean().withDefault(const Constant(false))();
  BoolColumn get applyBlurEffect =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get showIcon => boolean().withDefault(const Constant(true))();
}

@DriftDatabase(tables: [ToastDetailsSchema])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> upsertToastDetail(ToastDetailsSchemaCompanion detail) {
    return into(toastDetailsSchema).insert(detail.copyWith(id: const Value(1)),
        mode: InsertMode.insertOrReplace);
  }

  Future<ToastDetailsSchemaData> getOrCreateDefaultToastDetail() async {
    final toastDetail = await (select(toastDetailsSchema)
          ..where((tbl) => tbl.id.equals(1)))
        .getSingleOrNull();

    if (toastDetail == null) {
      final defaultToastDetail = ToastDetailsSchemaCompanion.insert(
        type: ToastificationType.success.index,
        style: ToastificationStyle.flat.index,
        alignment: 'topLeft',
        title: const Value<String?>('Component updates available.'),
        description: const Value<String?>('Component updates available.'),
        shadow: ShadowOptions.none.index,
        animationType: 'Bounce',
        closeButtonShowType: Value(CloseButtonShowType.always.index),
      );
      await upsertToastDetail(defaultToastDetail);
      return (await getToastDetail(1))!;
    }

    return toastDetail;
  }

  Future<ToastDetailsSchemaData?> getToastDetail(int id) {
    return (select(toastDetailsSchema)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Stream<ToastDetailsSchemaData?> watchToastDetail() {
    return (select(toastDetailsSchema)..where((tbl) => tbl.id.equals(1)))
        .watchSingleOrNull();
  }

  Future<int> deleteToastDetail() {
    return (delete(toastDetailsSchema)..where((tbl) => tbl.id.equals(1))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}
