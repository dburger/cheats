-- insert records from table2 into table1 where the record does not exist in
-- table1 (MySql)
INSERT INTO table1 (
    SELECT t2.* FROM table2 t2 LEFT JOIN table1 t1
    ON t2.id = t1.id WHERE t1.id IS NULL
);


-- same as above, real world example (MySql)
INSERT INTO dses_rollup.dbo.unit_dimension
    (uic, short_name, long_name, service, parent_uic, major_command_uic,
     organization_type, activity_code, activity_description, geo_code,
     geo_name, geo_region, source, effective_date, expiration_date,
     current_unit)
(
 SELECT
     uhe.uic, uhe.short_name, uhe.long_name, uhe.service, uhe.parent_uic,
     uhe.major_command_uic, uhe.organization_type, uhe.activity_code,
     uhe.activity_description, uhe.geo_code, uhe.geo_name, uhe.geo_region,
     uhe.source, '1900-01-01', '9999-12-31', 1
 FROM
     dses_etl.dbo.unit_hierarchy_editor uhe LEFT JOIN
     dses_rollup.dbo.unit_dimension ud ON uhe.uic = ud.uic
 WHERE
     uhe.source = 'UNIT HIERARCHY EDITOR' AND
     ud.id IS NULL
);


-- dynamically determine latest table name for usage in an update query
-- (SQL Server)
DECLARE @table_name AS VARCHAR(MAX)
DECLARE @sql AS VARCHAR(MAX)

SELECT TOP 1 @table_name = table_name FROM stg_person.information_schema.tables
WHERE table_name LIKE 'person_2%' ORDER BY table_name DESC

