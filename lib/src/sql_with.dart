import 'package:dart_sql/dart_sql.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLWithQuery extends SQLExpression {
  final Map<String, SQLExpression> ctes;
  final SQLExpression select;
  SQLWithQuery(this.ctes, this.select, {SQLWriter? parent})
      : super(parent: parent);

  @override
  void writeTo(StringSink sink) => sink.write(
      'WITH ${ctes.entries.map((e) => '${e.key} as (${e.value})').join(", ")} ${select}');
}
