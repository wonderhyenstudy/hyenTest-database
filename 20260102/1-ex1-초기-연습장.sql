
-- 별칭 연습
SELECT ENAME AS "사원이름" 
  FROM EMP;

SELECT ENAME
     , SAL * 12 AS "연봉 상여금 미포함"
  FROM EMP;

SELECT ENAME
     , SAL AS "급여"
  FROM EMP;  


-- AS 없어도 되지만 AS를 써주자
SELECT ENAME "직원"
     , JOB "직무"
  FROM EMP;   


-- 실습1
-- 1) EMP 테이블에서 사원 이름에 "Name"이라는 별칭을 부여하여 출력하시오.
SELECT ENAME AS "Name"
  FROM EMP; 

-- 2) EMP 테이블에서 급여(SAL)를 연봉(Annual Salary)으로 계산하여 출력하시오.
SELECT SAL * 12 AS "연봉"
  FROM EMP;

-- 3) 사원명(ENAME)과 직무(JOB)를 각각 "사원이름", "직무"로 출력하시오.
SELECT ENAME AS "사원이름"
     , JOB AS "직무"
  FROM EMP;



-- 정렬
-- ORDER BY ASC DESC 
SELECT *
  FROM EMP
 ORDER BY SAL DESC;

 SELECT *
  FROM EMP
 ORDER BY DEPTNO ASC
        , SAL DESC;

-- 열 인텍스로 정렬
SELECT ENAME
     , JOB
     , SAL
  FROM EMP
 ORDER BY 3 DESC;       

--  실습2
-- 1)급여 기준 오름차순 정렬
SELECT *
  FROM EMP
 ORDER BY SAL ASC;

-- 2)급여 기준 내림차순 정렬
SELECT *
  FROM EMP
 ORDER BY SAL DESC;

-- 3)부서번호 오름차순 + 급여 내림차순 정렬
SELECT *
  FROM EMP
 ORDER BY DEPTNO ASC
        , SAL DESC;

-- 4)EMP 테이블에서 사원 이름과 급여를 급여 기준으로 오름차순 정렬하시오.
SELECT ENAME
     , SAL
  FROM EMP
 ORDER BY SAL ASC;

-- 5)EMP 테이블에서 모든 사원을 입사일(HIREDATE) 기준으로 최신순으로 정렬하시오.
SELECT ENAME
     , HIREDATE
  FROM EMP
 ORDER BY HIREDATE DESC;

-- 6)EMP 테이블에서 부서번호(오름차순), 이름(내림차순) 기준으로 정렬하시오.
SELECT DEPTNO
     , ENAME
  FROM EMP
 ORDER BY DEPTNO ASC
        , ENAME DESC;

-- 7)커미션이 높은 순으로, 급여가 낮은 순으로 정렬하여 출력하시오.
SELECT COMM
     , SAL
  FROM EMP
 ORDER BY COMM DESC
        , SAL ASC;

-- 8)EMP 테이블에서 이름, 부서번호, 급여를 출력하되, 급여가 높은 순으로 정렬하시오.
SELECT ENAME
     , DEPTNO
     , SAL
  FROM EMP
 ORDER BY SAL DESC;

-- 9)SALGRADE 테이블에서 급여 등급(GRADE)을 오름차순, 최고급여(HISAL)는 내림차순으로 정렬하시오. 
SELECT *
  FROM SALGRADE
 ORDER BY GRADE ASC
        , HISAL DESC;

 SELECT * FROM SALGRADE;
 SELECT * FROM EMP;

-- WHERE 절
 


--  실습4
-- 1) 급여(SAL)가 2000 이상인 사원만 조회하시오.
SELECT *
  FROM EMP
 WHERE SAL >= 2000;

-- 2) 입사일(HIREDATE)이 '1981-02-20' 이후인 사원만 조회하시오. 
-- 힌트)TO_DATE('1981-02-20', 'YYYY-MM-DD') 이용하기.
SELECT *
  FROM EMP
 WHERE HIREDATE > '1981-02-20'
 ORDER BY HIREDATE ASC;

