import 'package:dart_sql/dart_sql.dart';

class SQLColumnReference extends SQLExpression {
  SQLColumnReference(Object value) : super(value: value);
}

class SQLSyntethicColumnReference extends SQLColumnReference {
  SQLSyntethicColumnReference(super.value);
}
