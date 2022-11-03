import 'package:dart_sql/dart_sql.dart';
import 'package:dart_sql/src/sql_order_by.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLFrom extends SQLExpression {
  final String tableNameOrExpr;
  SQLFrom(this.tableNameOrExpr, {SQLWriter? parent}) : super(parent: parent);

  SQLOrderBy orderBy(List<String> columns) => SQLOrderBy(columns, parent: this);

  ///key=column name value=  asc(true)/desc(false) boolean
  SQLOrderBy orderByIdividual(Map<String, bool> columns_map) =>
      SQLOrderBy.fromColumnMap(columns_map, parent: this);

  @override
  void writeTo(StringSink sink) => sink.write('FROM $tableNameOrExpr ');
}
