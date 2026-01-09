
-- 13장 객체종류
SELECT * 
FROM DICT 
ORDER BY TABLE_NAME DESC;


SELECT * 
FROM USER_INDEXES;


-- ***** 중요
-- ▶ USER_VIEWS
-- ▶ 뷰 삭제
-- ▶ DROP
-- ▶ 인라인 뷰를 사용한 TOP-N SQL문

-- ROWNUM : 페이징이 필요한 곳에서는 필수

SELECT
      ROWNUM
    , e.*
from emp e
where rownum BETWEEN 1 and 5;
 
SELECT
      ROWNUM
    , e.*
from emp e
where rownum BETWEEN 1 and 5
ORDER BY SAL
;

SELECT
      ROWNUM
    , e.*
from emp e
-- where rownum BETWEEN 1 and 5
ORDER BY SAL
;

SELECT *
FROM (
        SELECT
        ROWNUM
        , e.*
        from emp e
    )
ORDER BY SAL;

SELECT 
      ROWNUM
    , T1.*
FROM (
        SELECT e.*
        from emp e
    ) T1
ORDER BY SAL;


SELECT 
      ROWNUM
    , T1.*
FROM (
        SELECT e.*
        from emp e
        ORDER BY SAL
    ) T1
WHERE ROWNUM < 5
;

SELECT 
      ROWNUM
    , T1.*
FROM (
        SELECT 
            e.*
        from emp e
        ORDER BY SAL
    ) T1
WHERE ROWNUM = 1
;

SELECT 
      ROWNUM
    , T1.*
FROM (
        SELECT 
            e.*
        from emp e
        ORDER BY SAL
    ) T1
WHERE ROWNUM BETWEEN 3 AND 5
;
-- 제대로 방법
-- RNUM 으로 써야 한다. 이미 서브쿼리 안에서 NUMBER(예약어)이 NUM(정수)으로 만들어 줬다.
SELECT *
FROM (
    SELECT 
          ROWNUM AS RNUM
        , T1.*
    FROM (
            SELECT e.*
            FROM emp e
            ORDER BY SAL
        ) T1
    -- WHERE ROWNUM <= 5  -- 5번까지만 미리 자르면 성능상 유리합니다.
)
-- WHERE RNUM >= 3 -- 3~5행만 출력
WHERE RNUM BETWEEN 3 AND 5 -- 3번 부터 5번까지만 출력
; 


-- FETCH문
-- 오라클 12.1 이상부터 됨
-- 오라클 자체 방법 : 행을 가져온다. 페이징 하는 방법.
SELECT
       e.*
from emp e
ORDER by sal
FETCH NEXT 5 ROWS only; 

-- FETCH 뜻 : 가져온다
-- 5개 건너뛰고 가져온다
-- OFFSET : 여기서부터 가져옴
-- NEXT : 몇개 가져옴
SELECT
       e.*
from emp e
ORDER by sal
OFFSET (1*5) ROWS FETCH NEXT 5 ROWS only; 

-- 페이지 뽑는 방법 선생님이 시연해줌
SELECT
       T.*, ROWNUM AS RN
FROM (
       SELECT
              *
       FROM USED_GOODS_REPLY
       ORDER BY reply_id
) T
WHERE A.RN BETWEEN ((2*5)+1) AND ((2*5)+5)
-- OFFSET (2*5) rows fetch next 5 rows only;








-- 시퀀스 : 번호표 같은 거다. 한번뽑으면 끝난다. 번호생성기


-- 옛날사람방법 : 시퀀스 안 넣고 INSERT로 넣는 방법 : 사용 안하는게 좋음 
-- empno PK 라서 유니크 해야함. 동시에 하면 에러남.
-- 속도 걸림
insert into emp (empno, hiredate) values ((select max(empno) +1 from emp), sysdate);
select * from emp;


CREATE SEQUENCE SEQ_DEPT_SQUENCE
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
CACHE 2;

SELECT * FROM USER_SEQUENCES;

-- 13-30 : 해봐야함 13-28부터 37번까지~~~
INSERT INTO DEPT_SQUENCE (DEPTNO, ENAME, LOC)
VALUES (SEQ_DEPT_SQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');
SELECT * FROM DEPT_SQUENCE ORDER BY DEPTNO;






















-- 동의어 : 시노님 : 
-- 왜 사용하나??

















