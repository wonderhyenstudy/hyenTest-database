
-- Q1
-- ALLEN과 같은 직책인 사원의 사원정보, 부서정보 출력
-- 1.ALLEN의 직책은? 
SELECT 
      E.JOB
    , E.EMPNO
    , E.ENAME
    , E.SAL
    , D.DEPTNO
    , D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.JOB = (SELECT JOB 
        FROM EMP
        WHERE ENAME = 'ALLEN'
        )
;


-- Q2 
-- SELECT
--     E.EMPNO
--     , E.ENAME
--     , D.DNAME
--     , E.HIREDATE
--     , D.LOC
--     , S.GRADE 
-- FROM EMP E 
--     LEFT OUTER JOIN DEPT D     ON E.DEPTNO = D.DEPTNO
--     LEFT OUTER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
-- WHERE E.EMPNO IN (SELECT 
--                     EMPNO 
--                     FROM EMP 
--                     WHERE SAL > (SELECT AVG(SAL)
--                                 FROM EMP)
--                 )
-- ORDER BY E.SAL DESC, E.EMPNO
-- ;  
SELECT
    E.EMPNO
    , E.ENAME
    , D.DNAME
    , E.HIREDATE
    , D.LOC
    , S.GRADE 
FROM EMP E 
    LEFT OUTER JOIN DEPT D     ON E.DEPTNO = D.DEPTNO
    LEFT OUTER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE E.SAL > (SELECT AVG(SAL)
                    FROM EMP
               )
ORDER BY E.SAL DESC, E.EMPNO
;  


-- Q3  
SELECT
    E.EMPNO
    , E.ENAME 
    , E.JOB
    , E.DEPTNO
    , D.DNAME
    , D.LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 10
AND JOB NOT IN (SELECT JOB
                FROM EMP
                WHERE DEPTNO = 30 
                )
;


-- Q4
-- 다중행 함수 사용 안한 방법
SELECT
    E.EMPNO
    , E.ENAME
    , E.SAL
    , S.GRADE
    , E.JOB
FROM EMP E
    LEFT OUTER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.SAL > (SELECT MAX(SAL)
                FROM EMP
                WHERE JOB = 'SALESMAN'
              )
ORDER BY E.EMPNO
;

-- 다중행 함수 사용 한 방법 : ALL 이해가 좀 안됨
SELECT
    E.EMPNO
    , E.ENAME
    , E.SAL
    , S.GRADE
    , E.JOB
FROM EMP E
    LEFT OUTER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.SAL > ALL (SELECT SAL
                FROM EMP
                WHERE JOB = 'SALESMAN'
              )
ORDER BY E.EMPNO
;










