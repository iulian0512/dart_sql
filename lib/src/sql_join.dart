import 'package:dart_sql/dart_sql.dart';
import 'package:dart_sql/src/sql_on.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLJoin extends SQLExpression {
  SQLJoin(this.tableName, {SQLWriter parent}) : super(parent: parent);

  String tableName;

  SQLOnClause on(String column) {
    return SQLOnClause(column, parent: this);
  }

  @override
  void writeTo(StringSink sink) {
    sink.write('JOIN $tableName ');
  }
}

class SQLLeftJoin extends SQLJoin {
  SQLLeftJoin(String tableName, {SQLWriter parent})
      : super(tableName, parent: parent);

  @override
  void writeTo(StringSink sink) {
    sink.write('LEFT JOIN $tableName ');
  }
}
