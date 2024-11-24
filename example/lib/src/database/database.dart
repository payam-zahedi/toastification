import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:example/src/features/home/views/ui_states/toast_detail_ui_state.dart';
import 'package:toastification/toastification.dart';

part 'database.g.dart';

const defaultToastDetailId = 1;

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
    return into(toastDetailsSchema).insert(
      detail.copyWith(id: const Value(defaultToastDetailId)),
      mode: InsertMode.replace,
    );
  }

  Future<ToastDetailsSchemaData?> retrieveSavedToastState() {
    return (select(toastDetailsSchema)..where((tbl) => tbl.id.equals(defaultToastDetailId)))
        .getSingleOrNull();
  }


  Future<int> deleteToastDetail() {
    return (delete(toastDetailsSchema)..where((tbl) => tbl.id.equals(1))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final result = await WasmDatabase.open(
      databaseName: 'app_web_db',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );

    return result.resolvedExecutor;
  });
}
