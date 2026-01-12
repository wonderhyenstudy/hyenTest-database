
-- 1. 아래의 값에 맞게 emp테이블에 데이터를 추가하라.
--  - 사원번호:1011, 이름:이순신, 부서번호:104, 직책:부장, 급여:500, 직속상사:NULL


INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO) 
VALUES (1011, '이순신', '104', '부장', 500, null);

SELECT *
FROM EMP;