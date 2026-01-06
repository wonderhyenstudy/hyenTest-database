 

-- SELECT 
-- FROM EMP;

-- SELECT 
-- FROM DUAL;

SELECT SYSDATE
, SYSDATE - 1 AS "-1"
, SYSDATE + 1 AS "+1"
FROM DUAL;

-- SELECT EMPNO, ENAME, HIREDATE
--     , ADD_MONTHS(HIREDATE,240)
-- FROM DUAL;


SELECT ADD_MONTHS(SYSDATE,1)
FROM EMP;

-- 480개월 일한 사람 뽑기
SELECT ENAME, HIREDATE, ADD_MONTHS(HIREDATE,480)
FROM EMP
WHERE ADD_MONTHS(HIREDATE,480) < SYSDATE;


-- SELECT ENAME, HIREDATE, MONTHS_BETWEEN(HIREDATE, ROUND(SYSDATE, 2))
-- FROM EMP;

SELECT ENAME, HIREDATE, MONTHS_BETWEEN(HIREDATE, SYSDATE)
FROM EMP;


SELECT 
      NEXT_DAY(SYSDATE,'월요일')
    , LAST_DAY(SYSDATE) 
FROM EMP; 

-- 자료형 반환하는 변환 함수
-- TO_CHAR
-- TO_NUMBER
-- TO_DATE

-- 날짜
SELECT 
      TO_CHAR(1)
    , 1 
    , '1'
    , EMPNO
    , '사번 :' || TO_CHAR(EMPNO) AS 정석COMM
    , '사번 :' || EMPNO AS 자동으로해줌
    -- , TO_CHAR(SYSDATE, 'YYYY') AS YYYY
    -- , TO_CHAR(SYSDATE, 'MM') AS MM
    -- , TO_CHAR(SYSDATE, 'DD') AS DD
    , TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS 자주사용
FROM EMP; 

-- 환율
SELECT 
      SAL
    , TO_CHAR(SAL, '$999,999') AS 달러
    , TO_CHAR(SAL, 'L999,999') AS "원(로컬)"
    , TO_CHAR(12345875, 'L999,999,999') AS "원(로컬)"
    -- 최대금액이 얼마인지 알아야 한다
    , LENGTH(SAL)
FROM EMP
ORDER BY LENGTH(SAL) DESC; 


-- SELECT 
--       TO_NUMBER(1)
--     , TO_NUMBER('1')
--     , TO_NUMBER('1.333', '999,999') + 1
-- FROM EMP; 

SELECT 
      TO_DATE('2026-01-06', 'YYYY-MM-DD')
    , TO_DATE('2026/01/06', 'YYYY/MM/DD')
FROM DUAL; 

-- 실습 : 최초 입사자와 각각 입사자의 근무일차를 구하시오
-- 사원, 이름, 입사일, 차이일
-- 1. 최초 입사자 구하기 : ORDER BY
-- 2. 최초 입사자 : 날짜 - 날짜 TO_DATE(HIREDATE)
-- SELECT 
--       EMPNO
--     , ENAME
--     , HIREDATE
--     -- , (SELECT HIREDATE FROM EMP WHERE ORDER BY ) AS 근무일차 
--     , TO_DATE(HIREDATE) AS 근무일차 
-- FROM EMP
-- WHERE HIREDATE = ORDER BY HIREDATE; 

-- SELECT 
--       EMPNO
--     , ENAME
--     , HIREDATE
--     -- , (SELECT HIREDATE FROM EMP WHERE ORDER BY ) AS 근무일차 
--     , TO_DATE(HIREDATE) AS 근무일차 
-- FROM EMP
-- WHERE ORDER BY HIREDATE;  

SELECT 
    ENAME
    , HIREDATE
    , HIREDATE - TO_DATE('1980-12-17')
FROM EMP
ORDER BY HIREDATE; 

-- 실습 : 최초 입사자와 1년 이상 차이나는 사람을 조회하시오
SELECT 
    ENAME
    , HIREDATE
    , HIREDATE - TO_DATE('1980-12-17')
FROM EMP
WHERE (HIREDATE - TO_DATE('1980-12-17')) >= 365
ORDER BY HIREDATE;  

-- SELECT 
--       ENAME
--     , HIREDATE 
-- FROM EMP
-- WHERE HIREDATE > TO_DATE('1980-12-17')
-- ORDER BY HIREDATE;  


SELECT 
      ENAME
    , HIREDATE 
FROM EMP
WHERE HIREDATE > ADD_MONTHS('1980-12-17', 12)
ORDER BY HIREDATE;  


