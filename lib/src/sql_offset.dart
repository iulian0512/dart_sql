import 'package:dart_sql/dart_sql.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLOffset extends SQLExpression {
  int offsetrows;

  SQLOffset(this.offsetrows, {SQLWriter parent}) : super(parent: parent);

  @override
  void writeTo(StringSink sink) {
    sink.write('OFFSET $offsetrows ');
  }
}