SELECT *
  FROM EMP
 WHERE HIREDATE > TO_DATE('1981-02-20', 'YYYY-MM-DD')
 ORDER BY HIREDATE ASC;

-- 3)부서번호가 10이 아닌 사원만 출력하시오.
SELECT *
  FROM EMP
 WHERE DEPTNO != 10;

 SELECT *
  FROM EMP
 WHERE DEPTNO <> 10;

-- 조건식 ADN OR
SELECT *
  FROM EMP 
 WHERE DEPTNO  = '30' 
   AND JOB ='SALESMAN' ; 

SELECT *
  FROM EMP 
 WHERE JOB = 'CLERK' 
    OR JOB ='MANAGER'; 

SELECT * 
  FROM EMP
 WHERE (DEPTNO = 10 OR DEPTNO = 20)
   AND SAL > 2000;



-- ## 7. 실무 활용 사례 
-- - AND: "이벤트 참여자 중 나이가 20세 이상이면서,
-- 구매 금액이 10만 원 이상인 사람"
-- - OR: "고객 등급이 VIP거나 GOLD인 경우 할인 적용"
-- - 괄호 사용: "서울 또는 부산 거주자 중, 1년 이상 된 회원"

-- 실습5
-- 1)부서번호가 30이면서 급여가 1600 이상인 사원을 조회하시오.
SELECT *
  FROM EMP
 WHERE DEPTNO = 30 
       AND SAL >= 1600;

-- 2)직무가 'MANAGER' 또는 'ANALYST'인 사원을 출력하시오.
SELECT *
  FROM EMP
 WHERE JOB = 'MANAGER' 
       OR JOB = 'ANALYST';

-- 3)부서번호가 10 또는 20이고, 직무가 'CLERK'인 사원만 조회하시오.
SELECT *
  FROM EMP
 WHERE (DEPTNO = 10  OR DEPTNO = 20) 
        AND JOB = 'CLERK';

-- 4)급여가 1500 이상이고 커미션이 NULL이 아닌 사원만 조회하시오.
-- 힌트) 커미션이 NULL이 아닌 : COMM IS NOT NULL 
SELECT *
  FROM EMP
 WHERE SAL >= 1500 
       AND COMM IS NOT NULL -- 값이 없다.
       AND COMM != 0;       -- 값이 0 이다.


-- 5) 직무가 ‘SALESMAN’이거나, 급여가 3000 이상인 사원을 출력하시오.
SELECT *
  FROM EMP
 WHERE JOB = 'SALESMAN' 
       OR SAL >= 3000;

-- 6) 부서번호가 10, 20, 30 중 하나이고, 급여가 2000 이상인 사원을 출력하시오.
-- 힌트) 10, 20, 30 중 하나 : IN (10, 20, 30)
SELECT *
  FROM EMP
 WHERE DEPTNO IN(10, 20, 30) AND SAL >= 2000; 



-- 연산자 : 산술, 비교, 논리, 패턴, 집합
-- ## 1. 학습 목표
-- - 다양한 **연산자(산술, 비교, 논리, 패턴, 집합)**의 개념과 구문을 이해한다.
-- - 연산자 조합 및 우선순위를 고려하여 **복합 조건 쿼리 작성**이 가능해진다.
-- - 실무 상황에서 자주 사용되는 **조건 필터링, 패턴 검색, NULL 비교** 등의 쿼리 작성 능력을 키운다.

-- ## 2. 연산자 분류 및 설명

-- | 종류 | 설명 | 예시 |
-- |------|------|------|
-- | **산술 연산자** | 숫자 간 계산 | `SAL * 12` |
-- | **비교 연산자** | `=, !=, <>, >, <, >=, <=` 등 | `SAL >= 3000` |
-- | **등가 비교 연산자** | `!=`, `<>`, `^=` (서로 다름) | `JOB != 'CLERK'` |
-- | **논리 부정 연산자** | `NOT` | `NOT SAL BETWEEN 1000 AND 3000` |
-- |
-- **IN 연산자** | 여러 값 중 하나 포함 여부 | `DEPTNO IN (10, 20, 30)` |
-- |
-- **BETWEEN A AND B** | 범위 포함 여부 | `SAL BETWEEN 1000 AND 3000` |
-- |
-- **LIKE 연산자** | 패턴 검색 (와일드카드: `%`, `_`) | `ENAME LIKE 'A%'` |
-- |
-- **IS NULL / IS NOT NULL** | NULL 여부 비교 | `COMM IS NULL` |

