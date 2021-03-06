import 'package:dart_sql/src/sql_writer.dart';

class SQLValues extends SQLWriter {
  Map<String, dynamic> values;
  SQLValues(this.values, {SQLWriter? parent}) : super(parent);

  @override
  void writeTo(StringSink sink) {
    List<String> clist = [];
    List<dynamic> vlist = [];

    values.forEach((column, value) {
      clist.add(column);
      vlist.add(value);
    });
    sink.write('(');
    sink.writeAll(clist, ', ');
    sink.write(') VALUES (');
    sink.writeAll(vlist.map((val) => writeVal(val)), ', ');
    sink.write(')');
  }
}
