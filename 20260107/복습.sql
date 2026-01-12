

-- 등가조인 이너조인
-- 비등가조인 아우터조인

-- 등가조인 =
-- 비등가조인은 >>> 등 조건

-- 단일 = 
-- 다행 in all exists


-- 자체(셀프)조인 : 하나의 테이블에서 뽑는다
-- 외부조인 : 아우터
-- 왼쪽아우터 : 왼쪽all + 오른쪽 null
-- 오른쪽 아우터 : 오른쪽all + 왼쪽 null

-- 서브쿼리
-- 오더보이 안됨
-- select : 스컬리, 다행일때
-- from : 하나의 테이블처럼 쓴다
-- whrer : 조건으로 비교 검색할때


-- ALLEN 이란 사람의 직업과 같은 사람
SELECT * 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND JOB = (
            SELECT JOB 
            FROM EMP
            WHERE ENAME = 'ALLEN'
          )
;

-- 평균급여보다 많이 받는 사람
SELECT *
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO(+)
  AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
  AND SAL > (SELECT AVG(SAL)
              FROM EMP)
;            

-- 부서10이고 부서30의 JOB인 사람
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+)
AND E.DEPTNO = 10
AND E.JOB NOT IN (
          SELECT JOB
          FROM EMP
          WHERE DEPTNO = 30 
);

-- SALESMAN 그룹의 최고급여 보다 많이 받는 사람
SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
AND SAL > (SELECT MAX(SAL)
        FROM EMP
        WHERE JOB = 'SALESMAN')
ORDER BY E.DEPTNO    
;