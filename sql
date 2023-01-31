
#################################################################
#	POSTGRES
#################################################################

CREATE DATABASE "database";
CREATE USER someuser WITH PASSWORD 'securepassword';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO someuser;
alter role admin set search_path = nsiv291test;
alter user set search_path = new_schema;

ALTER TABLE nsi_group ALTER COLUMN id DROP NOT NULL




https://dba.stackexchange.com/questions/276131/count-missing-values-in-each-column-of-the-table-in-postgresql

CREATE OR REPLACE FUNCTION f_count_nulls(_tbl regclass)
  RETURNS TABLE (column_name text, missing_values bigint)
  LANGUAGE plpgsql STABLE PARALLEL SAFE AS
$func$
BEGIN
   RETURN QUERY EXECUTE (
   SELECT format(
   $$
   SELECT x.*
   FROM  (SELECT count(*) AS ct, %s FROM %s) t
   CROSS  JOIN LATERAL (VALUES %s) x(col, nulls)
   ORDER  BY nulls DESC, col DESC
   $$, string_agg(format('count(%1$I) AS %1$I', attname), ', ')
     , $1
     , string_agg(format('(%1$L, ct - %1$I)', attname), ', ')
      )
   FROM   pg_catalog.pg_attribute
   WHERE  attrelid = $1
   AND    attnum > 0
   AND    NOT attisdropped
   -- more filters?
   );
END
$func$;
Call:

SELECT * FROM f_count_nulls('public.fortune500');  -- optionally schema-qualified



