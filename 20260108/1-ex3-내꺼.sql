

-- 12장
-- 데이터 정의어
-- DDL
-- PLSQL

-- 테이블 생성///////////////////////
-- CREATE TABLE 소유 계정.테이블 이름(
--     열1 이름 열1 자료형,
--     열2 이름 열2 자료형,
--     ...
--     열N 이름 열N 자료형
-- );

-- 수정/////////////////////////
-- ALTER 수정한다 아래로
-- ADD          열 추가
-- RENAME       열 이름 변경
-- MODIFY       열 자료형을 변경
-- DROP         열 삭제
-- TRUNCATE     전체데이터 삭제 : COMMIT 안해도 됨. 롤백안됨


-- 테이블생성
CREATE TABLE EMP_DDL(
    EMPNO   NUMBER(4),
    ENAME   VARCHAR2(10),
    JOB     VARCHAR2(9),
    MGR     NUMBER(4),
    HIREDATE    DATE,
    SAL     NUMBER(7,2),
    COMM    NUMBER(7,2),
    DEPTNO  NUMBER(2)
);
-- 테이블생성 
CREATE TABLE EMP_DDL2(
    EMPNO   NUMBER(4) CONSTRAINT "PK_EMP" PRIMARY KEY,
    ENAME   VARCHAR2(10),
    JOB     VARCHAR2(9),
    MGR     NUMBER(4),
    HIREDATE    DATE,
    SAL     NUMBER(7,2),
    COMM    NUMBER(7,2),
    DEPTNO  NUMBER(2)
);

SELECT * FROM EMP_DDL;

-- 테이블 복사 생성
CREATE TABLE EMP_ALTER
    AS SELECT * FROM EMP;
);

SELECT * FROM EMP_ALTER;

-- 열 추가
ALTER TABLE EMP_ALTER
    ADD HP VARCHAR2(20);

-- 열 이름 변경
ALTER TABLE EMP_ALTER
    RENAME COLUMN HP TO TEL;

-- 열 자료형을 변경
ALTER TABLE EMP_ALTER
    MODIFY EMPNO NUMBER(5);

-- 열 삭제
ALTER TABLE EMP_ALTER
    DROP COLUMN TEL;


-- Q1
CREATE TABLE EMP_HW(
    EMPNO   NUMBER(4),
    ENAME   VARCHAR2(10),
    JOB     VARCHAR2(9),
    MGR     NUMBER(4),
    HIREDATE    DATE,
    SAL     NUMBER(7,2),
    COMM    NUMBER(7,2),
    DEPTNO  NUMBER(2)
);

CREATE TABLE EMP_HW2
    AS SELECT * FROM EMP; 

SELECT * FROM EMP_HW2;
-- Q2
ALTER TABLE EMP_HW2
    ADD BIGO VARCHAR2(20);

-- Q3
ALTER TABLE EMP_HW2
    MODIFY BIGO NUMBER(30);

-- Q4
ALTER TABLE EMP_HW2
    RENAME COLUMN BIGO TO REMARK;

-- Q5
INSERT INTO EMP_HW2 (REMARK)
VALUES(NULL); 


-- Q6
DROP TABLE EMP_HW;





