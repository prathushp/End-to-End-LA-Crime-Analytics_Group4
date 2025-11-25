--User Setup script

CREATE OR REPLACE WAREHOUSE LAPD_WH WAREHOUSE_SIZE = 'XSMALL';
CREATE OR REPLACE DATABASE LAPD_DB;
CREATE OR REPLACE SCHEMA LAPD_DB.DW;
CREATE OR REPLACE ROLE LAPD_ROLE;


GRANT OWNERSHIP ON DATABASE LAPD_DB TO ROLE ACCOUNTADMIN;


GRANT USAGE ON WAREHOUSE LAPD_WH TO ROLE LAPD_ROLE;

GRANT USAGE ON DATABASE LAPD_DB TO ROLE LAPD_ROLE;



GRANT OWNERSHIP ON SCHEMA LAPD_DB.DW TO ROLE LAPD_ROLE;
GRANT USAGE ON SCHEMA LAPD_DB.DW TO ROLE LAPD_ROLE;


CREATE OR REPLACE USER LAPD_USER PASSWORD = 'LAPD' DEFAULT_ROLE = LAPD_ROLE DEFAULT_WAREHOUSE = LAPD_WH;


GRANT ROLE LAPD_ROLE TO USER LAPD_USER;




--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Lapd_Dimensional_Model.DM1
--
-- Date Created : Friday, November 21, 2025 18:14:39
-- Target DBMS : Snowflake
--

-- 
-- TABLE: Arrest_DIM 
--

CREATE OR REPLACE TABLE Arrest_DIM(
    Arrest_SK             NUMBER(10, 0)    NOT NULL,
    Arrest_status         VARCHAR(10),
    Arrest_status_desc    VARCHAR(100),
    DI_Load_Dt            DATE,
    DI_Source_ID          VARCHAR(10),
    CONSTRAINT PK12 PRIMARY KEY (Arrest_SK) 
)
;



-- 
-- TABLE: CrimeType_DIM 
--

CREATE OR REPLACE TABLE CrimeType_DIM(
    Crime_SK           NUMBER(10, 0)    NOT NULL,
    Crime_Code         INTEGER,
    Crime_code_desc    VARCHAR(100),
    Part_1_2           NUMBER(10, 0),
    DI_load_Dt         DATE,
    DI_Source_ID       VARCHAR(100),
    CONSTRAINT PK5 PRIMARY KEY (Crime_SK) 
)
;



-- 
-- TABLE: Date_DIM 
--

CREATE OR REPLACE TABLE Date_DIM(
    DATE_SK             NUMBER(10, 0)    NOT NULL,
    FULL_DATE           DATE,
    DAY_OF_WEEK         INTEGER,
    DAY_NAME            CHAR(10),
    MONTH_NUM           INTEGER,
    MONTH_NAME          CHAR(10),
    QUARTER             INTEGER,
    QUARTER_NAME        CHAR(10),
    YEAR                INTEGER,
    MONTH_START_DATE    DATE,
    MONTH_END_DATE      DATE,
    IS_WEEKEND          VARCHAR(18),
    CONSTRAINT PK7_1 PRIMARY KEY (DATE_SK) 
)
;



-- 
-- TABLE: Descent_DIM 
--

CREATE OR REPLACE TABLE Descent_DIM(
    Descent_SK             NUMBER(10, 0)    NOT NULL,
    Victim_Descent         VARCHAR(100),
    Descent_Description    VARCHAR(100),
    DI_Load_Dt             DATE,
    DI_Source_ID           VARCHAR(100),
    CONSTRAINT PK17 PRIMARY KEY (Descent_SK) 
)
;



-- 
-- TABLE: FACT_CRIME 
--

CREATE OR REPLACE TABLE FACT_CRIME(
    Crime_key         NUMBER(10, 0),
    Days_to_Report    INTEGER,
    File_number       VARCHAR(10)      NOT NULL,
    Premis_SK         NUMBER(10, 0),
    Weapon_SK         NUMBER(10, 0),
    Crime_SK          NUMBER(10, 0),
    Time_Key          INTEGER,
    Arrest_SK         NUMBER(10, 0),
    Location_ID       INTEGER,
    Victim_SK         NUMBER(10, 0),
    DATE_SK           NUMBER(10, 0),
    Descent_SK        NUMBER(10, 0)
)
;



