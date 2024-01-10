// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FavoriteTable extends Favorite
    with TableInfo<$FavoriteTable, FavoriteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _thumbnailMeta =
      const VerificationMeta('thumbnail');
  @override
  late final GeneratedColumn<String> thumbnail = GeneratedColumn<String>(
      'thumbnail', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, thumbnail, name, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta));
    } else if (isInserting) {
      context.missing(_thumbnailMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  FavoriteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      thumbnail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumbnail'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $FavoriteTable createAlias(String alias) {
    return $FavoriteTable(attachedDatabase, alias);
  }
}

class FavoriteData extends DataClass implements Insertable<FavoriteData> {
  final String id;
  final String thumbnail;
  final String name;
  final DateTime date;
  const FavoriteData(
      {required this.id,
      required this.thumbnail,
      required this.name,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['thumbnail'] = Variable<String>(thumbnail);
    map['name'] = Variable<String>(name);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  FavoriteCompanion toCompanion(bool nullToAbsent) {
    return FavoriteCompanion(
      id: Value(id),
      thumbnail: Value(thumbnail),
      name: Value(name),
      date: Value(date),
    );
  }

  factory FavoriteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteData(
      id: serializer.fromJson<String>(json['id']),
      thumbnail: serializer.fromJson<String>(json['thumbnail']),
      name: serializer.fromJson<String>(json['name']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'thumbnail': serializer.toJson<String>(thumbnail),
      'name': serializer.toJson<String>(name),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  FavoriteData copyWith(
          {String? id, String? thumbnail, String? name, DateTime? date}) =>
      FavoriteData(
        id: id ?? this.id,
        thumbnail: thumbnail ?? this.thumbnail,
        name: name ?? this.name,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteData(')
          ..write('id: $id, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('name: $name, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, thumbnail, name, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteData &&
          other.id == this.id &&
          other.thumbnail == this.thumbnail &&
          other.name == this.name &&
          other.date == this.date);
}

class FavoriteCompanion extends UpdateCompanion<FavoriteData> {
  final Value<String> id;
  final Value<String> thumbnail;
  final Value<String> name;
  final Value<DateTime> date;
  final Value<int> rowid;
  const FavoriteCompanion({
    this.id = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.name = const Value.absent(),
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteCompanion.insert({
    required String id,
    required String thumbnail,
    required String name,
    required DateTime date,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        thumbnail = Value(thumbnail),
        name = Value(name),
        date = Value(date);
  static Insertable<FavoriteData> custom({
    Expression<String>? id,
    Expression<String>? thumbnail,
    Expression<String>? name,
    Expression<DateTime>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (name != null) 'name': name,
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteCompanion copyWith(
      {Value<String>? id,
      Value<String>? thumbnail,
      Value<String>? name,
      Value<DateTime>? date,
      Value<int>? rowid}) {
    return FavoriteCompanion(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      name: name ?? this.name,
      date: date ?? this.date,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String>(thumbnail.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteCompanion(')
          ..write('id: $id, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $FavoriteTable favorite = $FavoriteTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favorite];
}
