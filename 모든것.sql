-- 시험내용
-- 총 13문제
-- 0 테이블만들기
-- 1-10 DML 쿼리문제
-- 11-12 몽고디비

-- 1.	DDL(데이터 정의어)//////////////////////////////////////////////////////// 
-- 테이블 생성
-- 정수형숫자:NUMBER(4) / 가변형문자열:VARCHAR2(10) / 날짜:DATE / 소수둘째자리까지숫자:NUMBER(7,2)
CREATE TABLE EMP_TEST(
    EMPNO   NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME   VARCHAR2(10),
    JOB     VARCHAR2(9),
    MGR     NUMBER(4),
    HIREDATE    DATE,
    SAL     NUMBER(7,2),
    COMM    NUMBER(7,2),
    DEPTNO  NUMBER(2) CONSTRAINT EMPFK_EMPNO_FK REFERENCES TABLE_FK (DEPTNO)
);  
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


-- 테이블 삭제 : 영원히 삭제. 롤백 안됨
DROP TABLE EMP_TEMP;




-- 2.DML(데이터 조작어)////////////////////////////////////////////////////////
-- 테이블 복사 생성
CREATE TABLE DEPT_TEMP
    AS SELECT * FROM DEPT;  
-- EMP_TEMP 빈공간 만들기
CREATE TABLE EMP_TEMP
AS SELECT *
FROM EMP
WHERE 1 <> 1;

-- 데이터 추가 : 컬럼 지정 안하면 NULL 처리
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (50, 'DATABASE', 'SEOUL');

-- 서브쿼리를 이용해서 한번에 여러데이터 추가
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
AND S.GRADE = 1
;

-- 데이터 수정
-- 컬럼 LOC 전체가 바뀜
UPDATE DEPT_TEMP2
SET LOC = 'SEOUL'; 
-- 조건문으로 부분 수정
UPDATE DEPT_TEMP2
SET DNAME = 'DATABASE',
    LOC   = 'SEOUL'
WHERE DEPTNO = 40 ;

UPDATE DEPT_TEMP2
SET (DNAME, LOC) = (SELECT DNAME, LOC
                    FROM DEPT
                    WHERE DEPTNO = 40  
                    ) 
WHERE DEPTNO = 40    
;  

-- 데이터 삭제
DELETE FROM EMP_TEMP2
WHERE JOB = 'MANAGER'; 



-- 3.기본////////////////////////////////////////////////////////
--현재 시간 조회 
select sysdate from dual;

-- ORDER BY
-- 정렬
-- ORDER BY ASC(오름:1-10) DESC(내림:10-1) 
-- 위치 : 맨아래. 실행되는 순서는 SELECT 한 후에 ODER BY 한다.
SELECT *
  FROM EMP
 ORDER BY SAL DESC;

-- WHERE 절
-- 4)급여가 1500 이상이고 커미션이 NULL이 아닌 사원만 조회하시오.
-- 힌트) 커미션이 NULL이 아닌 : COMM IS NOT NULL 
SELECT *
  FROM EMP
 WHERE SAL >= 1500 
       AND COMM IS NOT NULL -- 값이 없다.
       AND COMM != 0;       -- 값이 0 이다.

-- 4.연산자////////////////////////////////////////////////////////
-- 기호(+, -, *, /) 또는 특정 키워드(AND, OR, LIKE), IS NULL, IS NOT NULL
-- BETWEEN A AND B
-- LIKE 연산자 ENAME LIKE 'A%' : A로 시작
-- 집합 연산자 `UNION`, `UNION ALL`, `MINUS`, `INTERSECT`

-- DISTINCT
-- 1) 직무 목록 중복 없이 출력(직무) 
-- 중복 데이터 삭제 DISTINCT
-- - 정렬을 한다
-- - SELECT 바로 뒤에만 사용할 수 있다.
-- - COUNT(DISTINCT JOB) 개수 셀 때 많이 사용됨
SELECT DISTINCT JOB
  FROM EMP; 

-- IN ()
-- 6) 부서번호가 10, 20, 30 중 하나이고, 급여가 2000 이상인 사원을 출력하시오.
-- 힌트) 10, 20, 30 중 하나 : IN (10, 20, 30)
SELECT *
  FROM EMP
 WHERE DEPTNO IN(10, 20, 30) AND SAL >= 2000;  

