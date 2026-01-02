-- 실습2
-- 1) 직무 목록 중복 없이 출력(직무) 
SELECT DISTINCT JOB
  FROM EMP;

-- 2) 직무 + 부서번호 조합의 고유 데이터 추출 (직무,부서번호)
SELECT DISTINCT JOB
     , DEPTNO
  FROM EMP;

-- 3) 중복 포함하여 전체 출력(직무,부서번호)
SELECT JOB
     , EMPNO
  FROM EMP;

-- 4) EMP 테이블에서 중복되지 않는 부서번호만 출력하시오.
SELECT DISTINCT DEPTNO 
  FROM EMP;

-- 5) EMP 테이블에서 사원 직무와 부서번호 조합이 고유한 결과만 출력하시오.
SELECT DISTINCT JOB 
     , DEPTNO
  FROM EMP;

-- 6) EMP 테이블에서 중복 없이 사원의 급여를 조회하시오.
SELECT DISTINCT SAL 
  FROM EMP;

-- 7) EMP 테이블에서 직무, 부서번호, 급여 조합이 고유한 행만 조회하시오.
SELECT DISTINCT JOB
     , DEPTNO
     , SAL
  FROM EMP;
 