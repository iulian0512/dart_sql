library dart_sql;

import 'package:dart_sql/src/sql_with.dart';

import 'src/sql_delete_query.dart';
import 'src/sql_select_query.dart';
import 'src/sql_insert_query.dart';
import 'src/sql_update_query.dart';

export 'src/sql_delete_query.dart';
export 'src/sql_select_query.dart';
export 'src/sql_insert_query.dart';
export 'src/sql_update_query.dart';
export 'src/sql_join.dart';
export 'src/sql_on.dart';
export 'src/sql_expression.dart';
export 'src/sql_case_when.dart';
export 'src/sql_with.dart';

abstract class SQL {
  static SQLSelectQuery select([List<Object> projection = const []]) =>
      SQLSelectQuery(projection: projection, parent: null);

  static SQLDeleteQuery delete() => SQLDeleteQuery();

  static SQLInsertQuery insert() => SQLInsertQuery();

  static SQLUpdateQuery update() => SQLUpdateQuery();
}