-- LIKE 연산자
-- 2)**이름에 ‘AM’을 포함하는 사원 이름과 직무를 출력하시오.** 
SELECT ENAME
    , JOB 
FROM EMP 
WHERE ENAME LIKE '%AM%';

-- BETWEEN A AND B 
-- 1)**'CLERK'인 사원 중 급여가 1000에서 1500 사이인 사원을 조회하시오.**
SELECT *
  FROM EMP
 WHERE JOB = 'CLERK'
       AND SAL BETWEEN 1000 AND 1500; 

-- IS NULL
-- 3)**부서번호가 10번인 사원 중, 직무가 'MANAGER'가 아닌 사원을 출력하시오.
-- 단, MGR이 NULL인 사람도 포함하시오.**
-- 힌트)mgr IS NULL
SELECT *
  FROM EMP 
 WHERE DEPTNO = 10
   AND (JOB != 'MANAGER' OR MGR IS NULL); 





-- 5.함수////////////////////////////////////////////////////////
-- 이름과 괄호(()) 형식
-- 단일행 함수: 각 행마다 결과를 반환 (예: UPPER(), ROUND(), SUBSTR(), COALESCE())
-- 집계 함수: 여러 행을 그룹화하여 하나의 결과를 반환 (예: SUM(), AVG(), COUNT())
-- 예시: SELECT ROUND(AVG(salary), 0) FROM employees (여기서 ROUND와 AVG는 함수입니다.)

-- | 함수 종류 | 함수명 | 예시 | 설명 |
-- |-----------|--------|------|------|
-- | 문자열 | `LENGTH`, `SUBSTR`, `INSTR`, `REPLACE`, `TRIM` | `LENGTH('ABC')` → 3 | 문자열 길이, 자르기 등 |
-- | 숫자 | `ROUND`, `TRUNC`, `MOD` | `ROUND(123.456, 2)` → 123.46 | 반올림, 나머지 등 |
-- | 날짜 | `SYSDATE`, `ADD_MONTHS`, `MONTHS_BETWEEN` | `SYSDATE - HIRE_DATE` | 날짜 계산 |
-- | 변환 | `TO_CHAR`, `TO_DATE`, `TO_NUMBER` | `TO_DATE('2024-01-01')` | 자료형 변환 |
-- | NULL | `NVL`, `NVL2`, `COALESCE` | `NVL(COMM, 0)` | NULL 값 대체 |
-- | 조건 | `DECODE`, `CASE` | `CASE WHEN ... THEN ...` | IF-ELSE와 유사 |

-- - **날짜 비교**: 
SELECT SYSDATE - HIREDATE FROM EMP;
-- - **NULL 처리**: 
SELECT ENAME, NVL(COMM, 0) FROM EMP;
-- - **조건 분기**: 
SELECT ENAME, CASE WHEN JOB = 'MANAGER' THEN 'Y' ELSE 'N' END AS IS_MANAGER FROM EMP;

-- UPPER / LOWER / INITCAP
SELECT ENAME
     , UPPER(ENAME) AS "대문자로"
     , LOWER(ENAME) AS "소문자로" 
     , INITCAP(ENAME) AS "첫글자만 대문자로" 
FROM EMP;

-- LENGTH / LENGTHB
-- LEHGTH(내용) : 글자 길이를 가져올때. 숫자로 가져옴
-- 번째글자부터:-LEHGTH(내용) -> 첫글자부터라는 의미
SELECT ENAME
     , LENGTH(ENAME) AS "이름의길이" 
     , LENGTHB(ENAME) AS "이름의길이BYTE" 
FROM EMP;

-- SUBSTR / INSTR  1번째 2자리
-- SUBSTR(내용, 시작위치, 몇개를) : 잘라 올것인가. 문자를 잘라올때
-- SUBSTR(내용,번째글자부터,몇글자선택 )
-- INSTR(내용, 찾는문자, 시작위치, 찾는문자몇번째(옵션)) : 찾는문자의 위치(몇번째)를 가져올때. 자로 가져옴
SELECT JOB
     , INSTR(JOB, 'A') AS "A포함"
     , SUBSTR(JOB, -3) AS "뒤에서3자리"
     , SUBSTR(JOB, 1, 2) AS "1번째 자리부터 2개"
