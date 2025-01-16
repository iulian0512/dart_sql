import 'package:dart_sql/dart_sql.dart';

/// Represents a reference to a SQL column, optionally with an alias.
///
/// This class extends [SQLExpression] and is used to format a column
/// reference in SQL queries, supporting an optional alias.
class SQLColumnReference extends SQLExpression {
  /// The alias for the column, if any.
  final String? alias;

  /// The actual column reference (e.g., column name or expression).
  final Object reference;

  /// Creates a [SQLColumnReference] with the given [reference] and optional [alias].
  SQLColumnReference(Object this.reference, {String? this.alias})
      : super(value: reference);

  /// Writes the column reference to the provided [sink], including the alias if present.
  @override
  void writeTo(StringSink sink) {
    if (alias?.isNotEmpty == true) {
      sink.write("$reference as $alias");
    } else {
      sink.write("$reference");
    }
    sink.write(" ");
  }
}

/// Represents a synthetic SQL column reference, extending [SQLColumnReference].
///
/// This class is used for columns that are generated or derived in some way,
/// inheriting the functionality of [SQLColumnReference].
/// This is usually used when you want to crate a synthetic column from an expression such as: ?||'suffix' or 2+3+4 while passing an [alias]
class SQLSyntheticColumnReference extends SQLColumnReference {
  /// Creates a [SQLSyntheticColumnReference] with the given [value] and optional [alias].
  SQLSyntheticColumnReference(super.value, {super.alias});
}
