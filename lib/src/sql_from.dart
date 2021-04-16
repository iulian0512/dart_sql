import 'package:dart_sql/src/sql_join.dart';
import 'package:dart_sql/src/sql_order_by.dart';
import 'package:dart_sql/src/sql_writer.dart';
import 'package:dart_sql/src/sql_where_clause.dart';

class SQLFrom extends SQLWriter {
  SQLFrom({this.tableName, SQLWriter parent}) : super(parent);

  String tableName;

  SQLWhereClause where([String column]) =>
      SQLWhereClause(column: column, parent: this);

  SQLOrderBy orderBy(List<String> columns) {
    return SQLOrderBy(columns: columns, parent: this);
  }

  SQLJoin join(String tableName) => SQLJoin(tableName: tableName, parent: this);

  @override
  void writeTo(StringSink sink) {
    sink.write('FROM $tableName ');
  }
}
