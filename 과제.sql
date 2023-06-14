
-- c## 없이 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- 계정 생성
CREATE USER 계정명 INDENTIFIED BY 비밀번호;
-- 테이블 스페이스 변경
ALTER USER 계정명 DEFAULT TABLESPACE users;
-- 용량 설정
ALTER USER 계정명 QUOTA UNLIMITED ON users;
-- 계정에 권한 부여
GRANT dba TO 계정명;       -- connect, resource


--
SELECT *
FROM employees;

-- employees 테이블에서 'first_name' 속성이 's'로 시작하는
-- 사원을 조회하시오
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- board 테이블 생성
-- board_no (숫자 타입)
-- title (문자열 타입, 100 byte)
-- writer (문자열 타입, 100 byte)
-- content (문자열 타입, 100 byte)
-- reg_date (날짜 타입)
-- upd_date (날짜 타입)

CREATE TABLE board (
  board_no NUMBER PRIMARY KEY,
  title VARCHAR2(100),
  writer VARCHAR2(100),
  content VARCHAR2(100),
  reg_date DATE DEFAULT SYSDATE,
  upd_date DATE DEFAULT SYSDATE,
);

-- 시퀀스를 'SEQ_BOARD' 이름으로 생성하시오
-- (시작값 : 1, 증분값 : 1, 최대값 : 100000 )

CREATE SEQUENCE SEQ_BOARD
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 100000;

-- C.R.U.D
-- board 테이블에 데이터를 추가하는 SQL (시퀀스 사용)
-- board 테이블에 데이터를 수정하는 SQL
-- board 테이블에 데이터를 삭제하는 SQL
-- board 테이블에 데이터를 조회하는 SQL


-- 함수 정의

-- 프로시저 정의

