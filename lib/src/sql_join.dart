import 'package:dart_sql/dart_sql.dart';
import 'package:dart_sql/src/sql_on.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLJoin extends SQLExpression {
  SQLJoin(this.tableName, {this.alias, SQLWriter parent})
      : super(parent: parent);

  String tableName;
  String alias;

  SQLOnClause on(String column) {
    return SQLOnClause(column, parent: this);
  }

  @override
  void writeTo(StringSink sink) {
    if (alias != null)
      sink.write('JOIN $tableName as $alias ');
    else
      sink.write('JOIN $tableName ');
  }
}

class SQLLeftJoin extends SQLJoin {
  SQLLeftJoin(String tableName, {String alias, SQLWriter parent})
      : super(tableName, alias: alias, parent: parent);

  @override
  void writeTo(StringSink sink) {
    if (alias != null)
      sink.write('LEFT JOIN $tableName as $alias ');
    else
      sink.write('LEFT JOIN $tableName ');
  }
}
