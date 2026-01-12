-- 정규화 와 머신런닝에 대해 공부하자

-- 정규화
-- 무결성 유지 : 제약조건

-- 후보키

-- 방번호, 방장, 오티티종류, 현재인원, 쉐어금액
SELECT 
      R.room_id                  -- 방번호
    , S.NAME                     -- 방장이름
    , O.ottName                  -- 오티티종류
    , COUNT(I.suser_seq)         -- 현재인원
    , O.price/COUNT(I.suser_seq) -- 쉐어금액
FORM INTERF F 
    , (SELECT NAME
        FROM SUSER
        WHERE roomcreate = 'Y'
       ) AS S -- 방이 있는 방장이름 모음
    , OTT O
    , ROOM R 
WHERE I.ott_seq = O.price(+) -- INTERF/OTT 조인 
  AND R.room_id = I.room_id(+) -- INTERF/ROOM 조인



SELECT 
      R.room_id                  -- 방번호
    , S.NAME                     -- 방장이름
    , O.ottName                  -- 오티티종류
    , COUNT(I.suser_seq) AS CNT  -- 현재인원
    , O.price/CNT                -- 쉐어금액
FORM INTERF F 
    , SUSER S
    , OTT O
    , ROOM R 
WHERE I.ott_seq = O.seq(+) -- INTERF/OTT 조인 
  AND R.create_id = I.room_id(+) -- INTERF/ROOM 조인  
  AND S.NAME IN(SELECT NAME
        FROM SUSER
        WHERE roomcreate = 'Y'
       );


 SELECT
    R.room_id    -- 방번호, 
    R.create_id    -- 방장아이디, 
    R.ott_seq      -- 오티티종류, 
    COUNT(I.suser_seq) AS CNT -- 현재인원, 
    O.price/CNT  -- 쉐어금액
    o.name      --ott이름
    O.price
FORM INTERF F 
    , SUSER S
    , OTT O
    , ROOM R 
WHRER I.room_id = R.room_id 
AND R.create_id = I.suser_seq
AND 