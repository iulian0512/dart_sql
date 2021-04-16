import 'package:dart_sql/dart_sql.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLLimit extends SQLExpression {
  int noRows;

  SQLLimit(int this.noRows, {SQLWriter parent}) : super(parent: parent);

  @override
  void writeTo(StringSink sink) {
    sink.write('LIMIT $noRows ');
  }
}
