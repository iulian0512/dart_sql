import 'package:dart_sql/src/sql_from.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLSelectQuery extends SQLWriter {
  final List<String> projection;
  SQLSelectQuery({this.projection = const [], SQLWriter? parent})
      : super(parent);

  SQLFrom from(String tableNameOrExpr) =>
      SQLFrom(tableNameOrExpr, parent: this);

  @override
  void writeTo(StringSink sink) {
    sink.write('SELECT ');
    if (projection.isEmpty) {
      sink.write('* ');
    } else {
      sink.writeAll(projection, ', ');
      sink.write(' ');
    }
  }
}