-- | **집합 연산자** | `UNION`, `UNION ALL`, `MINUS`, `INTERSECT` | 여러 쿼리 결과 결합 |


-- ## 3. 연산자 우선순위

-- | 순서 | 연산자 종류 |
-- |------|--------------|
-- | 1 | 산술 연산자 (`*, /, +, -`) |
-- | 2 | 비교 연산자 (`=, !=, <, >, <=, >=, LIKE, BETWEEN, IN, IS NULL`) |
-- | 3 | 논리 연산자 (`NOT`, `AND`, `OR`) |
-- | → | 괄호 `()` 사용으로 우선순위 변경 가능 |


-- ## 4. 실습 예제 모음

-- ### ✅ 산술 연산자 
SELECT ENAME, SAL * 12 AS "연봉" FROM EMP; 

-- ### ✅ 비교 연산자 
SELECT * FROM EMP WHERE SAL >= 2000; 

-- ### ✅ 문자 비교 (1글자 vs 여러 글자) 
-- 한 글자
SELECT * FROM EMP WHERE ENAME > 'L';

-- 여러 글자
SELECT * FROM EMP WHERE ENAME < 'MILLER'; 

-- ### ✅ 등가 비교 연산자 
SELECT * FROM EMP WHERE JOB != 'CLERK';
SELECT * FROM EMP WHERE JOB <> 'CLERK';
SELECT * FROM EMP WHERE JOB ^= 'CLERK'; -- 일부 DBMS에서 지원

-- ### ✅ NOT 연산자 
SELECT * FROM EMP WHERE NOT JOB = 'MANAGER'; 

-- ### ✅ OR 연산자 
SELECT * FROM EMP WHERE JOB = 'CLERK' OR SAL < 1000; 

-- ### ✅ IN 연산자 
SELECT * FROM EMP WHERE DEPTNO IN (10, 20, 30);

SELECT * FROM EMP WHERE DEPTNO = 10
OR
DEPTNO = 20
OR
DEPTNO = 30;

-- ### ✅ NOT IN 연산자 
SELECT * FROM EMP WHERE DEPTNO NOT IN (10, 30); 


-- ### ✅ BETWEEN A AND B 
SELECT * FROM EMP WHERE SAL BETWEEN 1000 AND 3000; 

-- ## ✅ NOT BETWEEN A AND B 
SELECT * FROM EMP WHERE SAL NOT BETWEEN 1000 AND 3000; 

-- 중요함.!!
-- ### ✅ LIKE 연산자 
SELECT * FROM EMP WHERE ENAME LIKE 'S%'; -- S로 시작
SELECT * FROM EMP WHERE ENAME LIKE '_L%'; -- 두 번째 글자가 L
SELECT * FROM EMP WHERE ENAME LIKE '%AM%'; -- AM 포함
SELECT * FROM EMP WHERE ENAME NOT LIKE '%AM%'; -- AM 포함하지 않음


-- ### ✅ IS NULL / IS NOT NULL 
SELECT * FROM EMP WHERE COMM IS NULL;
SELECT * FROM EMP WHERE COMM IS NOT NULL;



-- ### ✅ 집합 연산자 
-- 1. UNION (중복 제거)
SELECT ENAME FROM EMP WHERE JOB = 'MANAGER'
UNION
SELECT ENAME FROM EMP WHERE DEPTNO = 10;

-- 2. UNION ALL (중복 포함)
SELECT ENAME FROM EMP WHERE JOB = 'MANAGER'
UNION ALL
SELECT ENAME FROM EMP WHERE DEPTNO = 10;

