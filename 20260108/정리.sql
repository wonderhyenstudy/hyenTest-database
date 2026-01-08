


-- 테이블 생성
CREATE 테이블명
AS 복사해올 테이블 SELECT문;  

-- 넣기/추가
INSERT INTO 테이블명 (컬럼명, 컬럼명)
VALUES (값, 값);

INSERT INTO (컬럼명, 컬럼명)
SELECT 조건문;

-- 변경
UPDATE 테이블명
SET 컬럼명 =  OR 조건
WHERE;

-- 삭제. WHERE 없으면 전체삭제.
DELETE FROM 테이블명
WHERE 컬렴명 = 값 OR 조건

-- 완전삭제
-- 커밋 필요없음. 롤백안됨. 
DROP TABLE 테이블명;