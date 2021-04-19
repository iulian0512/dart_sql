import 'package:dart_sql/dart_sql.dart';
import 'package:dart_sql/src/sql_join.dart';
import 'package:dart_sql/src/sql_order_by.dart';
import 'package:dart_sql/src/sql_writer.dart';
import 'package:dart_sql/src/sql_where_clause.dart';

class SQLFrom extends SQLExpression {
  SQLFrom({this.tableName, SQLWriter parent}) : super(parent: parent);

  String tableName;

  SQLOrderBy orderBy(List<String> columns) {
    return SQLOrderBy(columns: columns, parent: this);
  }

  @override
  void writeTo(StringSink sink) {
    sink.write('FROM $tableName ');
  }
}
