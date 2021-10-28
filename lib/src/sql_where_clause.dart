import 'package:dart_sql/src/sql_expression.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLWhereClause extends SQLExpression {
  SQLWhereClause({SQLWriter? parent, this.expression}) : super(parent: parent);

  String? expression;

  @override
  void writeTo(StringSink sink) {
    sink.write('WHERE ');
    if (expression != null) {
      sink.write('$expression ');
    }
  }
}
