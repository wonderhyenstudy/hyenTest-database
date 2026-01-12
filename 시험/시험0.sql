

CREATE TABLE dept( 
    DEPTNO      VARCHAR2(6) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    DNAME       VARCHAR2(10) UNIQUE,
    AREA        VARCHAR2(10) 
);  


INSERT INTO dept (deptno, dname)
VALUES ('101', '영업부');
INSERT INTO dept (deptno, dname)
VALUES ('102', '총무부');
INSERT INTO dept (deptno, dname)
VALUES ('103', '기획부');
INSERT INTO dept (deptno, dname)
VALUES ('104', '홍보부');



CREATE TABLE dept( 
    DEPTNO      VARCHAR2(6) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    DNAME       VARCHAR2(10) UNIQUE,
    AREA        VARCHAR2(10) 
);  

CREATE TABLE EMP(  
    EMPNO       NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK2 PRIMARY KEY,
    NAME        VARCHAR2(10) UNIQUE,
    DEPTNO      VARCHAR2(6) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES dept (DEPTNO),
    -- POSITION    VARCHAR2(10) CONSTRAINT EMPCK_POSITION_CK CHECK (LENGTH(POSITION) < 3),
    POSITION    VARCHAR2(10) CHECK (POSITION IN ('사원', '대리', '과장', '부장')),
    PAY         NUMBER not null,
    PEMPNO      NUMBER(4) 
);     


INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO) 
VALUES (1001, '홍길동', '101', '부장', 450, null);
INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO) 
VALUES (1002, '김연아', '102', '부장', 400, null);
INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO) 
VALUES (1003, '박지성', '101', '과장', 350, 1001);
INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)  
VALUES (1004, '김태근', '103', '과장', 410, null);
INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO) 
VALUES (1005, '서찬수', '101', '대리', 300, 1003);
INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)  
VALUES (1006, '김수현', '103', '대리', 400, 1004);
INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO) 
VALUES (1007, '정동민', '102', '대리', 320, 1002);
INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO) 
VALUES (1008, '이성규', '102', '사원', 380, 1007);
INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO) 
VALUES (1009, '임진영', '103', '사원', 250, 1006);
INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO) 
VALUES (1010, '서진수', '101', '사원', 200, 1005);

SELECT *
FROM EMP;


-- 1. 아래의 값에 맞게 emp테이블에 데이터를 추가하라.
--  - 사원번호:1011, 이름:이순신, 부서번호:104, 직책:부장, 급여:500, 직속상사:NULL 

INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO) 
VALUES (1011, '이순신', '104', '부장', 500, null);

SELECT *
FROM DEPT;



-- 2. dept 테이블에 area 필드의 값을 영업부는 서울, 나머지는 부산으로 값을 업데이트하라.
UPDATE DEPT
SET AREA     = '부산'; 

UPDATE DEPT
SET AREA     = '서울'
WHERE DNAME = '영업부'; 

UPDATE DEPT
SET AREA = CASE
            WHEN DEPTNAME = '영업부' THEN '서울'
            ELSE '부산'
END;

SELECT *
FROM EMP;
-- 3. emp 테이블에서 부서 이름이 홍보부인 데이터를 삭제하라. 
DELETE FROM EMP
WHERE DEPTNO = (
                SELECT DEPTNO
                FROM DEPT
                WHERE DNAME = '홍보부' 
                ); 

-- ////////////////////////////////////////////////////////////
-- 4. emp 테이블을 사용하여 이름,  급여, 세금을 출력하라. 
-- 단 세금은 급여가 0-200이면 급여의 5%, 
-- 201-300이면 급여의 10%, 
-- 301-400 이면 급여의 15%, 
-- 나머지는 급여의 20%로 지정한다.(case문, decode문 각각 2가지로 작성.) 
SELECT
    NAME
    , PAY 
    , CASE 
        WHEN PAY <= 200 THEN PAY*0.05
        WHEN PAY BETWEEN 201 AND 300 THEN PAY*0.1
        WHEN PAY BETWEEN 301 AND 400 THEN PAY*0.15
        ELSE PAY*0.2
      END AS PAY1 
FROM EMP;

SELECT
    NAME
    , PAY  
    , DECODE(PAY
        , IN(SELECT PAY FROM EMP WHERE PAY BETWEEN 0 AND 200), PAY*0.05 
        , IN(SELECT PAY FROM EMP WHERE PAY BETWEEN 201 AND 300), PAY*0.1
        , IN(SELECT PAY FROM EMP WHERE PAY BETWEEN 301 AND 400), PAY*0.15
        , PAY*0.2
      ) AS PAY2 
    --   , DECODE(PAY
    --     , BETWEEN 0 AND 200, PAY*0.05 
    --     , BETWEEN 201 AND 300, PAY*0.1
    --     , BETWEEN 301 AND 400, PAY*0.15
    --     , PAY*0.2
    --   ) AS PAY2 
FROM EMP;

