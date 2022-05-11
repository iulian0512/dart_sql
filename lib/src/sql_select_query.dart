import 'package:dart_sql/src/sql_from.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLSelectQuery extends SQLWriter {
  final List<String> projection;
  SQLSelectQuery({List<Object>? projection, SQLWriter? parent})
      : this.projection =
            projection?.map((e) => e.toString()).toList() ?? const [],
        super(parent);

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
