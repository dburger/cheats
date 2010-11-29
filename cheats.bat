# bcp dump from table into pipe separated file SQL server DOS command line
bcp dses_rollup.dbo.service_no_ssn_list out out.psv /S10.0.6.18 /c /t"|" /Upandora /Ppassword

# bcp dump from query into pipe separated file SQL server DOS command line
bcp "SELECT NULL, NULL, activity_code, activity_description, geo_code,
  geo_name, geo_region, long_name, major_command_uic, organization_type,
  parent_uic, service, short_name, source, uic,
  CASE WHEN position IS NULL THEN -1 ELSE position END, leaf
  FROM dses_rollup.dbo.unit_dimension
  WHERE current_unit = 1" queryout out.csv /Upandora /Ppassword
  /S10.0.6.18 /c /t"|"

# bcp import from text file SQL server DOS command line
bcp dses_rollup.dbo.traces_fact in trac2es_movements.dump -S localhost -U sa -P password -c -t "|^"

# dump schema SQL server DOS command line
sqlcmd  -U sa -P password -i trac2es_movements_schema.dump
