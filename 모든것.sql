
-- 20260105

SELECT ADD_MONTHS(SYSDATE,1)
FROM EMP;

SELECT ENAME, HIREDATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE),0)
FROM EMP;

SELECT 
      NEXT_DAY(SYSDATE,'월요일')
    , LAST_DAY(SYSDATE) 
FROM EMP; 

SELECT 
      TO_DATE('2026-01-06', 'YYYY-MM-DD')
    , TO_DATE('2026/01/06', 'YYYY/MM/DD')
FROM DUAL; 
 
-- NVL :  널이 아니면 그대로/ 널이면 0
-- NVL2 : 널이 아니면 0       널이면 X
SELECT 
      COMM
    , NVL(COMM,0)  
    , NVL2(COMM,'0','x') 
FROM EMP; 

SELECT 
      INSTR('HELLO, ORACLE!','L',2,3)
    , RPAD(SUBSTR('010-1234-1234',1,9 ), 13, '*')
FROM DUAL; 


-- SUBSTR(내용, 시작위치, 몇개를) : 잘라 올것인가. 문자를 잘라올때
-- INSTR(내용, 찾는문자, 시작위치, 찾는문자몇번째(옵션)) : 찾는문자의 위치(몇번째)를 가져올때. 자로 가져옴
-- LEHGTH(내용) : 글자 길이를 가져올때. 숫자로 가져옴
-- REPLACE(내용, 변경전내용, 변경후내용) : 내용을 변경할때
-- RPAD(내용,총몇글자,공간에채울문자) : 위치에 특정문자 채우기(비밀번호,아이디). 글자갯수만큼 특정문자로 채움.
-- CONCAT(내용, 내용) : 내용을 연결. 오라클에서는 -> 내용 || 내용


-- 20260106


SELECT ADD_MONTHS(SYSDATE,1)
FROM EMP;

SELECT ENAME, HIREDATE, MONTHS_BETWEEN(HIREDATE, SYSDATE)
FROM EMP;

SELECT 
      NEXT_DAY(SYSDATE,'월요일')
    , LAST_DAY(SYSDATE) 
FROM EMP; 

SELECT 
      SAL
    , TO_CHAR(SAL, '$999,999') AS 달러
    , TO_CHAR(SAL, 'L999,999') AS "원(로컬)"
    , TO_CHAR(12345875, 'L999,999,999') AS "원(로컬)"
    -- 최대금액이 얼마인지 알아야 한다
    , LENGTH(SAL)
FROM EMP
ORDER BY LENGTH(SAL) DESC; 

SELECT 
      TO_NUMBER('20260106')
    , TO_DATE('2026/01/06', 'YYYY/MM/DD')
FROM DUAL; 

-- 정렬 : 
-- 숫자 : 오른쪽
-- 날짜 : 왼쪽
-- 문자 : 왼쪽 

-- 숫자만 가능한가?
    -- 각 컬럼의 데이터 타입에 맞는걸 넣어줘야 한다
    -- NULL이 아니면 그대로 / NULL이면 0
    -- NULL이 아니면 0     / NULL이면 X
SELECT 
      NVL (COMM, 0)  
    , NVL2(COMM,'0','x') 
FROM EMP; 

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



-- GROUP BY: 특정 열을 기준으로 그룹화합니다 (여러 개 지정 가능).
-- HAVING: 출력 그룹을 제한하는 조건식을 작성합니다 (그룹 필터링).
-- ORDER BY: 결과를 정렬할 열을 지정합니다.


-- 많이 쓰임
-- SUM  합계
-- COUNT  데이터 개수
-- MAX  최대값
-- MIN  최소값
-- AVG  평균값




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

SELECT * 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND JOB = (
            SELECT JOB 
            FROM EMP
            WHERE ENAME = 'ALLEN'
          )
;

SELECT *
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO(+)
  AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
  AND SAL > (SELECT AVG(SAL)
              FROM EMP)
;            

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+)
AND E.DEPTNO = 10
AND E.JOB NOT IN (
          SELECT JOB
          FROM EMP
          WHERE DEPTNO = 30 
);


SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
AND SAL > (SELECT MAX(SAL)
        FROM EMP
        WHERE JOB = 'SALESMAN')
ORDER BY E.DEPTNO    
;
















