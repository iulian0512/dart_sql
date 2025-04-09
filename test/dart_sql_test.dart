import 'package:test/test.dart';
import 'package:dart_sql/dart_sql.dart';

void main() {
  group('SELECT Tests', () {
    test('SELECT * FROM aircraft', () {
      final sql = SQL.select([]).from('aircraft').toString();
      expect(sql, 'SELECT * FROM aircraft');
    });

    test('SELECT id, model, year FROM aircraft', () {
      final sql =
          SQL.select(['id', 'model', 'year']).from('aircraft').toString();
      expect(sql, 'SELECT id, model, year FROM aircraft');
    });

    test('SELECT * FROM aircraft ORDER BY model ASC', () {
      final sql = SQL.select().from('aircraft').orderBy(['model']).toString();
      expect(sql, 'SELECT * FROM aircraft ORDER BY model ASC');
    });

    test('SELECT * FROM aircraft ORDER BY model, year ASC LIMIT 5', () {
      final sql = SQL
          .select()
          .from('aircraft')
          .orderBy(['model', 'year'])
          .limit(5)
          .toString();
      expect(sql, 'SELECT * FROM aircraft ORDER BY model, year ASC LIMIT 5');
    });

    test('SELECT * FROM aircraft ORDER BY model DESC, year ASC LIMIT 5', () {
      final sql = SQL
          .select()
          .from('aircraft')
          .orderByIndividual({'model': true, 'year': false})
          .limit(5)
          .toString();
      expect(
          sql, 'SELECT * FROM aircraft ORDER BY model ASC, year DESC LIMIT 5');
    });

    test(
        'SELECT * FROM aircraft ORDER BY model ASC, year DESC, ST_DISTANCE(plane_location,ST_POINT(25,45)) ASC LIMIT 5',
        () {
      final sql = SQL
          .select()
          .from('aircraft')
          .orderByIndividual({'model': true, 'year': false},
              expressions: ["ST_DISTANCE(plane_location,ST_POINT(25,45)) ASC"])
          .limit(5)
          .toString();
      expect(sql,
          'SELECT * FROM aircraft ORDER BY model ASC, year DESC, ST_DISTANCE(plane_location,ST_POINT(25,45)) ASC LIMIT 5');
    });

    test('SELECT * FROM aircraft WHERE model = "SR22" ORDER BY model ASC', () {
      final sql = SQL
          .select()
          .from('aircraft')
          .where('model')
          .eq('SR22')
          .orderBy(['model']).toString();
      expect(sql,
          'SELECT * FROM aircraft WHERE model = "SR22" ORDER BY model ASC');
    });

    test('SELECT * FROM aircraft WHERE NOT model = "SR22"', () {
      final sql = SQL
          .select([])
          .from('aircraft')
          .where()
          .not('model')
          .eq('SR22')
          .toString();
      expect(sql, 'SELECT * FROM aircraft WHERE NOT model = "SR22"');
    });

    test(
        'SELECT * FROM aircraft WHERE NOT model = "SR22" AND NOT model = "SR22T"',
        () {
      final sql = SQL
          .select([])
          .from('aircraft')
          .where()
          .not('model')
          .eq('SR22')
          .and()
          .not('model')
          .eq('SR22T')
          .toString();
      expect(sql,
          'SELECT * FROM aircraft WHERE NOT model = "SR22" AND NOT model = "SR22T"');
    });

    test(
        'SELECT * FROM aircraft WHERE model = "SR22" AND landing_weight >= 3000',
        () {
      final sql = SQL
          .select()
          .from('aircraft')
          .where('model')
          .eq('SR22')
          .and('landing_weight')
          .gte(3000)
          .toString();
      expect(sql,
          'SELECT * FROM aircraft WHERE model = "SR22" AND landing_weight >= 3000');
    });

    test(
        'SELECT * FROM aircraft WHERE model = "SR22" AND year > 2000 OR year <= 2020',
        () {
      final sql = SQL
          .select([])
          .from('aircraft')
          .where('model')
          .eq('SR22')
          .and('year')
          .gt(2000)
          .or('year')
          .lte(2020)
          .toString();
      expect(sql,
          'SELECT * FROM aircraft WHERE model = "SR22" AND year > 2000 OR year <= 2020');
    });

    test('SELECT * FROM aircraft WHERE model IN ("SR22", "C172", "C170")', () {
      final sql = SQL
          .select()
          .from('aircraft')
          .where('model')
          .inList(["SR22", "C172", "C170"]).toString();

      expect(sql,
          'SELECT * FROM aircraft WHERE model IN ("SR22", "C172", "C170")');
    });

    test('SELECT * FROM aircraft WHERE model IN SELECT name FROM models', () {
      final sql = SQL
          .select()
          .from('aircraft')
          .where('model')
          .inSelect(['name'])
          .from('models')
          .toString();

      expect(
          sql, 'SELECT * FROM aircraft WHERE model IN SELECT name FROM models');
    });

    test('SELECT * FROM aircraft WHERE year BETWEEN 2000 AND 2020', () {
      final sql = SQL
          .select()
          .from('aircraft')
          .where('year')
          .between(2000, 2020)
          .toString();

      expect(sql, 'SELECT * FROM aircraft WHERE year BETWEEN 2000 AND 2020');
    });
  });

  group('DELETE Tests', () {
    test('DELETE FROM aircraft', () {
      final sql = SQL.delete().from('aircraft').toString();
      expect(sql, 'DELETE FROM aircraft');
    });

    test('DELETE FROM aircraft WHERE model = "SR22"', () {
      final sql =
          SQL.delete().from('aircraft').where('model').eq("SR22").toString();
      expect(sql, 'DELETE FROM aircraft WHERE model = "SR22"');
    });

    test('DELETE FROM aircraft WHERE NOT model = "SR22"', () {
      final sql = SQL
          .delete()
          .from('aircraft')
          .where()
          .not('model')
          .eq("SR22")
          .toString();
      expect(sql, 'DELETE FROM aircraft WHERE NOT model = "SR22"');
    });
  });

  group('Insert Queries', () {
    test('INSERT INTO aircraft (model, year) VALUES ("SR22", "2014")', () {
      Map<String, dynamic> values = {"model": "SR22", "year": "2014"};
      final sql = SQL.insert().into('aircraft').values(values).toString();
      expect(sql, 'INSERT INTO aircraft (model, year) VALUES ("SR22", "2014")');
    });

    test(
        'INSERT OR REPLACE INTO aircraft (model, year) VALUES ("SR22", "2014")',
        () {
      Map<String, dynamic> values = {"model": "SR22", "year": "2014"};
      final sql =
          SQL.insert().orReplace().into('aircraft').values(values).toString();
      expect(sql,
          'INSERT OR REPLACE INTO aircraft (model, year) VALUES ("SR22", "2014")');
    });
  });

  group('Update Queries', () {
    test('UPDATE aircraft SET model = "SR22", year = "2014" WHERE id = 12', () {
      Map<String, dynamic> values = {"model": "SR22", "year": "2014"};
      final sql = SQL
          .update()
          .setValues('aircraft', values)
          .where('id')
          .eq(12)
          .toString();
      expect(sql,
          'UPDATE aircraft SET model = "SR22", year = "2014" WHERE id = 12');
    });
  });

  group('Join Tests', () {
    test(
        'SELECT * FROM aircraft JOIN colors ON colors.id = aircraft.colorid AND colors.zorder = aircraft.zorder WHERE aircraft.id = 41',
        () {
      final sql = SQL
          .select()
          .from('aircraft')
          .join("colors")
          .on("colors.id")
          .eq(SQLExpression.ColumnReference('aircraft.colorid'))
          .and("colors.zorder")
          .eq(SQLExpression.ColumnReference('aircraft.zorder'))
          .where("aircraft.id")
          .eq(41)
          .toString();
      expect(sql,
          'SELECT * FROM aircraft JOIN colors ON colors.id = aircraft.colorid AND colors.zorder = aircraft.zorder WHERE aircraft.id = 41');
    });
  });

  group('Union Tests', () {
    test('select col1 from table1 union select col2 from table2', () {
      final t1select = SQL.select(["col1"]).from("table1");
      final t2select = SQL.select(["col2"]).from("table2");
      final sql = t1select.union(t2select).toString();

      expect(
          sql.toUpperCase(),
          'select col1 from table1 union select col2 from table2'
              .toUpperCase());
    });
  });

  group('With Tests', () {
    test(
        'with cte1 as (select col1 from table1), cte2 as (select col2 from table2) select * from cte1',
        () {
      final cte1select = SQL.select(["col1"]).from("table1");
      final cte2select = SQL.select(["col2"]).from("table2");
      final select = SQL.select().from("cte1");
      final sql = SQLWithQuery({"cte1": cte1select, "cte2": cte2select}, select)
          .toString();

      expect(
          sql.toUpperCase(),
          'with cte1 as (select col1 from table1), cte2 as (select col2 from table2) select * from cte1'
              .toUpperCase());
    });
  });

  group('Case When Tests', () {
    //with else
    test(
        'select case when id=1 then 1 when id=2 then 2 else 3 end as caseexpr from table',
        () {
      final caseexpr =
          SQLCaseWhen("caseexpr", {"id=1": "1", "id=2": "2"}, elseExpr: "3");
      final sql = SQL.select([caseexpr]).from("table").toString();

      expect(
          sql.toUpperCase(),
          'select case when id=1 then 1 when id=2 then 2 else 3 end as caseexpr from table'
              .toUpperCase());
    });

    //without else
    test(
        'select case when id=1 then 1 when id=2 then 2 end as caseexpr from table',
        () {
      final caseexpr = SQLCaseWhen("caseexpr", {"id=1": "1", "id=2": "2"});
      final sql = SQL.select([caseexpr]).from("table").toString();

      expect(
          sql.toUpperCase(),
          'select case when id=1 then 1 when id=2 then 2 end as caseexpr from table'
              .toUpperCase());
    });
  });

  group('Misc', () {
    test('column reference', () {
      final sql = SQL
          .select([SQLColumnReference("make", alias: "make_alias123")])
          .from('aircraft')
          .toString();
      expect(sql.toUpperCase(),
          'SELECT make as make_alias123 FROM aircraft'.toUpperCase());
    });
  });
}
