import 'package:dart_sql/dart_sql.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLOrderBy extends SQLExpression {
  //key=column name value=  asc(true)/desc(false) boolean
  final Map<String, bool> _columns;
  SQLOrderBy(Iterable<String> columns, {SQLWriter? parent})
      : _columns = Map.fromIterable(columns, key: (k) => k, value: (v) => true),
        super(parent: parent);
  SQLOrderBy.fromColumnMap(this._columns, {SQLWriter? parent})
      : super(parent: parent);

  String? _suffix;

  SQLOrderBy having() {
    return this;
  }

  SQLOrderBy get asc {
    _suffix = 'ASC';
    return this;
  }

  SQLOrderBy get desc {
    _suffix = 'DESC';
    return this;
  }

  @override
  void writeTo(StringSink sink) {
    if (_columns.isNotEmpty) {
      sink.write('ORDER BY ');
      if (_suffix != null) {
        sink.writeAll(_columns.entries.map((e) => e.key), ', ');
        sink.write(' $_suffix ');
      } else
        sink.writeAll(
            _columns.entries.map((e) => e.key + (e.value ? ' ASC ' : ' DESC ')),
            ', ');
    }
  }
}
