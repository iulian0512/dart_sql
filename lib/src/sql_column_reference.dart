import 'package:dart_sql/dart_sql.dart';

class SQLColumnReference extends SQLExpression {
  final String? alias;
  final Object reference;
  SQLColumnReference(Object this.reference, {String? this.alias})
      : super(value: reference);

  @override
  void writeTo(StringSink sink) {
    if (alias?.isNotEmpty == true)
      sink.write("$reference as $alias");
    else
      sink.write("$reference");

    sink.write(" ");
  }
}

class SQLSyntethicColumnReference extends SQLColumnReference {
  SQLSyntethicColumnReference(super.value, {super.alias});
}
