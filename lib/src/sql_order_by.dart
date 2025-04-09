import 'package:dart_sql/dart_sql.dart';

class SQLOrderBy extends SQLExpression {
  //key=column name value=  asc(true)/desc(false) boolean
  final Map<String, bool> _columnMap;
  final Iterable<String>? expressions;
  final String? suffix;

  ///sorting for [columns] will be done based on [ascending] flag for all
  SQLOrderBy(Iterable<String> columns,
      {this.expressions, bool ascending = true, super.parent})
      : suffix = expressions == null
            ? (ascending ? "ASC" : "DESC")
            : null, //no suffix allowed when expressions are present
        _columnMap =
            Map.fromIterable(columns, key: (k) => k, value: (v) => ascending);

  ///sorting will be done based on the value associated with each column asc(true)/desc(false) boolean
  SQLOrderBy.fromColumnMap(this._columnMap, {this.expressions, super.parent})
      : suffix = null;

  SQLOrderBy get asc => SQLOrderBy(this._columnMap.keys,
      expressions: this.expressions, ascending: true, parent: this.parent);

  SQLOrderBy get desc => SQLOrderBy(this._columnMap.keys,
      expressions: this.expressions, ascending: false, parent: this.parent);

  @override
  void writeTo(StringSink sink) {
    if (_columnMap.isNotEmpty || expressions?.isNotEmpty == true) {
      sink.write('ORDER BY ');
      //expressions come should come with their own asc desc specifier
      //so if there is a suffix asc/desc and there are no expressions write it using the suffix for all columns for efficiency
      if (suffix != null &&
          (expressions == null || expressions?.isEmpty == true)) {
        sink.writeAll(_columnMap.keys, ', ');
        sink.write(' $suffix ');
      } //
      else //otherwise write each column/expression individually
      {
        final itemsToWrite = [
          ..._columnMap.entries
              .map((e) => e.key + (e.value ? ' ASC' : ' DESC')),
          ...?expressions
        ];

        sink.writeAll(itemsToWrite, ', ');
        //an extra space in case the last expression does not have one
        if (!itemsToWrite.last.endsWith(" ")) sink.write(' ');
      }
    }
  }
}
