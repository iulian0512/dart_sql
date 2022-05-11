import 'package:dart_sql/src/sql_expression.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLOnClause extends SQLExpression {
  final String column;
  SQLOnClause(this.column, {SQLWriter? parent}) : super(parent: parent);

  @override
  void writeTo(StringSink sink) {
    sink.write('ON ');
    sink.write('$column ');
  }
}
