import 'package:dart_sql/dart_sql.dart';
import 'package:dart_sql/src/sql_order_by.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLFrom extends SQLExpression {
  String tableNameOrExpr;
  SQLFrom(this.tableNameOrExpr, {SQLWriter? parent}) : super(parent: parent);

  SQLOrderBy orderBy(List<String> columns) => SQLOrderBy(columns, parent: this);

  @override
  void writeTo(StringSink sink) => sink.write('FROM $tableNameOrExpr ');
}