SELECT 
      TO_NUMBER('20260106')
    , TO_DATE('2026/01/06', 'YYYY/MM/DD')
FROM DUAL; 

-- 정렬 : 
-- 숫자 : 오른쪽
-- 날짜 : 왼쪽
-- 문자 : 왼쪽 


-- NULL 중요함.
-- NVL
-- NVL2

-- 숫자만 가능한가?
    -- 각 컬럼의 데이터 타입에 맞는걸 넣어줘야 한다
    -- NULL이 아니면 그대로 / NULL이면 0
SELECT 
      NVL(COMM,0)  
    , NVL(COMM,0) + 1
    , NVL2(COMM,COMM,10)
FROM EMP; 

-- NULL이 아니면 0 / NULL이면 X
-- DECODE 사용 : IF/CASE 와 같음
SELECT 
      EMPNO
    , ENAME
    , COMM
    , NVL2(COMM,'0','x') AS NVL2
    , DECODE(COMM
        ,0, 'x'
        ,NULL, 'x'
        , '0'
      ) AS DECODE
    , NVL2(COMM,SAL*12+COMM, SAL*12) AS ANNSAL 
FROM EMP; 


-- UPSAL : DECODE
-- UPSAL2 : UPSAL2CASE WHEN THEN
-- UPSAL3 : CASE는 가각 조건을 걸수 있다.
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
    -- , DECODE(JOB
    --     , 'MANAGER', TRUNC(SAL*1.1,0)
    --     , 'SALESMAN', TRUNC(SAL*1.05)
    --     , 'ANALYST', TRUNC(SAL)
    --     , TRUNC(SAL*1.03)
    -- ) AS UPSAL 
FROM EMP
ORDER BY UPSAL; 

-- SELECT 
--       EMPNO
--     , ENAME
--     , JOB
--     , SAL  
--     , CASE COMM
--         WHEN NULL THEN 'x'
--         WHEN 0 THEN 'x'
--         ELSE 0
--     END AS UPSAL3 
-- FROM EMP
-- ORDER BY UPSAL; 


SELECT 
      EMPNO
    , ENAME
    , COMM 
    , CASE
        WHEN COMM IS NULL THEN '해당사항없음' 
        WHEN COMM = 0 THEN '수당없음'
        WHEN COMM > 0 THEN '수당:' || COMM  
    END AS COMM_TEXT 
FROM EMP
ORDER BY COMM_TEXT; 


SELECT 
      EMPNO
    , ENAME
    , COMM 
    , CASE
        WHEN COMM IS NULL THEN '해당사항없음' 
        WHEN COMM = 0 THEN '수당없음'
        WHEN COMM > 0 THEN '수당:' || TO_CHAR(COMM)  
    END AS COMM_TEXT 
    , CASE
        WHEN COMM IS NULL THEN 1 
        WHEN COMM = 0 THEN 2
        WHEN COMM > 0 THEN 3  
    END AS COMM_TEXT2 
FROM EMP
ORDER BY COMM_TEXT; 


--되새김문제 :  179 ~180P
-- SELECT
-- FROM EMP;


-- Q1.
-- 1    LENGTH  EMPNO 5글자 이상이며 6글자 미만인 사원 정보 조회 
-- 2    RPAD    마스킹처리 사원번호 앞 2자리 외 뒷자리 ** 기호로 출력
-- 3    RPAD    사원이름 1글자만 보여주고 나머지 글자 ** 기호로 출력
-- 
SELECT 
      EMPNO
    , RPAD(SUBSTR(EMPNO,1,2),LENGTH(EMPNO),'*') AS MASKING_EMPNO
    , ENAME
    , RPAD(SUBSTR(ENAME,1,1),LENGTH(ENAME),'*') AS MASKING_ENAME 
    , LENGTH(ENAME)
FROM EMP
WHERE LENGTH(ENAME) >= 5 
  AND LENGTH(ENAME) < 6;
-- WHERE LENGTH(ENAME) BETWEEN 5 AND 6;
-- AND 와 OR 구분. 이상 미만 등 부호 구분.

SELECT 
      EMPNO
    , SUBSTR(EMPNO,1,2) || '**' AS MASKING_EMPNO
    , ENAME
    , RPAD(SUBSTR(ENAME,1,1),LENGTH(ENAME),'*') AS MASKING_ENAME  
    , LENGTH(ENAME)
FROM EMP
WHERE LENGTH(ENAME) >= 5 
  AND LENGTH(ENAME) < 6;

 

