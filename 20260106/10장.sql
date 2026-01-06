
-- INSERT INTO 테이블 이름 [(열1, 열2, ..., 열N)]
-- VALUES (열1에 들어갈 데이터, 열2에 들어갈 데이터, ..., 열N에 들어갈 데이터);


-- DEPT 테이블을 복사해서 DEPT_TEMP 테이블을 생성한다.
-- 데이터도 복사 됨
-- 제약조건은 복사 안됨
-- CREATE TABLE DEPT_TEMP
--     AS SELECT * FROM DEPT;


-- 오른쪽 상단에 "변경사항 커밋"을 꼭 해줘야한다!!!

SELECT * FROM DEPT_TEMP; 

-- 277-280P 읽어보기

-- INSERT
INSERT INTO DEPT_TEMP (deptno, dname, loc)
            VALUES (50, 'MAC', 'BUSAN');
INSERT INTO DEPT_TEMP (deptno, dname, loc)
            VALUES (60, NULL, '');

-- DEL
SELECT *
FROM DEPT_TEMP 
WHERE DEPTNO = 80; 

-- 테이블 통째로 날리기

-- UPDATET
UPDATE DEPT_TEMP 
SET DNAME='HAHA',LOC='ROMA'
WHERE DEPTNO = 80; 