SET @sql = 'UPDATE dses_rollup.dbo.dses_data_sources
            SET last_update = (
                SELECT CAST(CAST(MAX(effective_year) AS VARCHAR(255))+
                ''-''+CAST(MAX(effective_month) AS VARCHAR(255))+''-''+CAST(DAY(DATEADD(d,
                -DAY(DATEADD(m,1,GETDATE())),DATEADD(m,1,GETDATE()))) AS VARCHAR(255))
                AS DATETIME) FROM stg_person.dbo.'+@table_name+
           ')
            WHERE name = ''DMDC CIVILIAN PERSONNEL'''
exec(@sql)


-- mysql has an default escape character \
SELECT * FROM people WHERE symbol LIKE 'hello\_world';
-- or you can specify the escape character
SELECT * FROM people WHERE symbol LIKE 'hello|_world' ESCAPE '|';


-- tsql has no default but you can go with a single character class
SELECT * FROM people WHERE symbol LIKE 'hello[_]world';
-- or you can specify an escape character
SELECT * FROM people WHERE symbol LIKE 'hello|_world' ESCAPE '|';


-- mutli-table delete in mysql
DELETE address, licenseproperties, userLicenses, userprefs, userproperties, userroles, user
FROM
    address, licenseproperties, userLicenses, userprefs, userproperties, userroles, user
WHERE
    user.id = address.userId AND user.id = licenseproperites.userId AND ...
AND userId < 100000;


-- tsql style multi table update
UPDATE employment_statuses SET
    mde_id = esd.id
FROM employment_statuses es JOIN
   mde_mishaps.dbo.employment_statuses_dim esd ON
   es.tier1 = esd.employment_status_tier1 AND
   es.tier2 = esd.employment_status_tier2


-- some updates against a fact table from several raw tables, uses cursor etc.
-- on tsql
IF NOT EXISTS (SELECT * FROM information_schema.columns WHERE column_name = 'transport_mode' AND table_name = 'traces_fact')
BEGIN
  ALTER TABLE dbo.traces_fact ADD transport_mode VARCHAR(255)

  -- this only needs to be ran the first time we add these columns as the
  -- populate_traces_fact will handle filling in these columns for all new
  -- records in the future
  DECLARE @table_name VARCHAR(255)
  DECLARE @sql_string VARCHAR(4000)
  DECLARE mycursor CURSOR FOR SELECT table_name
      FROM stg_raw.information_schema.tables
      WHERE table_name LIKE 'traces_%'
  OPEN mycursor
  FETCH NEXT FROM mycursor INTO @table_name
  WHILE @@fetch_status = 0
  BEGIN
      SET @sql_string = 'UPDATE dbo.traces_fact SET
                            age = raw.age,
                            age_unit = raw.age_unit,
                            cite = raw.cite,
                            db = raw.db,
                            gender = raw.gender,
                            mission_id#_of_last_mission = raw.mission_id#_of_last_mission,
                            personnel_status_name = raw.personnel_status_name,
                            service_active_duty = raw.service_active_duty,
                            service_grade_code = raw.service_grade_code,
                            service_grade_name = raw.service_grade_name
                        FROM dbo.traces_fact JOIN stg_raw.dbo.' + @table_name + ' raw
                            ON dbo.traces_fact.pmr_identifier = raw.pmr_identifier'
      EXEC(@sql_string)
      FETCH NEXT FROM mycursor INTO @table_name
  END
  CLOSE mycursor
  DEALLOCATE mycursor
END


-- show the indices in a table mysql
SHOW INDEX FROM table;


-- set up mysql command line client to correctly display UTF8
SET NAMES utf8;


-- likewise iso-8859, latin1
SET NAMES latin1;


-- mysql check table integrity
mysqlcheck -uroot -proot -v  --all-databases


-- mysql repair
mysqlcheck -uroot -proot -v  -r database table


-- multi-table update example for mysql
UPDATE users u, user_unit_roles uur
    SET u.system_role_id = uur.role_id
    WHERE u.id = uur.user_id AND uur.all_units_flag = 1;


-- multi-table update with aggregate from related table
-- join a derived table and assign from the derived fields
-- mysql
UPDATE quiz_results JOIN (
   SELECT qr.id, COUNT(*) AS num_correct
       FROM quiz_results qr
       JOIN user_answers ua ON qr.id = ua.quiz_result_id
       JOIN answers a ON ua.answer_id = a.id
       WHERE a.correct = 1 GROUP BY qr.id) derived
   ON quiz_results.id = derived.id
   SET quiz_results.num_correct = derived.num_correct;


-- mysql change associated records when given the new set of related ids
DELETE FROM account_roles WHERE account_id = ? AND role_id NOT IN (?);
INSERT INTO user_roles (user_id, role_id)
    SELECT ?, r.id FROM
    roles r LEFT JOIN
    (SELECT role_id FROM account_roles WHERE account_id = ?) ar ON r.id = ar.role_id
    WHERE ar.role_id IS NULL AND r.id IN (?);


-- use case in select statement
SELECT urla.*, ag.id AS group_id,
    CASE ag.public WHEN 1 THEN
        ag.name
    ELSE
        CONCAT_WS(' ', rl.name, 'Direct Attributes')
    END AS group_name, ...


-- all database dump from one system, then load on another
> mysqldump -uroot -proot --all-databases >  dumpfile.sql
mysql> source dumpfile.sql


-- oracle 'SHOW CREATE TABLE' done from sqlplus
SQL> set pages 0
SQL> set long 999999
SQL> select dbms_metadata.get_ddl('TABLE', 'EMPLOYEES', 'EMP') from dual;


-- mysql simple add column to existing table
ALTER TABLE Services ADD Family VARCHAR(128) NOT NULL;


-- mysql delete from one table where the related row does not exist in the other
DELETE ti FROM TaskInstance ti LEFT JOIN Task t ON ti.TaskId = t.TaskId WHERE t.TaskId IS NULL;


-- mysql create a table for a select, different from the sybase (microsoft) extension
CREATE TABLE OrphanedTaskInstance (
  SELECT ti.* FROM TaskInstance ti LEFT JOIN Task t ON ti.TaskId = t.TaskId
  WHERE t.TaskId IS NULL AND ti.RepeatCount = -1
);


-- mysql multi table delete example
DELETE ti
FROM
 Arg a
 INNER JOIN TaskInstance ti
 INNER JOIN Task  t ON ti.TaskId = t.TaskId
 LEFT OUTER JOIN TaskInstanceArg tia ON (a.ArgId = tia.ArgId AND
                                         tia.TaskInstanceId = ti.TaskInstanceId)
 LEFT OUTER JOIN TaskArg ta ON (a.ArgId = ta.ArgId AND ta.TaskId = ti.TaskId)
 LEFT OUTER JOIN ServiceArg sa ON (a.ArgId = sa.ArgId AND
sa.ServiceId = t.ServiceId)
WHERE
 a.ArgId = 5001
 AND COALESCE(tia.Value, ta.Value, sa.Value, a.DefaultValue) = -1
 AND t.TaskType LIKE '%EXTRACTION%'


-- example of creating a mysql function to convert a bigint into its base 64 representation
-- actually not pure base 64 as we are appending an "=" and using a "websafe" alphabet
DELIMITER |
DROP FUNCTION IF EXISTS BASE64_ENCODE |
CREATE FUNCTION BASE64_ENCODE(input BIGINT)
  RETURNS BLOB
  DETERMINISTIC
BEGIN
  -- DECLARE base BLOB DEFAULT 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  -- "websafe" alphabet see CharBase64.java
  DECLARE base BLOB DEFAULT 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';
  DECLARE chunks TINYINT DEFAULT 11;
  DECLARE chunk TINYINT;
  DECLARE ret BLOB DEFAULT '';
  WHILE chunks > 0 DO BEGIN
    IF chunks = 11 THEN
      SET chunk = (input & 0xF) << 2;
      SET input = input >> 4;
    ELSE
      SET chunk = input & 0x3F;
      SET input = input >> 6;
    END IF;
    SET chunks = chunks - 1;
    SET ret = CONCAT(SUBSTRING(base, chunk + 1, 1), ret);
  END; END WHILE;
  RETURN CONCAT(ret, '=');
END |


-- TWO examples of looking for TaskInstances that don't point at valid server dims, one uses a subselect while
-- the other does not
SELECT ti.TaskInstanceId, tia.Value, s.Name, t.TaskType FROM
  TaskInstance ti
  JOIN TaskInstanceArg tia ON (ti.TaskInstanceId = tia.TaskInstanceId AND tia.ArgId = 5001)
  JOIN Task t ON t.TaskId = ti.TaskId
  JOIN Services s ON t.ServiceId = s.ServiceId
  LEFT JOIN ServerDim sd ON tia.Value = sd.ServerId
  WHERE sd.ServerId IS NULL

SELECT x.TaskInstanceId, x.Value, x.Name, x.TaskType FROM (
SELECT tia.TaskInstanceId, tia.Value, s.Name, t.TaskType FROM
   TaskInstance ti
   JOIN TaskInstanceArg tia ON ti.TaskInstanceId = tia.TaskInstanceId
   JOIN Task t ON t.TaskId = ti.TaskId
   JOIN Services s ON t.ServiceId = s.ServiceId
   WHERE tia.ArgId = 5001
) AS x LEFT JOIN ServerDim sd ON x.Value = sd.ServerId
WHERE sd.ServerId IS NULL;


-- multiple step example of removing an enum type by transferring the values to
-- a temporary column, altering the column, and copying them back in with a
-- where
-- add a temporary column to hold the current values for TaskType
ALTER TABLE Task
ADD TempTaskType ENUM('JAVA_SAMPLE_EXTRACTION', 'HEAPZ_GARBAGE_EXTRACTION',
     'EXCEPTION_EXTRACTION', 'SQL_EXTRACTION', 'SPLAT_EXTRACTION',
     'VARZ_EXTRACTION', 'ANALYSIS', 'SUMMARY_MAIL','AGGREGATION') NOT NULL;

-- copy the current TaskType values into the temporary column
UPDATE Task SET TempTaskType = TaskType;

-- switch the existing TaskType to the appropriate enum values
-- this will give warnings as the ones with underscores will not convert it is
-- not a problem as we will update from TempTaskType in next step
ALTER TABLE Task
MODIFY TaskType ENUM('JavaSampleExtraction', 'HeapzGarbageExtraction',
    'ExceptionExtraction', 'SqlExtraction', 'VarzExtraction','Analysis',
    'SummaryMail','Aggregation') NOT NULL;

-- copy the correct values back into TaskType based on the values in
-- the temporary column
UPDATE Task
SET TaskType = CASE TempTaskType
                 WHEN 'JAVA_SAMPLE_EXTRACTION' THEN 'JavaSampleExtraction'
                 WHEN 'HEAPZ_GARBAGE_EXTRACTION' THEN 'HeapzGarbageExtraction'
                 WHEN 'EXCEPTION_EXTRACTION' THEN 'ExceptionExtraction'
                 WHEN 'SQL_EXTRACTION' THEN 'SqlExtraction'
                 WHEN 'VARZ_EXTRACTION' THEN 'VarzExtraction'
                 WHEN 'ANALYSIS' THEN 'Analysis'
                 WHEN 'SUMMARY_MAIL' THEN 'SummaryMail'
                 WHEN 'AGGREGATION' THEN 'Aggregation'
               END;

-- drop the temporary column
ALTER TABLE Task DROP TempTaskType;


-- multiple step example of removing a set type by transferring the values to
-- a temporary column, altering the column, and copying them back in with a
-- where
-- add a tempory column to hold current Flags values
ALTER TABLE TaskInstance
ADD TempFlags SET('run_in_prod', 'run_in_corp') NOT NULL;

-- copy the current Flags values into the temporary column
UPDATE TaskInstance
SET TempFlags = Flags;

-- alter the current Flags schema to the camel case
-- will give warnings because values don't auto-convert
ALTER TABLE TaskInstance
MODIFY Flags SET('RunInProd', 'RunInCorp') NOT NULL;

-- copy the correctly camel case values back into the Flags column
UPDATE TaskInstance
SET Flags = CASE
              WHEN FIND_IN_SET('run_in_prod', TempFlags) AND FIND_IN_SET('run_in_corp', TempFlags) > 0 THEN 'RunInProd,RunInCorp'
              WHEN FIND_IN_SET('run_in_prod', TempFlags) > 0 THEN 'RunInProd'
              ELSE 'RunInCorp'
            END;

-- drop the temporary column
ALTER TABLE TaskInstance DROP TempFlags;


-- remote command line execution example against mysql, see looping example in cli
ssh root@$host "mysql -u user -ppassword database -e 'CHECKSUM TABLE IdSequences'"

-- remote command line execution of a batch of commands
cat sample.sql | ssh host "mysql -u user -p"