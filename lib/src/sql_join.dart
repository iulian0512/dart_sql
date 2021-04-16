import 'package:dart_sql/src/sql_on.dart';
import 'package:dart_sql/src/sql_order_by.dart';
import 'package:dart_sql/src/sql_writer.dart';
import 'package:dart_sql/src/sql_where_clause.dart';

class SQLJoin extends SQLWriter {
  SQLJoin({this.tableName, SQLWriter parent}) : super(parent);

  String tableName;

  SQLOnClause on(String column) {
    return SQLOnClause(column, parent: this);
  }

  @override
  void writeTo(StringSink sink) {
    sink.write('JOIN $tableName ');
  }
}