FROM EMP;


-- REPLACE(내용, 변경전내용, 변경후내용) : 내용을 변경할때
SELECT REPLACE('010-1234-5678', '-', '') AS 교체
     , REPLACE('010-1234-5678', '-') AS 교체
     , SUBSTR(REPLACE('010-1234-5678', '-', ''), 4, 4) AS 앞4개
     , SUBSTR(REPLACE('010-1234-5678', '-', ''), 8, 4) AS 뒤4개
     , SUBSTR('010-1234-5678', -9, 4) AS 앞4개
     , SUBSTR('010-1234-5678', -4, 4) AS 뒤4개
     , SUBSTR('010-1234-5678', INSTR('010-1234-5678', '-'), 4) AS 앞4개 
     , SUBSTR('010-1234-5678', INSTR('010-1234-5678', '-'), 4) AS 앞4개 
     , REPLACE('010-1234-5678', '-', '')
  FROM DUAL;

SELECT '010-1234-5678' AS 연락처
     , '260105-123456' AS 주민번호 
     , RPAD('010-1234-5678',10,'#') AS 기냥 
     , RPAD(
            SUBSTR('010-1234-5678',1, INSTR('010-1234-5678','-',1,2)),
            LENGTH('010-1234-5678'),
            '#'
            ) AS 샵처리 
FROM DUAL;

SELECT '010-1234-****' AS 연락처
     , '260105-1*****' AS 주민번호 
     , REPLACE('010-1234-5678', '5', '*')
FROM DUAL;


-- CONCAT(내용, 내용) : 내용을 연결. 오라클에서는 -> 내용 || 내용
SELECT CONCAT(ENAME, EMPNO) 
    , CONCAT('사번:', EMPNO) 
    , CONCAT('성명:', ENAME) 
    , CONCAT(CONCAT('사번:', EMPNO) , CONCAT('성명:', ENAME)) 
    , '사번:' || EMPNO || '성명:'|| ENAME 
FROM EMP;


-- ROUND / TRUNC / MOD
-- 반올림 / 버림 / 나머지(나머지로 홀수짝수 구분하기 위해 사용한다)
SELECT 
      SAL/3 AS "비교값"
    , ROUND(SAL/3) AS "반올림"
    , ROUND(SAL/3,2) AS "3번째 반올림"
    , TRUNC(SAL/3)  AS "버림"
    , TRUNC(SAL/3,2) AS "버림 2번째까지 가져옴"
    , MOD(EMPNO,2) AS "2로 나눈 값"
FROM EMP;

-- ADD_MONTHS(SYSDATE,1) : 1개월후
-- MONTHS_BETWEEN(HIREDATE, SYSDATE) : 두 날짜간 개월수 차이
-- NEXT_DAY(SYSDATE,'월요일') : 돌아오는 요일의 DATE
-- LAST_DAY(SYSDATE) : 속한 달의 마지막 날짜
SELECT 
      ADD_MONTHS(SYSDATE,1)
    , MONTHS_BETWEEN(HIREDATE, SYSDATE)
    , NEXT_DAY(SYSDATE,'월요일')
    , LAST_DAY(SYSDATE) 
FROM EMP;

-- 자료형 반환하는 변환 함수
-- TO_CHAR
-- TO_NUMBER
-- TO_DATE

-- 정렬로 구분하기
-- 숫자 : 오른쪽
-- 날짜 : 왼쪽
-- 문자 : 왼쪽 

SELECT 
      SAL
    , TO_CHAR(SAL, '$999,999') AS 달러 
    , TO_DATE('2026/01/06', 'YYYY/MM/DD')
    , TO_NUMBER('20260106')
    , HIREDATE - TO_DATE('1980-12-17')
    , LENGTH(SAL)
FROM EMP
ORDER BY LENGTH(SAL) DESC; 

