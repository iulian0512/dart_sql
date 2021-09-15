import 'package:dart_sql/dart_sql.dart';
import 'package:dart_sql/src/sql_join.dart';
import 'package:dart_sql/src/sql_order_by.dart';
import 'package:dart_sql/src/sql_writer.dart';
import 'package:dart_sql/src/sql_where_clause.dart';

class SQLFrom extends SQLExpression {
  SQLFrom({this.tableNameOrExpr, SQLWriter parent}) : super(parent: parent);

  String tableNameOrExpr;

  SQLOrderBy orderBy(List<String> columns) {
    return SQLOrderBy(columns: columns, parent: this);
  }

  @override
  void writeTo(StringSink sink) {
    sink.write('FROM $tableNameOrExpr ');
  }
}
