import 'package:dart_sql/src/sql_expression.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLCaseWhen extends SQLExpression {
  final String alias;
  final Map<Object, Object> expressionMap;
  final Object? elseExpr;
  SQLCaseWhen(this.alias, this.expressionMap,
      {this.elseExpr, SQLWriter? parent})
      : super(parent: parent);

  @override
  void writeTo(StringSink sink) {
    //we have some expressions
    if (expressionMap.isNotEmpty) {
      final whenstmts = expressionMap.entries
          .map((e) => "when ${e.key} then ${e.value}")
          .join(" ");
      final elseStmt = elseExpr != null ? " else $elseExpr" : "";
      sink.write('case $whenstmts$elseStmt end as $alias');
    } else if (elseExpr != null) // no expressions but else expression provided
      sink.write('$elseExpr as $alias');
    else //no expressions and no else expression => always null
      sink.write("null as $alias");
  }
}