-- 3. MINUS (차집합)
SELECT ENAME FROM EMP WHERE DEPTNO = 10
MINUS
SELECT ENAME FROM EMP WHERE JOB = 'MANAGER';

-- 4. INTERSECT (교집합)
SELECT ENAME FROM EMP WHERE JOB = 'CLERK'
INTERSECT
SELECT ENAME FROM EMP WHERE DEPTNO = 20; 

-- 실습6
-- 1)**'CLERK'인 사원 중 급여가 1000에서 1500 사이인 사원을 조회하시오.**
SELECT *
  FROM EMP
 WHERE JOB = 'CLERK'
       AND SAL BETWEEN 1000 AND 1500; 
 

-- 2)**이름에 ‘AM’을 포함하는 사원 이름과 직무를 출력하시오.** 
SELECT ENAME
    , JOB 
FROM EMP 
WHERE ENAME LIKE '%AM%';

-- 3)**부서번호가 10번인 사원 중, 직무가 'MANAGER'가 아닌 사원을 출력하시오.
-- 단, MGR이 NULL인 사람도 포함하시오.**
-- 힌트)mgr IS NULL
SELECT *
  FROM EMP 
 WHERE DEPTNO = 10
       AND JOB != 'MANAGER'; 

SELECT *
  FROM EMP 
 WHERE DEPTNO = 10
   AND (JOB != 'MANAGER' OR MGR IS NULL); 

SELECT *
  FROM EMP 
 WHERE DEPTNO = 10
AND (JOB != 'MANAGER' AND MGR IS NOT NULL); 



-- 6
-- 오라클 함수

-- ## 1. 학습 목표
-- - 오라클에서 제공하는 다양한 내장 함수의 의미와 용도를 이해한다.
-- - 함수의 입력값과 반환값을 파악하고, 실제 SELECT 문에서 활용하는 방법을 익힌다.
-- - 문자열, 숫자, 날짜, NULL 처리 함수 등 자주 사용하는 함수들을 구분할 수 있다.


-- ## 2. 학습 내용
-- - 오라클 내장 함수의 구조와 호출 방법
-- - 문자열, 숫자, 날짜, NULL 처리 함수의 기능 파악
-- - 단일 행 함수(SCALAR FUNCTION) 중심으로 이해
-- - SELECT 문 내에서 함수 조합 사용

-- ## 3. 함수란? 자주 사용하는 기능을 모아놓음.(즐겨찾기)
-- 자바스크립트 언어 배울때,
-- 1) 함수 선언
-- 2) 함수 사용.

-- - **입력값을 받아 계산하거나 가공한 후 결과값을 반환하는 SQL 구성요소**
-- - 오라클에서 제공하는 대부분의 함수는
-- **SELECT 절 또는 WHERE 절** 안에서 사용 가능

-- 📌 **기본 형식**
-- ```sql
-- 함수이름(인자1, 인자2, ...)
-- ```

-- 예: `ROUND(123.456, 2)` → 123.46

-- ## 4. 오라클 함수의 종류

-- | 분류 | 설명 |
-- |-----------------|------|
-- | 문자열 함수 | 문자열을 조작하거나 길이를 계산 |
-- | 숫자 함수 | 숫자 계산, 반올림 등 수학적 처리 |
-- | 날짜 함수 | 날짜 간 계산, 현재 날짜 등 |
-- | 변환 함수 | 자료형 간 변환 |
-- | NULL 처리 함수 | NULL 값을 다른 값으로 대체 |
-- | 조건 함수 | 조건에 따라 값 반환 (DECODE, CASE 등) |
-- | 집계 함수 (다음 단원) | 다수 행을 하나의 결과로 집계
-- (`SUM`, `AVG`, `COUNT` 등) |

-- ## 5. 내장 함수의 특징

-- - 대부분 **입력값을 받아 결과를 반환**하는 **단일 행 함수**
-- - SELECT, WHERE, ORDER BY 절 등 거의 모든 SQL 문장에서 사용 가능
-- - 다른 함수와 **중첩 사용(Nesting)** 가능
-- - 일부 함수는 **NULL 처리** 또는 **형 변환** 기능 제공


