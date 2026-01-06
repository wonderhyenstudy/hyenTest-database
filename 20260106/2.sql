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
WHERE DEPTNO = 30
ORDER BY DEPTNO;

-- 숙제 DEPTNO 그룹별 평균 넣어보자
SELECT 
       ROUND(AVG(SAL),2) 
       , DEPTNO
FROM EMP 
GROUP BY DEPTNO
ORDER BY DEPTNO;




-- 앨리어스 AS
-- 한글 안됨
-- 이름이 길면 _ 로 표현 : GOOD_NAME

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (10,20)
GROUP BY DEPTNO
    HAVING SUM(SAL) = 10875;
    -- GROUP 에 해당하는 조건


-- 그룹바이 : 셀렉트에 있는 그룹안된 열 이름은 그룹바이에 꼭 있어야 한다 

-- 되새김 문제 200P
-- Q1
-- 부서번호
-- 평균급여
-- 최고급여
-- 최저급여
-- 사원수
SELECT
      DEPTNO
    , TRUNC(AVG(SAL),0)
    , MAX(SAL)
    , MIN(SAL)
    , COUNT(EMPNO)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- Q2
SELECT
      JOB 
    , COUNT(*)
FROM EMP
GROUP BY JOB
    HAVING COUNT(JOB) >= 3;

-- Q3
SELECT
      TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR
    , DEPTNO
    , COUNT(ENAME) AS CNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO; 
 
 
-- Q4
-- NULL
-- NOT NULL
-- 0
-- 받는 사람 수
-- 받지 않는 수 

SELECT
      NVL2(COMM, 'O','X') AS EXIST_COMM
    , COUNT(*) AS CNT
FROM EMP
GROUP BY NVL2(COMM, 'O','X');

-- 왜 빈공백이 아니라 NULL을 넣는가??


-- 8,9장 뛰어넘음

-- 10장으로 : 














