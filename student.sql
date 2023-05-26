
-- 생성
CREATE TABLE 수강
    ( 학과 CHAR(20) PRIMARY KEY,
      과목 CHAR(20),
      교수 CHAR(20),
      학점 INT
      );
      
CREATE TABLE 학생 
   ( 학번             INT,
     성명             CHAR(10)   NOT NULL,
     학과             CHAR(20),
     학점             CHAR(1),
     PRIMARY KEY (학번),
     FOREIGN KEY (학과) REFERENCES 수강(학과)
     );  
     
-- 기본 수강 정보 추가
INSERT INTO 수강 ( 학과, 과목, 교수, 학점 )
VALUES ( '컴퓨터공학과', 'JAVA', '박강', 3 );

INSERT INTO 수강 ( 학과, 과목, 교수, 학점 )
VALUES ( '영어영문학과', '영어회화3', 'Steven', 3 );

INSERT INTO 수강 ( 학과, 과목, 교수, 학점 )
VALUES ( '경영학과', '경제학', '이규석', 3 );

INSERT INTO 수강 ( 학과, 과목, 교수, 학점 )
VALUES ( '뮤지컬학과', '세계연극사', '조현미', 3 );

-- 삭제     
DROP TABLE 수강;     
DROP TABLE 학생;

INSERT INTO 학생
VALUES ( 20190101, '홍길동', '컴퓨터공학과', 'A');

SELECT * FROM 수강;
SELECT * FROM 학생;

ALTER TABLE 학생 ADD 학년 INT;

UPDATE 학생
SET 학년 = 1
WHERE 성명 = '홍길동';

INSERT INTO 학생
VALUES ( 20190102, '김가이', '컴퓨터공학과', 'A', 1);

INSERT INTO 학생
VALUES ( 20180104, '이효인', '컴퓨터공학과', 'A', 2);

INSERT INTO 학생
VALUES ( 20170105, '박설리', '컴퓨터공학과', 'A', 3);

INSERT INTO 학생
VALUES ( 20190103, '김루리', '컴퓨터공학과', 'B', 1);

INSERT INTO 학생
VALUES ( 20190201, '박현수', '영어영문학과', 'A', 1);

INSERT INTO 학생
VALUES ( 20190202, '정환희', '영어영문학과', 'C', 1);

INSERT INTO 학생
VALUES ( 20190203, '이천수', '영어영문학과', 'B', 1);

INSERT INTO 학생
VALUES ( 20180204, '한요한', '영어영문학과', 'C', 2);

INSERT INTO 학생
VALUES ( 20170205, '구수진', '영어영문학과', 'A', 3);

INSERT INTO 학생
VALUES ( 20180206, '한요한', '영어영문학과', 'C', 2);

INSERT INTO 학생
VALUES ( 20170207, '박설리', '영어영문학과', 'A', 3);

INSERT INTO 학생
VALUES ( 20190301, '박서연', '경영학과', 'A', 1);

INSERT INTO 학생
VALUES ( 20190302, '홍민서', '경영학과', 'F', 1);

INSERT INTO 학생
VALUES ( 20190303, '정여름', '경영학과', '', );

INSERT INTO 학생
VALUES ( 20160304, '송지우', '경영학과', 'A', 4);

INSERT INTO 학생
VALUES ( 20160305, '권수아', '경영학과', 'A', 4);

INSERT INTO 학생
VALUES ( 20180306, '강서윤', '경영학과', 'F', 2);

INSERT INTO 학생
VALUES ( 20170307, '최하린', '경영학과', 'B', 3);

INSERT INTO 학생
VALUES ( 20160307, '안아람', '경영학과', 'A', 4);

INSERT INTO 학생
VALUES ( 20160405, '원빈', '뮤지컬학과', 'C', 4);

INSERT INTO 학생
VALUES ( 20180406, '장동건', '뮤지컬학과', 'C', 2);

INSERT INTO 학생
VALUES ( 20170407, '전지현', '뮤지컬학과', 'B', 3);

INSERT INTO 학생
VALUES ( 20160407, '이나영', '뮤지컬학과', 'A', 4);

SELECT 학번, 성명, 학과, 학점, 학년
FROM 학생
WHERE 성명 = '홍길동';

SELECT * 
FROM 학생
WHERE 학년 >= 2;

SELECT *
FROM 학생
ORDER BY 학점, 학년 DESC;

SELECT *
FROM 학생
WHERE 학과 IN ('컴퓨터공학과', '경영학과');

SELECT *
FROM 학생
WHERE 학과 = '컴퓨터공학과' OR 학과 = '경영학과';

SELECT 학과, COUNT(*) AS "A학점자 수"
FROM 학생
WHERE 학점 = 'A'
GROUP BY 학과;

SELECT 학과, 학년, COUNT(*)
FROM 학생
GROUP BY 학과, 학년
ORDER BY 학과 ASC, 학년 ASC;

SELECT 학과, COUNT(*) AS "C학점자 수"
FROM 학생
WHERE 학점 = 'C'
GROUP BY 학과 HAVING COUNT(*) >= 2;

SELECT * FROM 학생
WHERE 성명 LIKE '김%';

-- 뷰 생성 권한
GRANT CREATE VIEW TO student;

CREATE VIEW A학생
AS SELECT * FROM 학생
WHERE 학점 = 'A';

SELECT * FROM A학생;



















