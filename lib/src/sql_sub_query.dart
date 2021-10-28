import 'package:dart_sql/src/sql_select_query.dart';
import 'package:dart_sql/src/sql_writer.dart';

class SQLSubQuery extends SQLWriter {
  String? _prefix;
  SQLSelectQuery? _subquery;

  SQLSubQuery.all(SQLWriter parent) : super(parent) {
    _prefix = "ALL ";
  }

  SQLSubQuery.any(SQLWriter parent) : super(parent) {
    _prefix = "ANY";
  }

  SQLSelectQuery select([List<dynamic> columns = const []]) {
    _subquery =
        SQLSelectQuery(projection: columns as List<String>, parent: this);
    return _subquery!;
  }

  @override
  void writeTo(StringSink sink) {
    sink.write(_prefix);
    if (_subquery != null) {
      _subquery!.writeTo(sink);
    }
  }
}