SELECT
    NAME
    , PAY   
    , DECODE(PAY
            , BETWEEN 0 AND 200, PAY*0.05 
            , BETWEEN 201 AND 300, PAY*0.1
            , BETWEEN 301 AND 400, PAY*0.15
    , PAY*0.2
    ) AS PAY2 
FROM EMP; 

-- 정답입니다.
-- 오라클 전용 함수로, 급여를 100 단위로 나눈 몫(TRUNC)을 이용해 각 구간에 맞는 세율을 적용했습니다.
-- TRUNC((SAL-1)/100) 계산 시:
-- 1~200은 0 또는 1이 나옴
-- 201~300은 2가 나옴
-- 301~400은 3이 나옴
SELECT
    NAME
    , PAY
    , DECODE(TRUNC((PAY-1)/100)
        ,1 ,PAY*0.05 
        ,2 ,PAY*0.1
        ,3 ,PAY*0.15 
        , PAY*0.2
    ) AS TAX
    -- , TRUNC((PAY-1)/100 AS GRADE
FROM EMP;

SELECT
    NAME
    , PAY  
    , DECODE(PAY
        , IN(SELECT PAY FROM EMP WHERE PAY BETWEEN 0 AND 200), PAY*0.05 
        , IN(SELECT PAY FROM EMP WHERE PAY BETWEEN 201 AND 300), PAY*0.1
        , IN(SELECT PAY FROM EMP WHERE PAY BETWEEN 301 AND 400), PAY*0.15
        , PAY*0.2
      ) AS PAY2  
FROM EMP;

SELECT 
      EMPNO
    , NAME  
    , DECODE(PAY
        , 450, PAY*1.1
        , 400, PAY*1.05
        , 300, PAY
        , PAY*1.03
    ) AS UPPAY 
FROM EMP;  



SELECT *
FROM EMP;

-- 5. 영업부 직원과 총무부 직원의 
-- 이름, 부서명, 직급을 
-- 이름순으로 오름차순으로 출력하라.
SELECT
      E.NAME
    , D.DNAME
    , E.POSITION
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+)
  AND E.DEPTNO IN('101', '102')
ORDER BY NAME ASC;



-- 6. emp 테이블을 이용하여 사원의 이름과 직속상관의 이름을 출력하라. 
-- 단 직속상관이 없는 경우 null이 표시되도록 하라. 
SELECT 
      E1.NAME 
    , E1.PEMPNO 
    -- , E2.NAME AS PEMPNO_NAME
    , NVL2(E2.NAME, E2.NAME, NULL) AS PEMPNO_NAME
FROM EMP E1, EMP E2
WHERE E1.PEMPNO = E2.EMPNO(+); 




-- 7. 부서별 급여의 평균이 350 이상인 부서의 
-- 부서명, 급여의 평균을 구하라.  
SELECT 
      D.DNAME
    , ROUND(AVG(E.PAY)) 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+)
AND E.DEPTNO IN (SELECT DEPTNO 
                    FROM EMP
                    WHERE PAY >= 350
                    GROUP BY DEPTNO
              ) 
GROUP BY D.DNAME;  

-- 8. emp 테이블에서 각 부서별 급여가 
-- 가장 높은 사람의 
-- 이름, 부서명, 급여를 출력하라(sub query).
SELECT
      E.NAME
    , D.DNAME
    , E.PAY
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+)
AND E.PAY IN (SELECT MAX(PAY) FROM EMP GROUP BY DEPTNO); 

-- 9. emp 테이블에서 이성규와 같은 부서의 
-- 직원의 이름과 부서명을 출력하라.(sub query) 
SELECT 
      E.NAME
    , D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+)
AND E.DEPTNO IN (SELECT D.DEPTNO
                FROM EMP E, DEPT D 
                WHERE E.DEPTNO = D.DEPTNO(+)
                AND NAME = '이성규'); 

-- 10. 과장의 최소급여보다 높은 급여를 받는 사람의 
-- 이름, 직급, 급여를 출력하라.(sub query)
SELECT
    NAME
    , POSITION
    , PAY
FROM EMP
WHERE PAY > (SELECT MIN(PAY)
                FROM EMP
                WHERE POSITION ='과장' 
            );
 





-- 11. mongoDB의 특징을 간략히 기술하고 RDBMS와 차이점을 논리적구조에 대해서 표로 비교하시오.





-- 12. 아래의 json Documnet들을 “pots” Collection에 Insert 한다고 가정하고
--     한번에 함수로 데이터를 넣으시오. (db명: test, collection명 pots)
--     (오류를 만들어 놓았습니다. 수정하여 사용하세요)
db.posts.insertMany([
  {
    title: "Post Title 2",
    body: "Body of post.",
    category: "Event",
    likes: 2,
    tags: ["news", "events"],
    date: Date()
  },
  {
    title: "Post Title 3",
    body: "Body of post.",
    category: "Technology",
    likes: 3,
    tags: ["news", "events"],
    date: Date()
  } 
]) 

