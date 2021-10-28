import 'package:dart_sql/src/sql_from.dart';
import 'package:dart_sql/src/sql_join.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLSelectQuery extends SQLWriter {
  List<String>? projection;
  SQLSelectQuery({this.projection, SQLWriter? parent}) : super(parent);

  SQLFrom from(String tableNameOrExpr) {
    return SQLFrom(tableNameOrExpr: tableNameOrExpr, parent: this);
  }

  @override
  void writeTo(StringSink sink) {
    sink.write('SELECT ');
    if (projection == null || projection!.isEmpty) {
      sink.write('* ');
    } else {
      sink.writeAll(projection!, ', ');
      sink.write(' ');
    }
  }
}
