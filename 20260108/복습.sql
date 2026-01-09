
-- 1.	DDL(데이터 정의어)//////////////////////////////////////////////////////// 
-- 테이블 생성
-- 정수형숫자:NUMBER(4) / 가변형문자열:VARCHAR2(10) / 날짜:DATE / 소수둘째자리까지숫자:NUMBER(7,2)
CREATE TABLE EMP_TEST(
    EMPNO   NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME   VARCHAR2(10),
    JOB     VARCHAR2(9),
    MGR     NUMBER(4),
    HIREDATE    DATE,
    SAL     NUMBER(7,2),
    COMM    NUMBER(7,2),
    DEPTNO  NUMBER(2) CONSTRAINT EMPFK_EMPNO_FK REFERENCES TABLE_FK (DEPTNO)
);  
-- 열 추가
ALTER TABLE EMP_ALTER
    ADD HP VARCHAR2(20); 
-- 열 이름 변경
ALTER TABLE EMP_ALTER
    RENAME COLUMN HP TO TEL; 
-- 열 자료형을 변경
ALTER TABLE EMP_ALTER
    MODIFY EMPNO NUMBER(5);  
-- 열 삭제
ALTER TABLE EMP_ALTER
    DROP COLUMN TEL;


-- 테이블 삭제 : 영원히 삭제. 롤백 안됨
DROP TABLE EMP_TEMP; 




-- 2.DML(데이터 조작어)////////////////////////////////////////////////////////
-- 테이블 복사 생성
CREATE TABLE DEPT_TEMP
    AS SELECT * FROM DEPT;  
-- EMP_TEMP 빈공간 만들기
CREATE TABLE EMP_TEMP
AS SELECT *
FROM EMP
WHERE 1 <> 1;

-- 데이터 추가 : 컬럼 지정 안하면 NULL 처리
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (50, 'DATABASE', 'SEOUL');

-- 서브쿼리를 이용해서 한번에 여러데이터 추가
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
AND S.GRADE = 1
;

-- 데이터 수정
-- 컬럼 LOC 전체가 바뀜
UPDATE DEPT_TEMP2
SET LOC = 'SEOUL'; 
-- 조건문으로 부분 수정
UPDATE DEPT_TEMP2
SET DNAME = 'DATABASE',
    LOC   = 'SEOUL'
WHERE DEPTNO = 40 ;

UPDATE DEPT_TEMP2
SET (DNAME, LOC) = (SELECT DNAME, LOC
                    FROM DEPT
                    WHERE DEPTNO = 40  
                    ) 
WHERE DEPTNO = 40    
;  

-- 데이터 삭제
DELETE FROM EMP_TEMP2
WHERE JOB = 'MANAGER'; 



-- 3.함수 ////////////////////////////////////////////////////////
-- 
