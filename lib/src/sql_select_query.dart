import 'package:dart_sql/src/sql_from.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLSelectQuery extends SQLWriter {
  final List<Object> projection;
  Iterable<String> get _projectionString => projection.map((e) => e.toString());
  SQLSelectQuery({List<Object> this.projection = const [], SQLWriter? parent})
      : super(parent);

  SQLFrom from(String tableNameOrExpr) =>
      SQLFrom(tableNameOrExpr, parent: this);

  @override
  void writeTo(StringSink sink) {
    sink.write('SELECT ');
    if (_projectionString.isEmpty) {
      sink.write('* ');
    } else {
      sink.writeAll(_projectionString, ', ');
      sink.write(' ');
    }
  }
}
