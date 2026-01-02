
SELECT sysdate from dual;

SELECT * 
  FROM EMP
 WHERE JOB = 'MANAGER'; 


SELECT ENAME
     , SAL 
  FROM EMP;


SELECT ENAME
     , SAL
  FROM EMP
 WHERE SAL > 2000; 

-- 연습용
-- 실습1
-- 1)
-- 급여가 3000 이상인 직원만 조회하시오.
SELECT ENAME
    , SAL
FROM EMP
WHERE SAL >= 3000;
-- 2)
-- EMP 테이블에서 이름(ENAME), 급여(SAL), 부서번호(DEPTNO)만 조회하시오.
SELECT ENAME
     , SAL
     , DEPTNO
  FROM EMP;
-- 3)
-- 20번 부서의 사원 이름과 급여를 조회하시오.
SELECT ENAME
     , SAL
     , DEPTNO
     , COMM
  FROM EMP
 WHERE DEPTNO = 20;



SELECT * FROM EMP;

SELECT JOB
  FROM EMP;

SELECT DISTINCT JOB
  FROM EMP;

 SELECT COUNT(DISTINCT JOB)
  FROM EMP;
 

SELECT DISTINCT JOB
     , DEPTNO
  FROM EMP;   

SELECT JOB 
     , DEPTNO
     , COUNT(*)
  FROM EMP
GROUP BY DEPTNO, JOB;   

SELECT DEPTNO
FROM EMP;   



-- 실습2
-- 1) 직무 목록 중복 없이 출력(직무) 
SELECT DISTINCT JOB
  FROM EMP;

-- 2) 직무 + 부서번호 조합의 고유 데이터 추출 (직무,부서번호)
SELECT DISTINCT JOB
     , EMPNO
  FROM EMP;

-- 3) 중복 포함하여 전체 출력(직무,부서번호)
SELECT JOB
     , EMPNO
  FROM EMP;

-- 4) EMP 테이블에서 중복되지 않는 부서번호만 출력하시오.
SELECT DISTINCT EMPNO 
  FROM EMP;

-- 5) EMP 테이블에서 사원 직무와 부서번호 조합이 고유한 결과만 출력하시오.
SELECT DISTINCT JOB 
     , EMPNO
  FROM EMP;

-- 6) EMP 테이블에서 중복 없이 사원의 급여를 조회하시오.
SELECT SAL
     , ENAME
  FROM EMP;

-- 7) EMP 테이블에서 직무, 부서번호, 급여 조합이 고유한 행만 조회하시오.
SELECT DISTINCT JOB
     , EMPNO
     , SAL
  FROM EMP;