-- 
-- TABLE: Location_DIM 
--

CREATE OR REPLACE TABLE Location_DIM(
    Location_ID           INTEGER             NOT NULL,
    Area                  INTEGER,
    Area_Name             VARCHAR(100),
    Reporting_District    INTEGER,
    Location              VARCHAR(100),
    Cross_Street          VARCHAR(100),
    Latitude              DOUBLE PRECISION,
    Longitude             DOUBLE PRECISION,
    DI_Source_ID          VARCHAR(100),
    DI_Load_Dt            DATE,
    CONSTRAINT PK1_1 PRIMARY KEY (Location_ID) 
)
;



-- 
-- TABLE: Premis_DIM 
--

CREATE OR REPLACE TABLE Premis_DIM(
    Premis_SK       NUMBER(10, 0)    NOT NULL,
    Premis_Code     NUMBER(10, 0),
    Premis_desc     VARCHAR(1000),
    DI_load_Dt      DATE,
    DI_Source_ID    VARCHAR(10),
    CONSTRAINT PK1 PRIMARY KEY (Premis_SK) 
)
;



-- 
-- TABLE: Time_DIM 
--

CREATE OR REPLACE TABLE Time_DIM(
    Time_Key         VARCHAR(4)         NOT NULL,
    Time_24_HR       VARCHAR(100),
    Hour             INTEGER,
    Minute           INTEGER,
    Period_Of_Day    VARCHAR(10),
    Dt_Source_ID     VARCHAR(10),
    DI_Load_Dt       DATE,
    CONSTRAINT PK2_1 PRIMARY KEY (Time_Key) 
)
;



-- 
-- TABLE: Victim_DIM 
--

CREATE OR REPLACE TABLE Victim_DIM(
    Victim_SK              NUMBER(10, 0)    NOT NULL,
    Victim_age             NUMBER(10, 0),
    Victim_age_category    VARCHAR(100),
    Victim_sex             VARCHAR(10),
    DI_Load_Dt             DATE,
    DI_Source_ID           VARCHAR(100),
    CONSTRAINT PK8 PRIMARY KEY (Victim_SK) 
)
;



-- 
-- TABLE: Weapon_DIM 
--

CREATE OR REPLACE TABLE Weapon_DIM(
    Weapon_SK           NUMBER(10, 0)    NOT NULL,
    Weapon_Used_Code    NUMBER(10, 0),
    Weapon_Desc         VARCHAR(100),
    DI_Load_Dt          DATE,
    DI_Source_ID        VARCHAR(100),
    CONSTRAINT PK6 PRIMARY KEY (Weapon_SK) 
)
;



-- 
-- TABLE: FACT_CRIME 
--

ALTER TABLE FACT_CRIME ADD CONSTRAINT RefPremis_DIM1 
    FOREIGN KEY (Premis_SK)
    REFERENCES Premis_DIM(Premis_SK)
;

ALTER TABLE FACT_CRIME ADD CONSTRAINT RefWeapon_DIM2 
    FOREIGN KEY (Weapon_SK)
    REFERENCES Weapon_DIM(Weapon_SK)
;

ALTER TABLE FACT_CRIME ADD CONSTRAINT RefCrimeType_DIM3 
    FOREIGN KEY (Crime_SK)
    REFERENCES CrimeType_DIM(Crime_SK)
;

ALTER TABLE FACT_CRIME ADD CONSTRAINT RefTime_DIM4 
    FOREIGN KEY (Time_Key)
    REFERENCES Time_DIM(Time_Key)
;

ALTER TABLE FACT_CRIME ADD CONSTRAINT RefArrest_DIM5 
    FOREIGN KEY (Arrest_SK)
    REFERENCES Arrest_DIM(Arrest_SK)
;