-- NVL(내용, NULL일때반환값)  : NULL이 아니면 그대로 / NULL이면 0
-- NVL2(내용, NULL아닐때값, NULL일때값) : NULL이 아니면 0 / NULL이면 X
SELECT 
      NVL(COMM,0)  
    , NVL(COMM,0) + 1
    , NVL2(COMM,COMM,10)
    , NVL2(COMM,'0','x') AS NVL2
    , DECODE(COMM
        ,0, 'x'
        ,NULL, 'x'
        , '0'
      ) AS DECODE
    , NVL2(COMM,SAL*12+COMM, SAL*12) AS ANNSAL 
FROM EMP; 


-- DECODE(비교할컬럼, '조건', 반환할 값 : IF ELSE와 같다)
-- CASE 비교할컬럼 WHEN 조건 THEN 반환할 값...... END : WHEN을 여러번 사용가능
-- NULL 비교는 IS NULL
SELECT 
      EMPNO
    , ENAME
    , JOB
    , SAL
    , DECODE(JOB
        , 'MANAGER', SAL*1.1
        , 'SALESMAN', SAL*1.05
        , 'ANALYST', SAL
        , SAL*1.03
    ) AS UPSAL
    , CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN'THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL*1.03
    END AS UPSAL2
    , CASE 
        WHEN JOB = 'MANAGER' THEN 1
        WHEN ENAME = 'SMITH' THEN 2 
        WHEN COMM IS NULL THEN 3 
        ELSE 0
    END AS UPSAL3 
FROM EMP
ORDER BY UPSAL;  



-- SUM  합계
-- COUNT  데이터 개수 : NULL은 COUNT에서 제외된다
-- MAX  최대값
-- MIN  최소값
-- AVG  평균값 

SELECT 
        DEPTNO
      , JOB
      , SUM(SAL)
      , SUM(COMM) 
FROM EMP
GROUP BY JOB, DEPTNO;

SELECT  
        MAX(HIREDATE)
      , MIN(HIREDATE)
      , COUNT (COMM)
FROM EMP;



-- GROUP BY : 그룹화
-- HAVING : GROUP 에 대해서만 제한
-- ORDER BY : 정렬 ASE(기본) 오름차순, DESE 내림차순






-- 6.JOIN ////////////////////////////////////////////////////////-- INNER OUTER
-- UNION 세로추가. JOIN 가로추가 
-- PK : 유니크(유일), NOT NULL 안됨, 자동인덱스 생성 
-- 등가조인 INNER 등가 조인 : '=' 사용
-- 비등가 조인 : 등가 조인 외 
-- 자체(셀프) 조인 : 하나의 테이블을 여러 테이블처럼 사용
-- 외부 조인 OUTER : 조인 조건의 NULL 데이터도 출력
-- 왼쪽 외부 조인(Left Outer Join)	    WHERE TABLE1.COL1 = TABLE2.COL1(+)
-- 오른쪽 외부 조인(Right Outer Join)	  WHERE TABLE1.COL1(+) = TABLE2.COL1
-- 등가조인
SELECT 
      E.EMPNO
    , E.ENAME
    , E.DEPTNO
    , D.DNAME
    , D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- 셀프조인
SELECT
      E1.EMPNO
    , E1.ENAME AS ENAME_ENAME
    , E1.MGR
    , E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;  

-- LEFT OUTER JOIN
-- 기준이 되는 놈이 다 나와야 한다. 그래서 + 를 해준다
-- LEFT 가 많이 쓰임
-- (+) 는 반대로. 있는쪽이 없는쪽에 갖다 붙인다.ALTER
-- (+) 기호가 붙은 테이블의 정보가 없더라도 반대쪽 테이블의 정보는 모두 표시
-- 없는건 NULL 처리해서 나옴
SELECT
      E1.EMPNO
    , E1.ENAME AS ENAME_ENAME
    , E1.MGR
    , E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);  


-- 서브쿼리
-- 오더보이 안됨
-- select : 스컬리, 다행일때
-- from : 하나의 테이블처럼 쓴다
-- whrer : 조건으로 비교 검색할때
SELECT *
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO(+)
  AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
  AND SAL > (SELECT AVG(SAL)
              FROM EMP)
; 
