
-- 9장 서브쿼리
-- 단일행 서브쿼리
-- 다중행 서브쿼리 IN / ANY,SOME / ALL / EXISTS(서브쿼리 결과가 1개 이상 있을 경우 TRUE)

-- 서브쿼리 ORDER BY 안됨
-- 비교대상은 같은 자료형

-- 9-3    
SELECT *
FROM EMP
WHERE SAL > (SELECT SAL
               FROM EMP
              WHERE ENAME = 'JONES'
            );

-- 9-4
SELECT *
FROM EMP
WHERE HIREDATE < (SELECT HIREDATE
               FROM EMP
              WHERE ENAME = 'SCOTT'
            );

-- 9-5 위 복습문제 235P
SELECT E.*, D.*
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO 
AND E.SAL <= (SELECT AVG(SAL) 
                FROM EMP)
AND E.DEPTNO = 20;

           

-- 9-18
SELECT *
FROM EMP 
WHERE (DEPTNO, SAL) IN ( SELECT DEPTNO, MAX(SAL)
                           FROM EMP
                         GROUP BY DEPTNO  
                        )
ORDER BY DEPTNO;


-- FROM 절에 사용하는 서브쿼리  : 확인해봐야함
SELECT *
FROM DEPT_TEMP D,
                (SELECT 
                      D.DEPTNO
                    , D.DNAME 
                    , E.EMPNO 
                    , E.ENAME
                    , E.MGR
                    , E.SAL 
                    -- , E.DEPTNO 
                    , S.LOSAL
                    , S.HISAL
                    , S.GRADE
                    , E.MGR AS MGR_EMPNO
                    , E2.ENAME AS MGR_ENAME 
                 FROM DEPT D, EMP E, SALGRADE S, EMP E2
                WHERE D.DEPTNO = E.DEPTNO(+)
                    AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
                    AND E.MGR = E2.EMPNO(+)
                ) A 
WHERE D.DEPTNO = A.DEPTNO
AND D.DEPTNO = 10;


-- 제미나이 정리해준것
SELECT *
FROM DEPT_TEMP D,
     (SELECT 
          D.DEPTNO, 
          D.DNAME, 
          E.EMPNO, 
          E.ENAME, 
          E.MGR, 
          E.SAL, 
          S.LOSAL, 
          S.HISAL, 
          S.GRADE, 
          E2.ENAME AS MGR_ENAME 
      FROM DEPT D, EMP E, SALGRADE S, EMP E2
      WHERE D.DEPTNO = E.DEPTNO(+)        -- 부서에 사원이 없어도 부서 정보 출력
        AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+) -- 급여 등급이 없어도 사원 정보 출력
        AND E.MGR = E2.EMPNO(+)           -- 관리자가 없어도 사원 정보 출력
     ) A
WHERE D.DEPTNO = A.DEPTNO
  AND D.DEPTNO = 10;



-- 제미나이 정리해준것
SELECT *
FROM DEPT_TEMP D
INNER JOIN (
    SELECT 
        D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL, 
        S.GRADE, E.MGR AS MGR_EMPNO, E2.ENAME AS MGR_ENAME 
    FROM DEPT D
    LEFT OUTER JOIN EMP E ON D.DEPTNO = E.DEPTNO
    LEFT OUTER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
    LEFT OUTER JOIN EMP E2 ON E.MGR = E2.EMPNO
) A ON D.DEPTNO = A.DEPTNO
WHERE D.DEPTNO = 10;



-- 9-20
WITH
E10 AS(SELECT * FROM EMP WHERE DEPTNO =10 ),
D   AS(SELECT * FROM DEPT)
SELECT 
      E10.EMPNO
    , E10.ENAME
    , E10.DEPTNO
    , D.DNAME
    , D.LOC
FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;


-- SELECT에 쓰는 서브쿼리 : 스칼라
SELECT
    e.ename
    , e.mgr
    , e2.empno
    , d.DEPTNO
    -- , (SELECT DEPTNO FROM DEPT WHERE DEPTNO = 10) AS LV
    , (SELECT DEPTNO FROM DEPT WHERE DEPTNO = D.DEPTNO) AS LV
from dept d
    , emp e
    , emp e2
    , SALGRADE s
where d.DEPTNO = e.deptno(+)
    and e.mgr = e2.empno(+)
    and e.sal between s.losal(+) and s.hisal(+);

-- 서브쿼리
-- 익스플레인 오른쪽 상단 [설명계획] EXPLAIN PLAN


