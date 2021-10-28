import 'package:dart_sql/dart_sql.dart';
import 'package:dart_sql/src/sql_default_values.dart';
import 'package:dart_sql/src/sql_values.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLInto extends SQLWriter {
  final String tableName;
  String? asName;
  SQLInto(this.tableName, {SQLWriter? parent}) : super(parent);

  SQLValues values(Map<String, dynamic> values) =>
      SQLValues(values, parent: this);

  SQLSelectQuery select([List<String> projection = const []]) =>
      SQLSelectQuery(projection: projection, parent: this);

  SQLDefaultValues defaultValues() => SQLDefaultValues(this);

  @override
  void writeTo(StringSink sink) {
    sink.write('INTO $tableName ');
    if (asName != null) {
      sink.write('AS $asName ');
    }
  }
}
