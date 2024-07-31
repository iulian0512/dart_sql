import 'package:dart_sql/src/sql_column_reference.dart';
import 'package:dart_sql/src/sql_join.dart';
import 'package:dart_sql/src/sql_limit.dart';
import 'package:dart_sql/src/sql_offset.dart';
import 'package:dart_sql/src/sql_on.dart';
import 'package:dart_sql/src/sql_order_by.dart';
import 'package:dart_sql/src/sql_select_query.dart';
import 'package:dart_sql/src/sql_writer.dart';
import 'package:dart_sql/src/sql_sub_query.dart';
import 'package:dart_sql/src/sql_where_clause.dart';

enum SQLJoinType { Inner, Left, Right, Full }

class SQLExpression extends SQLWriter {
  String? op;
  Object? value;
  SQLExpression({this.op, this.value, SQLWriter? parent}) : super(parent);
  factory SQLExpression.ColumnReference(Object value, {String? alias}) =>
      SQLColumnReference(value, alias: alias);
  factory SQLExpression.SynColumnReference(Object value, {String? alias}) =>
      SQLSyntethicColumnReference(value, alias: alias);

  @override
  void writeTo(StringSink sink) {
    if (op != null) {
      sink.write(op);
      sink.write(' ');
    }

    if (value != null) {
      sink.write(value);
      sink.write(' ');
    }
  }

  SQLJoin join(String tableName,
      {String? alias, SQLJoinType joinType = SQLJoinType.Inner}) {
    switch (joinType) {
      case SQLJoinType.Inner:
        return SQLJoin(tableName, alias: alias, parent: this);
      case SQLJoinType.Left:
        return SQLLeftJoin(tableName, alias: alias, parent: this);
      default:
        throw Exception("join type $joinType not implemented");
    }
  }

  SQLLimit limit(int norows) => SQLLimit(norows, parent: this);
  SQLOffset offset(int offset) => SQLOffset(offset, parent: this);

  SQLWhereClause where([String? expression]) =>
      SQLWhereClause(expression: expression, parent: this);

  SQLExpression eq(dynamic val) =>
      SQLExpression(op: '=', value: writeVal(val), parent: this);

  SQLExpression neq(dynamic val) =>
      SQLExpression(op: '!=', value: writeVal(val), parent: this);

  SQLExpression gt(dynamic val) =>
      SQLExpression(op: '>', value: writeVal(val), parent: this);

  SQLExpression lt(dynamic val) =>
      SQLExpression(op: '<', value: writeVal(val), parent: this);

  SQLExpression gte(dynamic val) =>
      SQLExpression(op: '>=', value: writeVal(val), parent: this);

  SQLExpression lte(dynamic val) =>
      SQLExpression(op: '<=', value: writeVal(val), parent: this);

  SQLSubQuery all() => SQLSubQuery.all(this);

  SQLExpression and([String? column]) =>
      SQLExpression(op: 'AND', value: column, parent: this);

  SQLSubQuery any() => SQLSubQuery.any(this);

  SQLExpression between(dynamic val1, dynamic val2) {
    return SQLExpression(
        op: 'BETWEEN',
        value: '${writeVal(val1)} AND ${writeVal(val2)}',
        parent: this);
  }

  SQLExpression union(SQLExpression another) =>
      SQLExpression(op: 'UNION', value: another, parent: this);

  SQLExpression on(String column) => SQLOnClause(column, parent: this);

  SQLExpression exists() =>
      SQLExpression(op: 'EXISTS', value: null, parent: this);

  SQLExpression inList(List<dynamic> vals) {
    String val = vals.map((val) => writeVal(val)).join(', ');
    return SQLExpression(op: 'IN', value: '($val)', parent: this);
  }

  SQLSelectQuery inSelect([List<String> projection = const []]) {
    final expr = SQLExpression(op: 'IN', parent: this);
    return SQLSelectQuery(projection: projection, parent: expr);
  }

  SQLExpression like(String pattern) =>
      SQLExpression(op: 'LIKE', value: pattern, parent: this);

  SQLExpression not([String? column]) =>
      SQLExpression(op: 'NOT', value: column, parent: this);

  SQLExpression or([String? column]) =>
      SQLExpression(op: 'OR', value: column, parent: this);

  SQLOrderBy orderBy(List<String> columns) => SQLOrderBy(columns, parent: this);

  ///key=column name value=  asc(true)/desc(false) boolean
  SQLOrderBy orderByIndividual(Map<String, bool> columns_individual_order) =>
      SQLOrderBy.fromColumnMap(columns_individual_order, parent: this);
}