-- ## 6. 자주 쓰는 오라클 내장 함수 소개 (예시만 미리 보기)

-- | 함수 종류 | 함수명 | 예시 | 설명 |
-- |-----------|--------|------|------|
-- | 문자열 | `LENGTH`, `SUBSTR`, `INSTR`, `REPLACE`, `TRIM` | `LENGTH('ABC')` → 3 | 문자열 길이, 자르기 등 |
-- | 숫자 | `ROUND`, `TRUNC`, `MOD` | `ROUND(123.456, 2)` → 123.46 | 반올림, 나머지 등 |
-- | 날짜 | `SYSDATE`, `ADD_MONTHS`, `MONTHS_BETWEEN` | `SYSDATE - HIRE_DATE` | 날짜 계산 |
-- | 변환 | `TO_CHAR`, `TO_DATE`, `TO_NUMBER` | `TO_DATE('2024-01-01')` | 자료형 변환 |
-- | NULL | `NVL`, `NVL2`, `COALESCE` | `NVL(COMM, 0)` | NULL 값 대체 |
-- | 조건 | `DECODE`, `CASE` | `CASE WHEN ... THEN ...` | IF-ELSE와 유사 |


-- ## 7. 실무 활용 예시

-- - **이름 길이 계산**: `SELECT ENAME, LENGTH(ENAME) FROM EMP;`
-- - **급여의 연봉으로 계산**: `
SELECT SAL, SAL * 12 AS ANNUAL FROM EMP;
-- - **날짜 비교**: 
SELECT SYSDATE - HIREDATE FROM EMP;
-- - **NULL 처리**: 
SELECT ENAME, NVL(COMM, 0) FROM EMP;
-- - **조건 분기**: 
SELECT ENAME, CASE WHEN JOB = 'MANAGER' THEN 'Y' ELSE 'N' END AS IS_MANAGER FROM EMP;

-- 오라클과 자바스크립트
-- SUBSTR('HELLOW',-3)
-- SUBSTR('HELLOW',2,3)
-- console.log(str.slice(1, 1 + 3));
-- console.log(str.slice(-3));

-- UPPER / LOWER / INITCAP
SELECT ENAME
     , UPPER(ENAME) AS "대문자로"
     , LOWER(ENAME) AS "소문자로" 
     , INITCAP(ENAME) AS "첫글자만 대문자로" 
FROM EMP;

-- LENGTH / LENGTHB
SELECT ENAME
     , LENGTH(ENAME) AS "이름의길이" 
     , LENGTHB(ENAME) AS "이름의길이BYTE" 
FROM EMP;


SELECT JOB
     , INSTR(JOB, 'A') AS "A포함"
     , SUBSTR(JOB, -3) AS "뒤에서3자리"
     , SUBSTR(JOB, 1, 2) AS "1번째 자리부터 2개"
FROM EMP;


-- 실습7
-- 1)이름이 'SCOTT'인 사원을 대소문자 구분 없이 찾으시오.
SELECT ENAME
FROM EMP
WHERE ENAME = 'SCOTT';

SELECT ENAME
FROM EMP
WHERE UPPER(ENAME) = UPPER('scott'); 
--사용자가 소문자를 사용할수도 있다. 더 안정적

SELECT ENAME
FROM EMP
WHERE UPPER(ENAME) = 'SCOTT';


-- 2)이름의 길이가 5 이상인 사원만 출력하시오.
SELECT ENAME
     , LENGTH(ENAME) AS "이름길이"
FROM EMP
WHERE LENGTH(ENAME) >= 5;

-- 3)직무에서 'S' 문자가 포함된 행만 출력하시오. 
-- 힌트) INSTR(JOB, 'S')
SELECT JOB
FROM EMP
WHERE JOB LIKE '%S%'; 

SELECT JOB 
FROM EMP
WHERE INSTR(JOB, 'S') > 0; 

SELECT JOB
     , INSTR(JOB, 'S') AS "S포함"
FROM EMP
WHERE INSTR(JOB, 'S') > 0;  






































