import 'package:dart_sql/dart_sql.dart';

class SQLOrderBy extends SQLExpression {
  //key=column name value=  asc(true)/desc(false) boolean
  final Map<String, bool> _columns;
  final Iterable<String>? expressions;
  SQLOrderBy(Iterable<String> columns, {this.expressions, super.parent})
      : _columns = Map.fromIterable(columns, key: (k) => k, value: (v) => true);
  SQLOrderBy.fromColumnMap(this._columns, {this.expressions, super.parent});

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
    if (_columns.isNotEmpty || expressions?.isNotEmpty == true) {
      sink.write('ORDER BY ');
      if (_suffix != null) {
        sink.writeAll(_columns.entries.map((e) => e.key), ', ');
        if (expressions != null) sink.writeAll(expressions!, ', ');

        sink.write(' $_suffix ');
      } else {
        sink.writeAll(
            _columns.entries.map((e) => e.key + (e.value ? ' ASC ' : ' DESC ')),
            ', ');
        if (expressions != null) sink.writeAll(expressions!, ', ');
      }
    }
  }
}