ALTER TABLE FACT_CRIME ADD CONSTRAINT RefLocation_DIM7 
    FOREIGN KEY (Location_ID)
    REFERENCES Location_DIM(Location_ID)
;

ALTER TABLE FACT_CRIME ADD CONSTRAINT RefVictim_DIM8 
    FOREIGN KEY (Victim_SK)
    REFERENCES Victim_DIM(Victim_SK)
;

ALTER TABLE FACT_CRIME ADD CONSTRAINT RefDate_DIM9 
    FOREIGN KEY (DATE_SK)
    REFERENCES Date_DIM(DATE_SK)
;

ALTER TABLE FACT_CRIME ADD CONSTRAINT RefDescent_DIM10 
    FOREIGN KEY (Descent_SK)
    REFERENCES Descent_DIM(Descent_SK)
;





--Date-Load script
INSERT INTO Date_DIM (
    DATE_SK,
    FULL_DATE,
    DAY_OF_WEEK,
    DAY_NAME,
    MONTH_NUM,
    MONTH_NAME,
    QUARTER,
    QUARTER_NAME,
    YEAR,
    MONTH_START_DATE,
    MONTH_END_DATE,
    IS_WEEKEND
)
WITH DATES AS (
    SELECT 
        DATEADD(DAY, SEQ4(), DATE '2010-01-01') AS DATE_KEY
    FROM TABLE(GENERATOR(ROWCOUNT => 365*21))  -- 21 years (2010-2030)
    WHERE DATEADD(DAY, SEQ4(), DATE '2010-01-01') <= '2030-12-31'
)
SELECT 
    CAST(TO_CHAR(DATE_KEY, 'YYYYMMDD') AS NUMBER(10,0)) AS DATE_SK,
    DATE_KEY AS FULL_DATE,
    DAYOFWEEK(DATE_KEY) AS DAY_OF_WEEK,
    CAST(TO_CHAR(DATE_KEY, 'DY') AS CHAR(10)) AS DAY_NAME,
    MONTH(DATE_KEY) AS MONTH_NUM,
    CAST(TO_CHAR(DATE_KEY, 'MON') AS CHAR(10)) AS MONTH_NAME,
    QUARTER(DATE_KEY) AS QUARTER,
    CAST('Q' || QUARTER(DATE_KEY) AS CHAR(10)) AS QUARTER_NAME,
    YEAR(DATE_KEY) AS YEAR,
    DATE_TRUNC('MONTH', DATE_KEY) AS MONTH_START_DATE,
    LAST_DAY(DATE_KEY) AS MONTH_END_DATE,
    CAST(CASE 
        WHEN DAYOFWEEK(DATE_KEY) IN (1, 7) THEN 'Y' 
        ELSE 'N' 
    END AS VARCHAR(18)) AS IS_WEEKEND
FROM DATES
ORDER BY DATE_SK;




--Time load script
INSERT INTO TIME_DIM (
    Time_Key,
    Time_24_HR,
    Hour,
    Minute,
    Period_Of_Day,
    Dt_Source_ID,
    DI_Load_Dt
)
WITH hh AS (
    SELECT LPAD(SEQ4()::varchar, 2, '0') AS H
    FROM TABLE(GENERATOR(ROWCOUNT => 24))   -- 0–23 hours
),
mm AS (
    SELECT LPAD(SEQ4()::varchar, 2, '0') AS M
    FROM TABLE(GENERATOR(ROWCOUNT => 60))   -- 0–59 minutes
)
SELECT
    (H || M) AS Time_Key,                         -- 'HHMM'
    (H || ':' || M) AS Time_24_HR,                -- 'HH:MM'
    H::int AS Hour,
    M::int AS Minute,
    CASE
        WHEN H::int BETWEEN 6 AND 11 THEN 'Morning'
        WHEN H::int BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN H::int BETWEEN 17 AND 20 THEN 'Evening'
        ELSE 'Night'
    END AS Period_Of_Day,
    'LAPD_DW' AS Dt_Source_ID,
    CURRENT_DATE() AS DI_Load_Dt
FROM hh, mm
ORDER BY 1;