-- Q2.
-- 1   사원 월 평균 근무일 수 = 21.5
-- 2   1일 근무시간 = 8
-- 3   사원의 1일 급여(DAY_DAY) 시급(TIME_PAY)을 계산하여 결과 출력
-- 4   단, 1일 급여는 소수 3째 자리에서 버리고, 시급은 소수 2째 자리에서 반올림
SELECT
      EMPNO
    , ENAME
    , SAL 
    , TRUNC(SAL/21.5,2) AS "1일급여"
    , ROUND((SAL/21.5)/8,1) AS "1시간급여"
    
FROM EMP
ORDER BY EMPNO;

-- Q3. 
-- 1   사원 입사일(HIREDATE) 기준으로 3개월 지난 후 첫 월요일에 정직원이 된다
--     정직되는날 : 일사일 + 3개월 + 첫번째 월요일
-- 2   정직되는날 : YYYY-MM-DD 형식으로 출력
-- 3   단, 추가수당(COMM) 없는 사원의 추가 수당은 N/A로 출력 
SELECT
      EMPNO
    , ENAME
    , HIREDATE AS "입사일"
    -- , NEXT_DAY(ADD_MONTHS(HIREDATE,3),'월요일') AS "R_JOB정직되는날"
    , TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3),'월요일'), 'YYYY-MM-DD') AS "R_JOB정직되는날"
    -- , COMM
    , CASE
        WHEN COMM IS NULL THEN 'N/A'
        WHEN COMM = '0' THEN 'N/A' 
        WHEN COMM > '0' THEN TO_CHAR(COMM)
    END
FROM EMP;

-- Q4. 
-- 1   모든사원 대상
-- 2   직속상관의 번호 MGR  / 조건별 CHG_MGR열에 출력
-- 3   

SELECT
      EMPNO
    , ENAME
    , MGR 
    , CASE
        WHEN MGR IS NULL THEN TO_CHAR('0000')
        WHEN SUBSTR(MGR,1,2) = 75 THEN TO_CHAR('5555')
        WHEN SUBSTR(MGR,1,2) = 76 THEN TO_CHAR('6666')
        WHEN SUBSTR(MGR,1,2) = 77 THEN TO_CHAR('7777')
        WHEN SUBSTR(MGR,1,2) = 78 THEN TO_CHAR('8888') 
        ELSE TO_CHAR(EMPNO)
      END
     AS CHG_MGR 
    -- , TO_CHAR(SUBSTR(MGR,1,2))
FROM EMP;




-- 7장 수업
-- GROUP BY
-- HAVING

-- 많이 쓰임
-- SUM  합계
-- COUNT  데이터 개수
-- MAX  최대값
-- MIN  최소값
-- AVG  평균값


-- NULL은 COUNT에서 제외된다

SELECT DEPTNO, JOB, SUM(SAL), SUM(COMM)
FROM EMP
GROUP BY JOB, DEPTNO;

SELECT DEPTNO, COUNT(*), COUNT (COMM)
FROM EMP
GROUP BY DEPTNO;


SELECT MAX(HIREDATE)
FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT MAX(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;


-- 07-4 그룹화와 관련된 여러 함수
-- ROLLUP, CUBE: 그룹화 데이터의 합계
-- GROUPING SETS: 지정한 각 열별 그룹화
-- GROUPING: ROLLUP, CUBE와 함께 사용 (하나)
-- GROUPING_ID: ROLLUP, CUBE와 함께 사용 (여럿)



-- SQL 구문 요약
-- SELECT: 조회할 열(컬럼) 이름을 지정합니다.
-- FROM: 조회할 테이블 이름을 지정합니다.
-- WHERE: 조회할 행을 선별하는 조건식을 작성합니다 (개별 행 필터링).
-- GROUP BY: 특정 열을 기준으로 그룹화합니다 (여러 개 지정 가능).
-- HAVING: 출력 그룹을 제한하는 조건식을 작성합니다 (그룹 필터링).
-- ORDER BY: 결과를 정렬할 열을 지정합니다.



-- 평균급여에 소숫점3자리에서 반올림. 2번째까지
SELECT 
        ROUND(AVG(SAL),2)
      , '10' AS DEPTNO  
FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT 
        ROUND(AVG(SAL),2)
      , '20' AS DEPTNO  
FROM EMP
WHERE DEPTNO = 20 
UNION ALL
SELECT 
        ROUND(AVG(SAL),2)
      , '30' AS DEPTNO  
FROM EMP
WHERE DEPTNO = 30;