-- 9-21
-- SALGRADE : 임금이 최저-최고 사이의 등급을 가져온다
-- DNAME    : 일치하는 이름 가져온다(부서T=정보T)
SELECT
      EMPNO
    , ENAME
    , JOB
    , SAL
    , (SELECT GRADE
        FROM SALGRADE
        WHERE E.SAL BETWEEN LOSAL AND HISAL
        ) AS SALGRADE
    , DEPTNO
    , (SELECT DNAME
        FROM DEPT
        WHERE E.DEPTNO = DEPT.DEPTNO
        ) AS DNAME
FROM EMP E;

-- SELECT / WHERE 둘다 속도가 안 좋다
-- FROM 에 제일 많이 쓴다

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
--       EMPTNO
--     , ENAME
--     , DNAME
--     , HIREADATE
--     , LOC
--     , SAL
--     , GRADE    
-- FROM 
-- 1. 전체 평균 급여보다 많이 받는 사원 찾기 

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
WHERE E.EMPNO IN (SELECT 
                    EMPNO 
                    FROM EMP 
                    WHERE SAL > (SELECT AVG(SAL)
                                FROM EMP)
                )
ORDER BY E.SAL DESC, E.EMPNO DESC
;  


-- Q3
-- 10번 부서에 근무하는 사원

-- SELECT
--     E.EMPNO
--     , E.ENAME 
--     , E.JOB
--     , E.DEPTNO
--     , D.DNAME
--     , D.LOC 
-- FROM EMP E, DEPT D 
-- WHERE E.EMPNO IN (SELECT 
--                     EMPNO 
--                 FROM EMP
--                 WHERE DEPTNO = 10)
-- AND E.DEPTNO = D.DEPTNO  
-- ;           

SELECT
    E.EMPNO
    , E.ENAME 
    , E.JOB
    , E.DEPTNO
    , D.DNAME
    , D.LOC 
FROM EMP E
    LEFT OUTER JOIN DEPT D ON E.EMPNO IN (SELECT 
                                            EMPNO 
                                        FROM EMP
                                        WHERE DEPTNO = 10)
AND E.DEPTNO = D.DEPTNO  
;       

-- Q3 정답 : 다들 대단함
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
AND JOB NOT IN (
    SELECT JOB
    FROM EMP
    WHERE DEPTNO = 30 
)
;



SELECT EMPNO, JOB
FROM EMP
WHERE DEPTNO = 10;

-- 30번 부서에 있는 직책
SELECT EMPNO, JOB
FROM EMP
WHERE DEPTNO = 30; 

-- 30번 부서에 없는 직책은 어떻게 뽑지???

-- 직책 : 10번 부서 DEPTNO 근무사원 직책 JOB - 30번 부서 DEPTNO 근무사원 직책 JOB

-- SELECT
--     E.EMPNO
--     -- , E.ENAME
--     -- , E.JOB
--     -- , D.DEPTNO
--     -- , D.DNAME
--     -- , D.LOC
-- FROM EMP E
--    LEFT OUTER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
--    LEFT OUTER JOIN EMP E2 ON E.EMPNO IN (SELECT EMPNO, JOB
--                                 FROM EMP
--                                 WHERE DEPTNO = 10)       
-- ;
-- SELECT *
-- FROM EMP 
-- WHERE EMPNO IN (SELECT EMPNO, JOB
--                                 FROM EMP
--                                 WHERE DEPTNO = 10)

-- SELECT
--     E.EMPNO
--     , E.ENAME
--     , E.JOB
--     , D.DEPTNO
--     , D.DNAME
--     , D.LOC
-- FROM EMP E
--    LEFT OUTER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
-- WHERE DEPTNO IN (SELECT DEPTNO
--                     FROM EMP
--                     WHERE DEPTNO = 10
--                 )                    
-- ;
-- Q4
-- SELECT
--     EMPNO
--     , ENMAE
--     , SAL
--     , GRADE
-- FROM 

-- 직책 SALESMAN인 사람의 최고급여 HISAL 보다 많이 받는 사원
-- 1. 직책 SALESMAN
-- 2.   


SELECT
    E.EMPNO
    , E.ENAME
    , E.SAL
    , S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL  
;


SELECT 
      S.HISAL
    , E.JOB
FROM EMP E
    JOIN E.SAL BETWEEN S.LOSAL AND S.HISAL; 
    -- JOIN SALGRADE S ON JOB = 'SALESMAN'
  
SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL; 





 
SELECT SAL
FROM EMP
WHERE JOB = 'SALESMAN' ;

-- 목 : 테이블 만들기
-- 금 : 시험과정소개 / 몽고디비 / 알디비

-- 그룹별 최고급액
SELECT *
FROM EMP 
WHERE (DEPTNO, SAL) IN ( SELECT DEPTNO, MAX(SAL)
                           FROM EMP
                         GROUP BY DEPTNO  
                        )
ORDER BY DEPTNO;

        