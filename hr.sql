-- 데이터 조회 명령어 - SELECT
-- SELECT 컬럼명, ...
-- FROM 테이블명
-- WHERE 조건;

-- 커서 부분 실행 : ctrl + enter
-- 문서 전체 실행 : F5

-- 1.
conn system/123456;


-- 2.

-- HR(인사관리 정보) 샘플 데이터를 가져와서 실습
-- HR 계정이 없는 경우, HR계정 생성

-- HR 계정 생성하기
-- 11g 버전 이하는 어떤 이름으로도 계정생성 가능
-- 12c 버전 이상에서는 'c##' 접두어를 붙여서 생성하도록 규칙을 정함

-- 계정 생성하기
-- c## 없이 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER HR IDENTIFIED BY 123456;
-- 테이블 스페이스 변경
ALTER USER HR DEFAULT TABLESPACE users;
-- 계정이 사용할 수 있는 용량 설정 (무한대)
ALTER USER HR QUOTA UNLIMITED ON users;
-- 계정에 권한 부여 
GRANT connect, resource TO HR;

-- 계정 삭제
DROP USER HR CASCADE;

-- HR 게정이 잠겨 있는 경우,
-- HR 게정 잠금 해제
ALTER USER HR ACCOUNT UNLOCK;


-- hr_main.sql 실행하여 HR 샘플 데이터 가져오기
-- 1. SQL PLUS 
-- 2. HR 계정으로 접속
-- 3. 명령어 입력 : @[경로]\hr_main.sql
--    @? : 오라클 설치된 기본 경로
--    @?/demo/schema/human_resources/hr_main.sql
--> 1  : 123456 [비빌번호]
--> 2  : users [tablespace]  
--> 3  : temp [temp tablespace]
--> 4  : [log 경로] - C:\KHM\SETUP\WINDOWS.X64_193000_db_home\demo\schema\log



-- 3. 
-- 테이블 EMPLOYEES 의 테이블 구조를 조회하는 SQL 문을 작성하시오.
-- 테이블 : 행과 열로 데이터를 관리하는 기본 구조
-- 행 = row = 레코드   : 각 속성에 대한 하나의 데이터를 의미
-- 열 = column = 속성  : 데이터의 이름(특성)을 정의
DESC employees;

-- 3.
-- 테이블 EMPLOYEES 에서 EMPLOYEE_ID, FIRST_NAME (회원번호, 이름) 를 
-- 조회하는 SQL 문을 작성하시오.
SELECT employee_id, first_name
FROM employees;

-- 4.
-- 테이블 EMPLOYEES 이 <예시>와 같이 출력되도록 조회하는 SQL 문을 작성하시오.
SELECT *        -- (*) [에스터리크] : 모든 컬럼 지정
FROM employees;

-- AS (alias) : 출력되는 컬럼명에 별명을 짓는 명령어
SELECT employee_id AS "사원 번호"  -- 띄어쓰기가 있으면, " " 로 표기
      ,first_name AS 이름
      ,last_name AS 성
      ,email AS 이메일
      ,phone_number AS 전화번호
      ,hire_date AS 입사일자
      ,salary AS 급여
FROM employees;


-- 5.
-- 테이블 EMPLOYEES 의 JOB_ID를 중복된 데이터를 제거하고 
-- 조회하는 SQL 문을 작성하시오.
SELECT DISTINCT job_id
FROM employees;


-- 6. 
-- 테이블 EMPLOYEES 의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을 
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE salary > 6000;

-- 7.
-- 테이블 EMPLOYEES 의 SALARY(급여)가 10000인 사원의 모든 컬럼을 
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE salary = 10000;



-- 8.
-- 테이블 EMPLOYEES 의 모든 속성들을 
-- SALARY 를 기준으로 내림차순 정렬하고, 
-- FIRST_NAME 을 기준으로 오름차순 정렬하여 조회하는 SQL 문을 작성하시오.

-- 정렬 명령어
-- ORDER BY 컬럼명 [ASC/DESC];
-- * ASC        : 오름차순
-- * DESC       : 내림차순
-- * (생략)      : 오름차순이 기본값
SELECT *
FROM employees
ORDER BY salary DESC, first_name ASC;




-- 9.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 조건 연산
-- OR 연산 : ~또는, ~이거나
-- WHERE A OR B;
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT' 
   OR job_id = 'IT_PROG';


-- 10.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 단, IN 키워드를 사용하시오.
SELECT *
FROM employees
WHERE job_id IN ('FI_ACCOUNT', 'IT_PROG');

-- 11.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 아닌
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 단, IN 키워드를 사용하시오.
SELECT *
FROM employees
WHERE job_id NOT IN ('FI_ACCOUNT', 'IT_PROG');


-- 12.
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘IT_PROG’ 이면서 SALARY 가 6000 이상인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
SELECT *
FROM employees
WHERE job_id = 'IT_PROG'
  AND salary >= 6000;
  
-- 13.
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘S’로 시작하는 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- 14. s로 끝나는
SELECT *
FROM employees
WHERE first_name LIKE '%s';

-- 15. s가 포함되는
SELECT *
FROM employees
WHERE first_name LIKE '%s%';

-- 16.
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 5글자인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
SELECT *
FROM employees
WHERE first_name LIKE '_____';

-- LENGTH(컬럼명) : 글자 수를 반환하는 함수
SELECT *
FROM employees
WHERE LENGTH(first_name) = 5;


-- 17.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- 18.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 이 아닌 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

-- 19.
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년 이상인
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
SELECT *
FROM employees
WHERE hire_date >= '04/01/01';


-- 20.
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년도부터 05년도인 
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
SELECT *
FROM employees
WHERE hire_date >= '04/01/01'
  AND hire_date <= '05/12/31';
  
-- 컬럼 BETWEEN A AND B;
-- : A 보다 크거나 같고 B 보다 작거나 같은 조건 (사이)
SELECT *
FROM employees
WHERE hire_date BETWEEN '04/01/01' AND '05/12/31';

-- (추가 문제)
-- first_name 이 A~D 로 시작하는 사원을 조회
SELECT *
FROM employees
WHERE first_name BETWEEN 'A' AND 'D';   -- (A~CZZ 사이의 이름을 같는 사람)




-- 21.
-- 12.45, -12.45 보다 크거나 같은 정수 중 제일 작은 수를 
-- 계산하는 SQL 문을 각각 작성하시오.
-- * dual ?
-- : 산술 연산, 함수 결과 등을 확인해볼 수 있는 임시 테이블
-- CEIL() "천정"
-- : 지정한 값보다 크거나 같은 정수 중 제일 작은 수를 반환하는 함수
SELECT CEIL(12.45) FROM dual;
SELECT CEIL(-12.45) FROM dual;
SELECT CEIL(12.45), CEIL(-12.45) FROM dual;


-- 22.
-- 12.55와 -12.55 보다 작거나 같은 정수 중 가장 큰 수를 
-- 계산하는 SQL 문을 각각 작성하시오.
-- FLOOR() "바닥"
-- : 지정한 값보다 작거나 같은 정수 중 가장 큰 수를 반환하는 함수
SELECT FLOOR(12.55) FROM dual;
SELECT FLOOR(-12.55) FROM dual;
SELECT FLOOR(12.55), FLOOR(-12.55) FROM dual;

-- 23.
-- ROUND(값, 자리수)
-- : 지정한 값을, 해당 자리수에서 반올림하는 함수
-- a a a a a.bbbb
-- ...  -2-1.0123
-- 0.54 를 소수점 아래 첫째 자리에서 반올림하시오
SELECT ROUND(0.54, 0) FROM dual;

-- 0.54 를 소수점 아래 둘째 자리에서 반올림하시오
SELECT ROUND(0.54, 1) FROM dual;

-- 125.67 을 일의 자리에서 반올림하시오.
SELECT ROUND(125.67, -1) FROM dual;

-- 125.67 을 십의 자리에서 반올림하시오.
SELECT ROUND(125.67, -2) FROM dual;





-- 24.
-- 각 소문제에 제시된 두 수를 이용하여 나머지를 구하는 SQL문을 작성하시오.
-- MOD( A, B )
-- : A를 B로 나눈 나머지를 구하는 함수

-- 3을 8로 나눈 나머지
SELECT MOD(3, 8) FROM dual;

-- 30을 4로 나눈 나머지
SELECT MOD(30, 4) FROM dual;

-- 25. 제곱수 구하기
-- POWER( A, B )
-- : A 의 B 제곱을 구하는 함수
-- 2의 10 제곱을 구하시오.
SELECT POWER(2,10) FROM dual;

-- 2의 31제곱을 구하시오
SELECT POWER(2,31) FROM dual;


-- 26. 제곱근 구하기
-- SQRT( A )
-- : A의 제곱근을 구하는 함수
--   A는 양의 정수와 실수만 사용 가능
-- 2의 제곱근을 구하시오.
SELECT SQRT(2) FROM dual;

-- 100의 제곱근을 구하시오.
SELECT SQRT(100) FROM dual;

-- 27.
-- TRUNC(실수, 자리수) 
-- : 해당 수를 절삭하는 함수
-- 527425.1234 소수점 아래 첫째 자리에서 절삭
SELECT TRUNC(527425.1234, 0) FROM dual;

-- 527425.1234 소수점 아래 둘째 자리에서 절삭
SELECT TRUNC(527425.1234, 1) FROM dual;

-- 527425.1234 일의 자리에서 절삭
SELECT TRUNC(527425.1234, -1) FROM dual;

-- 527425.1234 십의 자리에서 절삭
SELECT TRUNC(527425.1234, -2) FROM dual;



-- 28. 절댓값 구하기
-- ABS( A )
-- : 값 A 의 절댓값을 구하여 변환하는 함수

-- -20 의 절댓값 구하기
SELECT ABS(-20) FROM dual;

-- -12.456 의 절댓값 구하기
SELECT ABS(-12.456) FROM dual;


SELECT first_name
      ,TO_CHAR(hire_date, 'YYYY"년"MM"월"DD"일"')
      ,TO_CHAR(hire_date, 'YYYY-MM-DD')
FROM employees; 

-- 29.
-- <예시>와 같이 문자열을 대문자, 소문자, 첫글자만 대문자로 
-- 변환하는 SQL문을 작성하시오.
SELECT 'AlOhA WoRlD~!' AS 원문
       ,UPPER('AlOhA WoRlD~!') AS 대문자
       ,LOWER('AlOhA WoRlD~!') AS 소문자
       ,INITCAP('AlOhA WoRlD~!') AS "첫글자만 대문자"
FROM dual;

-- 30.
-- <예시>와 같이 문자열의 글자 수와 바이트 수를 
-- 출력하는 SQL문을 작성하시오.
-- LENGTH('문자열')  : 글자 수
-- LENGTHB('문자열') : 바이트 수
-- * 영문, 숫자, 빈칸  : 1 byte
-- * 한글             : 3 byte
SELECT LENGTH('ALOHA WORLD') AS "글자 수"
      ,LENGTHB('ALOHA WORLD') AS "바이트 수"
FROM dual;

SELECT LENGTH('알로하 월드') AS "글자 수"
      ,LENGTHB('알로하 월드') AS "바이트 수"
FROM dual;

-- 31.
-- 두 문자열을 연결하기
SELECT CONCAT('ALOHA', 'WORLD') AS "함수"
      ,'ALOHA' || 'WORLD' AS "기호"
FROM dual;


-- 32.
-- 문자열 부분 출력하기
-- SUBSTR( 문자열, 시작번호, 글자수 )
-- 'www.alohacampus.com'
SELECT SUBSTR('www.alohacampus.com', 1, 3) AS "1"
      ,SUBSTR('www.alohacampus.com', 5, 11) AS "2"
      ,SUBSTR('www.alohacampus.com', -3, 3) AS "3"
FROM dual;

SELECT SUBSTRB('www.alohacampus.com', 1, 3) AS "1"
      ,SUBSTRB('www.alohacampus.com', 5, 11) AS "2"
      ,SUBSTRB('www.alohacampus.com', -3, 3) AS "3"
FROM dual;

-- 'www.알로하캠퍼스.com'
SELECT SUBSTR('www.알로하캠퍼스.com', 1, 3) AS "1"
      ,SUBSTR('www.알로하캠퍼스.com', 5, 6) AS "2"
      ,SUBSTR('www.알로하캠퍼스.com', -3, 3) AS "3"
FROM dual;

SELECT SUBSTRB('www.알로하캠퍼스.com', 1, 3) AS "1"
      ,SUBSTRB('www.알로하캠퍼스.com', 5, 18) AS "2"
      ,SUBSTRB('www.알로하캠퍼스.com', -3, 3) AS "3"
FROM dual;


-- 33. 
-- 문자열에서 특정 문자의 위치를 구하는 함수
-- INSTR( 문자열, 찾을 문자, 시작 번호, 순서 )
-- ex) 'ALOHACAMPUS'
-- 해당 문자열에서 첫글자 부터 찾아서, 2번째 A의 위치를 구하시오.
-- INSTR('ALOHACAMPUS', 'A', 1, 2)

SELECT INSTR('ALOHACAMPUS', 'A', 1, 1) AS "1번째 A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 2) AS "2번째 A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 3) AS "3번째 A"
FROM dual;


-- 34.
-- 문자열을 왼쪽/오른쪽에 출력하고, 빈공간을 특정 문자로 채우는 함수
-- LPAD( 문자열, 칸의 수, 채울 문자 )
-- : 문자열에 지정한 칸을 확보하고, 왼쪽에 특정 문자로 채움

-- RPAD( 문자열, 칸의 수, 채울 문자 )
-- : 문자열에 지정한 칸을 확보하고, 오른쪽에 특정 문자로 채움

SELECT LPAD('ALOHACMAPUS', 20, '#') AS "왼쪽"
      ,RPAD('ALOHACMAPUS', 20, '#') AS "오른쪽"
FROM dual;

-- 35.
-- HIRE_DATE 입사일자를 날짜형식을 지정하여 출력하시오.
-- TO_CHAR( 데이터, '날짜/숫자 형식' )
-- : 특정 데이터를 문자열 형식으로 변환하는 함수
SELECT first_name AS 이름
      ,TO_CHAR(hire_date, 'YYYY-MM-DD (dy) HH:MI:SS') AS 입사일자
FROM employees;


-- 36.
-- SALARY 급여를 통화형식으로 지정하여 출력하시오.
SELECT first_name 이름
      ,TO_CHAR(salary, '$999,999,999.00') AS 급여
FROM employees;

-- 37.
-- TO_DATE( 데이터 )
-- : 문자형 데이터를 날짜형 데이터로 변환하는 함수
SELECT 20230522 AS 문자
      ,TO_DATE('20230522', 'YYYYMMDD') AS 날짜
FROM dual;

-- 38.
-- TO_NUMBER( 데이터 )
-- : 문자형 데이터를 숫자형 데이터로 변환하는 함수
SELECT '1,200,000' AS 문자
      ,TO_NUMBER('1,200,000', '999,999,999') AS 숫자
FROM dual;


-- 39.
-- 어제, 오늘, 내일 날짜를 출력하시오.
-- sysdate : 현재 날짜/시간 정보를 가지고 있는 키워드
-- 2023/05/22 - YYYY/MM/DD 형식으로 출력
-- 날짜 데이터 --> 문자 데이터 변환
SELECT sysdate FROM dual;

SELECT sysdate-1 AS 어제
      ,sysdate AS 오늘
      ,sysdate+1 AS 내일
FROM dual;

-- 40.
-- 사원의 근무달수와 근속연수를 구하시오.
-- MONTHS_BETWEEN( A, B)
-- - 날짜 A부터 B까지 개월 수 차이를 반환하는 함수
--   (단, A > B 즉, A가 더 최근 날짜로 지정해야 양수로 반환)
SELECT first_name 이름
      ,TO_CHAR(hire_date, 'YYYY.MM.DD') 입사일자
      ,TO_CHAR(SYSDATE, 'YYYY.MM.DD') 오늘
      ,TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) || '개월' 근무달수
      ,TRUNC(MONTHS_BETWEEN(sysdate, hire_date) / 12) || '년' 근속연수
FROM employees;

-- 41.
-- 오늘로부터 6개월 후의 날짜를 구하시오.
-- ADD_MONTHS( 날짜, 개월 수 )
-- : 지정한 날짜로부터 해당 개월 수를 후의 날짜를 반환하는 함수
SELECT sysdate 오늘
      ,ADD_MONTHS(sysdate, 6) "6개월 후"
FROM dual;

SELECT '2023/04/17' 개강
      ,ADD_MONTHS('2023/04/17', 6) 종강
FROM dual;

-- 42.
-- 오늘 이후 돌아오는 토요일을 구하시오.
-- NEXT_DAY( 날짜, 요일 )
-- : 지정한 날짜 이후 돌아오는 요일을 반환하는 함수
-- 일 월 화 수 목 금 토
-- 1  2  3  4  5 6  7
SELECT sysdate 오늘
      ,NEXT_DAY( sysdate, 7 ) "다음 토요일"
FROM dual;


SELECT NEXT_DAY( sysdate, 1 ) "다음 일요일"
      ,NEXT_DAY( sysdate, 2 ) "다음 월요일"
      ,NEXT_DAY( sysdate, 3 ) "다음 화요일"
      ,NEXT_DAY( sysdate, 4 ) "다음 수요일"
      ,NEXT_DAY( sysdate, 5 ) "다음 목요일"
      ,NEXT_DAY( sysdate, 6 ) "다음 금요일"
      ,NEXT_DAY( sysdate, 7 ) "다음 토요일"
FROM dual;

-- 43.
-- 오늘 날짜와 해당 월의 월초, 월말 일자를 구하시오.
-- LAST_DAY( 날짜 )
-- : 지정한 날짜와 동일한 월의 월말 일자를 반환하는 함수
-- 날짜 : XXXXXX.YYYYYYY
-- 1970년01월01일 00시00분00초00ms → 2023년5월22일 .... 
-- 지난 일자를 정수로 계산, 시간정보는 소수부분으로 계산
-- xxxx.yyyyy --> 2023년5월22일
-- 월 단위 아래로 절삭하면, 월초를 구할 수 있다
SELECT TRUNC( sysdate, 'MM' ) 월초
      ,sysdate 오늘
      ,LAST_DAY( sysdate ) 월말
FROM dual;


-- 44.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT 를 중복없이 검색하되, 
-- NULL 이면 0으로 조회하고 내림차순으로 정렬하는 SQL 문을 작성하시오.

-- NVL( 값, 대체할 값 ) : 해당 값이 NULL 이면 지정된 값으로 변환하는 함수
SELECT DISTINCT NVL(commission_pct, 0) "커미션(%)"
FROM employees
ORDER BY NVL(commission_pct, 0) DESC
;

-- 조회한 컬럼의 별칭으로 ORDER BY 절에서 사용할 수 있다.
SELECT DISTINCT NVL(commission_pct, 0) "커미션(%)"
FROM employees
ORDER BY "커미션(%)" DESC
;

-- 45.
-- EMPLOYEES 의 FIRST_NAME, SALARY, COMMISSION_PCT 속성을 이용하여 
-- 급여, 커미션, 최종급여를 조회하시오.
-- * 최종급여 = 급여 + (급여 * 커미션)
-- * NVL2( 값, NULL 아닐 때 값, NULL 일 때 값 )

SELECT first_name 이름
      ,salary 급여
      ,NVL(commission_pct, 0) 커미션
      ,NVL2(commission_pct, salary+(salary*commission_pct), salary) 최종급여
FROM employees
ORDER BY 최종급여 DESC
;

-- 46.
-- DEPARTMENTS 테이블을 참조하여, 사원의 이름과 부서명을 출력하시오.
-- DECODE( 컬럼명, 조건값1, 반환값1, 조건값2, 반환값2, ... )
-- : 지정한 컬럼의 값이 조건값에 일치하면 바로 뒤의 반환값을 출력하는 함수
SELECT first_name 이름
      ,DECODE( department_id, 10, 'Administration',
                              20, 'Marketing',
                              30, 'Purchasing',
                              40, 'Human Resources',
                              50, 'Shipping',
                              60, 'IT',
                              70, 'Public Relations',
                              80, 'Sales',
                              90, 'Executive',
                              100, 'Finance'
     ) 부서
FROM employees;


-- 47.
-- CASE 문
-- : 조건식을 만족할 때, 출력할 값을 지정하는 구문
-- 한 줄 복사 : ctrl + shift + D
SELECT first_name 이름
      ,CASE WHEN department_id = 10 THEN 'Administration'
            WHEN department_id = 20 THEN 'Marketing'                 
            WHEN department_id = 30 THEN 'Purchasing'                 
            WHEN department_id = 40 THEN 'Human Resources'                 
            WHEN department_id = 50 THEN 'Shipping'                 
            WHEN department_id = 60 THEN 'IT'                 
            WHEN department_id = 70 THEN 'Public Relations'                 
            WHEN department_id = 80 THEN 'Sales'                 
            WHEN department_id = 90 THEN 'Executive'                 
            WHEN department_id = 100 THEN 'Finance'        
      END 부서
FROM employees;


-- 그룹함수
-- 48.
-- EMPLOYEES 테이블로 부터 전체 사원 수를 구하시오.
-- COUNT( 컬럼명 )
-- : 컬럼을 지정하여 NULL 을 제외한 데이터 개수를 반환하는 함수
-- * NULL 이 없는 데이터라면 어떤 컬럼을 지정하더라도 개수가 같으므로,
--   일반적으로 COUNT(*) 로 개수를 구한다.
SELECT COUNT(*) 사원수
FROM employees;




-- 49.
-- 사원들의 최고급여와 최저급여를 구하시오.
SELECT MAX(salary) 최고급여
      ,MIN(salary) 최저급여
FROM employees;

-- 50.
-- 사원들의 급여 합계와 평균을 구하시오.
SELECT SUM(salary) 급여합계
      ,ROUND( AVG(salary), 2 ) 급여평균
FROM employees;

-- 51.
-- 사원들의 급여 표준편차와 분산을 구하시오.
SELECT ROUND( STDDEV(salary), 2 ) 급여표준편차
      ,ROUND( VARIANCE(salary), 2 ) 급여분산
FROM employees;

-- 52.
-- MS_STUDENT 테이블을 생성하시오.
-- * 테이블 생성
/*
    CREATE TABLE 테이블명 (
        컬럼명1 타입     [NOT NULL/NULL] [제약조건],
        컬럼명2 타입     [NOT NULL/NULL] [제약조건],
        컬럼명3 타입     [NOT NULL/NULL] [제약조건],
        ...
    );
*/
-- * 테이블 삭제
/*
    DROP TABLE 테이블명;
*/
DROP TABLE MS_STUDENT;

CREATE TABLE MS_STUDENT (
     ST_NO      NUMBER          NOT NULL
    ,NAME       VARCHAR2(20)    NOT NULL
    ,CTZ_NO     CHAR(14)        NOT NULL
    ,EMAIL      VARCHAR2(100)   NOT NULL
    ,ADDRESS    VARCHAR2(1000)  NULL
    ,DEPT_NO    NUMBER          NOT NULL
    ,MJ_NO      NUMBER          NOT NULL
    ,REG_DATE   DATE    DEFAULT sysdate NOT NULL
    ,UPD_DATE   DATE    DEFAULT sysdate NOT NULL
    ,ETC        VARCHAR2(1000)  DEFAULT '없음' NULL
    ,
    CONSTRAINT MS_STUDENT_PK PRIMARY KEY(ST_NO) ENABLE
);

-- UQ (고유키) 추가
ALTER TABLE MS_STUDENT ADD CONSTRAINT MS_STUDENT_UK1 UNIQUE ( EMAIL ) ENABLE;

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.DEPT_NO IS '부서번호';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';


-- 53.
-- MS_STUDENT 테이블에 성별, 재적, 입학일자, 졸업일자 속성을 추가하시오.

-- 테이블에 속성 추가
-- ALTER TABLE 테이블명 ADD 컬럼명 타입 DEFAULT 기본값 [NOT NULL];
ALTER TABLE MS_STUDENT ADD GENDER CHAR(6) DEFAULT '기타' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';

ALTER TABLE MS_STUDENT ADD STATUS VARCHAR2(10) DEFAULT '대기' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';

ALTER TABLE MS_STUDENT ADD ADM_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';

ALTER TABLE MS_STUDENT ADD GRD_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

-- 테이블 속성 삭제
-- ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
ALTER TABLE MS_STUDENT DROP COLUMN GENDER;
ALTER TABLE MS_STUDENT DROP COLUMN STATUS;
ALTER TABLE MS_STUDENT DROP COLUMN ADM_DATE;
ALTER TABLE MS_STUDENT DROP COLUMN GRD_DATE;

-- 54
-- MS_STUDENT 테이블의 CTZ_NO 속성을 BIRTH 로 이름을 변경하고
-- 데이터 타입을 DATE 로 수정하시오.
-- 그리고, 설명도 '생년월일'로 변경하시오.
ALTER TABLE MS_STUDENT RENAME COLUMN CTZ_NO TO BIRTH;
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';

-- 속성 변경 - 타입 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
-- 속성 변경 - NULL 여부 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH NULL;
-- 속성 변경 - DEFAULT 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DEFAULT sysdate;

-- 동시에 적용 가능
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE DEFAULT sysdate NOT NULL;



-- 55.
-- MS_STUDENT 테이블의 학부 번호(DEPT_NO) 속성을 삭제하시오.
ALTER TABLE MS_STUDENT DROP COLUMN DEPT_NO;


-- 56.
-- MS_STUDENT 테이블을 삭제하시오.
DROP TABLE MS_STUDENT;


-- 57.
--
CREATE TABLE MS_STUDENT (
     ST_NO      NUMBER          NOT NULL 
    ,NAME       VARCHAR2(20)    NOT NULL
    ,BIRTH      DATE            NOT NULL
    ,EMAIL      VARCHAR2(100)   NOT NULL
    ,ADDRESS    VARCHAR2(1000)  NULL
    ,MJ_NO       VARCHAR2(10)          NOT NULL
    ,GENDER     CHAR(6)         DEFAULT '기타'    NOT NULL
    ,STATUS     VARCHAR2(10)    DEFAULT '대기'    NOT NULL
    ,ADM_DATE   DATE    NULL
    ,GRD_DATE   DATE    NULL
    ,REG_DATE   DATE    DEFAULT sysdate NOT NULL
    ,UPD_DATE   DATE    DEFAULT sysdate NOT NULL
    ,ETC        VARCHAR2(1000)  DEFAULT '없음' NULL
    ,
    CONSTRAINT MS_STUDENT_PK PRIMARY KEY(ST_NO) ENABLE
);

-- UQ (고유키) 추가
ALTER TABLE MS_STUDENT ADD CONSTRAINT MS_STUDENT_UK1 UNIQUE ( EMAIL ) ENABLE;

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';

COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 58.
-- MS_STUDENT 테이블에 데이터를 추가하시오.
-- * 데이터 추가
/*
    ▶ 기본문법
    INSERT INTO [테이블명] ( 컬럼1, 컬럼2, ... )
    VALUES ( '값1', '값2', ... );
    * 컬럼 작성 순서와, 값 작성 순서가 짝을 이루어야한다.
    

    ▶ 컬럼명 생략
    INSERT INTO 테이블
    VALUES ( 값1, 값2, 값3, ... )
    * 컬럼명을 생략하고 작성하면, 컬럼 저의 순서대로 모든 값을 지정해야한다.


    ▶ 데이터를 조회하여 추가하기
     INSERT INTO 테이블 ( 컬럼1, 컬럼2, 컬럼3, ... )
     SELECT 컬럼1, 컬럼2, 컬럼3, ...
     FROM 테이블
     [WHERE] 조건 ;
    
*/

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,MJ_NO,GENDER,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20180001', '최서아', '991005', 'csa@univ.ac.kr', '서울', '여', 'I01', '재학', '2018/03/01', NULL, sysdate, sysdate, NULL );

SELECT * FROM ms_student;

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210001', '박서준', '020504', 'psj@univ.ac.kr', '서울', '남', 'B02', '재학', '2021/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210002', '김아윤', '020504', 'kay@univ.ac.kr', '인천', '여', 'S01', '재학', '2021/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20160001', '정수안', '970210', 'jsa@univ.ac.kr', '경남', '여', 'J02', '재학', '2016/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20150010', '윤도현', '960311', 'ydh@univ.ac.kr', '제주', '남', 'K01', '재학', '2015/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20130007', '안아람', '941124', 'aar@univ.ac.kr', '경기', '여', 'Y01', '재학', '2013/03/01', NULL, sysdate, sysdate, '영상예술 특기자' );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20110002', '한성호', '921007', 'hsh@univ.ac.kr', '서울', '기타', 'E03', '재학', '2015/03/01', NULL, sysdate, sysdate, NULL );

COMMIT;

SELECT * FROM MS_STUDENT;


-- 59.
-- MS_STUDENT 테이블의 데이터를 수정하시오.
-- UPDATE
/*
    UPDATE 테이블명
       SET 컬럼1 = 변경할 값,
           컬럼2 = 변경할 값,
           ...
   [WHERE] 조건;
*/
-- 1) 학생번호가 20160001 인 학생의 주소를 '서울'로,
--    재적 상태를 '휴학'으로 수정하시오.
UPDATE MS_STUDENT
   SET address = '서울'
      ,status = '휴학'
 WHERE st_no = 20160001;

-- 2) 학생번호가 20150010 인 학생의 주소를 '서울'로,
--    재석 상태를 '졸업' 으로, 졸업일자는 '20200220', 수정일자는 현재날짜로
--    그리고 특이사항을 '수석'으로 수정하시오.
UPDATE MS_STUDENT
   SET address = '서울', status = '졸업', grd_date = '2020/02/02',
       upd_date = sysdate, etc = '수석'
WHERE st_no = 20150010;

-- 3)  학생번호가 20130007 인 재적 상태를 '졸업'으로,
--    졸업일자는 '20200220', 수정일자는 현재날짜로 수정하시오.
UPDATE MS_STUDENT
   SET status = '졸업', grd_date = '2020/02/02', upd_date = sysdate
WHERE st_no = 20130007;

-- 4)  학생번호가 20110002 인 재적 상태를 '퇴학'으로,
--    졸업일자는 '20130210', 수정일자는 현재날짜로 
--    그리고 특이사항을 '자진 퇴학' 으로 수정하시오.
UPDATE MS_STUDENT
   SET status = '퇴학', grd_date = '2020/02/02', upd_date = sysdate
      ,etc = '자진 퇴학'
WHERE st_no = 20110002;

SELECT * FROM ms_student;



-- 60.
-- MS_STUDENT 테이블에서 학번이 20110002 인 학생을 삭제하시오.
DELETE FROM MS_STUDENT WHERE ST_NO = 20110002;

-- 61.
-- MS_STUDENT 테이블의 모든 속성을 조회하시오.
SELECT *
FROM MS_STUDENT;


-- 62. 
-- MS_STUDENT 테이블을 조회하여 MS_STUDENT_BACK 테이블로 생성하시오.
-- 백업 테이블 만들기

CREATE TABLE MS_STUDENT_BACK
AS SELECT * FROM MS_STUDENT;

SELECT * FROM MS_STUDENT_BACK;


-- 63.
-- MS_STUDENT 테이블의 튜플을 삭제하시오
DELETE FROM MS_STUDENT;

SELECT * FROM MS_STUDENT;

-- 64.
-- MS_STUDENT_BACK 테이블의 모든 속성을 조회하여 
-- MS_STUDENT 테이블에 삽입하시오.
INSERT INTO MS_STUDENT SELECT * FROM MS_STUDENT_BACK;

SELECT * FROM MS_STUDENT;

-- 65.
-- MS_STUDENT 테이블의 성별(gender) 속성에 대하여
-- ('여','남','기타') 값만 입력가능하도록 하는 제약조건을 추가하시오.
ALTER TABLE MS_STUDENT 
ADD CONSTRAINT MS_STD_GENDER_CHECK
CHECK (gender IN ('여','남','기타') );

UPDATE MS_STUDENT
SET gender = '???'
;

SELECT * FROM MS_STUDENT;
DELETE FROM MS_STUDENT;


-- 66.
-- 테이블 기술서를 참고하여 MS_USER 테이블을 생성하시오.
CREATE TABLE MS_USER (
      
      USER_NO     NUMBER            NOT NULL    PRIMARY KEY ,
      USER_ID     VARCHAR2(100)     NOT NULL    UNIQUE ,
      USER_PW     VARCHAR2(200)     NOT NULL ,
      USER_NAME   VARCHAR2(50)      NOT NULL ,
      BIRTH       DATE              NOT NULL ,
      TEL         VARCHAR2(20)      NOT NULL UNIQUE ,
      ADDRESS     VARCHAR2(200)     NULL ,
      REG_DATE    DATE        DEFAULT sysdate NOT NULL,
      UPD_DATE    DATE        DEFAULT sysdate NOT NULL
);

-- 한줄 복사 : alt + shift + ↓
COMMENT ON TABLE MS_USER IS '회원';
COMMENT ON COLUMN MS_USER.USER_NO IS '회원정보';
COMMENT ON COLUMN MS_USER.USER_ID IS '아이디';
COMMENT ON COLUMN MS_USER.USER_PW IS '비밀번호';
COMMENT ON COLUMN MS_USER.USER_NAME IS '이름';
COMMENT ON COLUMN MS_USER.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_USER.TEL IS '전화번호';
COMMENT ON COLUMN MS_USER.ADDRESS IS '주소';
COMMENT ON COLUMN MS_USER.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_USER.UPD_DATE IS '수정일자';


-- 67.
-- MS_BOARD 테이블을 생성하시오.
CREATE TABLE MS_BOARD (
      BOARD_NO    NUMBER            NOT NULL PRIMARY KEY ,
      TITLE       VARCHAR2(200)     NOT NULL ,
      CONTENT     CLOB              NOT NULL ,
      WRITER      VARCHAR2(100)     NOT NULL ,
      HIT         NUMBER            NOT NULL ,
      LIKE_CNT    NUMBER            NOT NULL ,
      DEL_YN      CHAR(2)           NULL ,
      DEL_DATE    DATE              NULL ,
      REG_DATE    DATE              DEFAULT sysdate NOT NULL ,
      UPD_DATE    DATE              DEFAULT sysdate NOT NULL 
);

COMMENT ON TABLE MS_BOARD IS '게시판';
COMMENT ON COLUMN MS_BOARD.BOARD_NO IS '게시글 번호';
COMMENT ON COLUMN MS_BOARD.TITLE IS '제목';
COMMENT ON COLUMN MS_BOARD.CONTENT IS '내용';
COMMENT ON COLUMN MS_BOARD.WRITER IS '작성자';
COMMENT ON COLUMN MS_BOARD.HIT IS '조회수';
COMMENT ON COLUMN MS_BOARD.LIKE_CNT IS '좋아요 수';
COMMENT ON COLUMN MS_BOARD.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_BOARD.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_BOARD.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_BOARD.UPD_DATE IS '수정일자';




-- 68.
-- MS_FILE 테이블을 생성하시오.
CREATE TABLE MS_FILE (
      FILE_NO     NUMBER NOT NULL PRIMARY KEY ,
      BOARD_NO    NUMBER NOT NULL ,
      FILE_NAME   VARCHAR2(2000) NOT NULL ,
      FILE_DATA   BLOB  NOT NULL ,
      REG_DATE    DATE  DEFAULT sysdate NOT NULL ,
      UPD_DATE    DATE  DEFAULT sysdate NOT NULL 
);

COMMENT ON TABLE MS_FILE '첨부파일';
COMMENT ON COLUMN MS_FILE.FILE_NO IS '파일번호';
COMMENT ON COLUMN MS_FILE.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_FILE.FILE_NAME IS '파일명';
COMMENT ON COLUMN MS_FILE.FILE_DATA IS '파일';
COMMENT ON COLUMN MS_FILE.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_FILE.UPD_DATE IS '수정일자';

-- 69.
-- MS_REPLY 테이블을 생성하시오.
CREATE TABLE MS_REPLY (

      REPLY_NO    NUMBER      NOT NULL PRIMARY KEY ,
      BOARD_NO    NUMBER      NOT NULL ,
      CONTENT     VARCHAR2(2000)    NOT NULL ,
      WRITER      VARCHAR2(100)    NOT NULL ,
      DEL_YN      CHAR(2)     DEFAULT 'N' NULL ,
      DEL_DATE    DATE        NULL ,
      REG_DATE    DATE        DEFAULT sysdate NOT NULL ,
      UPD_DATE    DATE        DEFAULT sysdate NOT NULL 
);

COMMENT ON TABLE MS_REPLY IS '댓글';
COMMENT ON COLUMN MS_REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN MS_REPLY.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_REPLY.CONTENT IS '내용';
COMMENT ON COLUMN MS_REPLY.WRITER IS '작성자';
COMMENT ON COLUMN MS_REPLY.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_REPLY.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_REPLY.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_REPLY.UPD_DATE IS '수정일자';


-- 70.

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER human IDENTIFIED BY 123456;
ALTER USER human QUOTA UNLIMITED ON users;
GRANT DBA TO human;

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER human2 IDENTIFIED BY 123456;
ALTER USER human2 QUOTA UNLIMITED ON users;
GRANT DBA TO human2;


-- community.dmp 를 human 계정으로 가져오기 (cmd)
imp userid=system/123456 file=C:\LSY\ORACLE\community.dmp fromuser=human touser=human

-- human.dmp 를 human2 계정으로 가져오기 (cmd)
imp userid=system/123456 file=C:\LSY\ORACLE\human.dmp fromuser=human touser=human2

-- 71.
-- human 계정이 소유하고 있는 데이터를
-- "human_exp.dmp" 덤프파일로 export 하는 명령어를 작성하시오

-- human_exp.dmp 덤프파일 생성하기 (cmd)
exp userid=human/123456 file=C:\LSY\ORACLE\human_exp.dmp log=C:\LSY\ORACLE\human_exp.log

-- 72.
-- MS_BOARD의 WRITER 속성을 NUMBER 타입을 변경하고
-- MS_USER 의 USER_NO 를 참조하는 외래키를 지정하는 SQL 문을 작성하시오

-- 1)
-- 데이터 타입 변경
ALTER TABLE MS_BOARD MODIFY WRITER NUMBER;

-- 외래키 지정
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명
-- FOREIGN KEY (외래키컬럼) REFERENCES 참조테이블(기본키);
ALTER TABLE MS_BOARD ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY (WRITER) REFERENCES MS_USER (USER_NO);

-- 2) 외래키 : MS_FILE ( BOARD_NO ) ---> MS_BOARD ( BOARD_NO )
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD (BOARD_NO);

-- 3) 외래키 : MS_REPLY ( BOARD_NO ) ---> MS_BOARD ( BOARD_NO )
ALTER TABLE MS_REPLY ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD (BOARD_NO);


-- 제약조건 삭제
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;

-- 73.
-- MS_USER 테이블에 속성을 추가하시오
ALTER TABLE MS_USER ADD CTZ_NO CHAR(14) NOT NULL UNIQUE;
ALTER TABLE MS_USER ADD GENDER CHAR(6) NOT NULL;

COMMENT ON COLUMN MS_USER.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_USER.GENDER IS '성별';

DESC MS_USER;


-- 74.
-- MS_USER 의 GENDER 속성이 ('여', '남', '기타') 값만 갖도록 제약조건을 추가하시오
ALTER TABLE MS_USER
ADD CONSTRAINT MS_USER_GENDER_CHECK
CHECK ( gender IN ('여', '남', '기타') )
;

-- 75.
-- MS_FILE 테이블에 확장자 (EXT) 속성을 추가하시오
ALTER TABLE MS_FILE ADD EXT VARCHAR2(10) NULL;
COMMENT ON COLUMN MS_FILE.EXT IS '확장자';

-- 76.
--
MERGE INTO MS_FILE T                    -- 대상 테이블 지정
-- 사용할 데이터의 자원을 지정
USING ( SELECT FILE_NO, FILE_NAME FROM MS_FILE ) F
-- ON (update 될 조건)
ON (T.FILE_NO = F.FILE_NO)
-- 매치조건에 만족한 경우
WHEN MATCHED THEN
        -- SUBSTR (문자열, 시작번호 )
        -- ex. SUBSTR ( '/upload/강아지.png', 12 ) --> png
        UPDATE SET T.EXT = SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) +1)
        DELETE WHERE SUBSTR (F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) +1)
                        NOT IN ('jpeg', 'jpg', 'gif', 'png')
-- WHEN NOT MATCHED THEN
-- [매치가 안 될 때,]
;

-- 파일 추가
INSERT INTO MS_FILE (
                 FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
VALUES ( 1, 1, '강아지.png', '123', sysdate, sysdate, 'jpg' );

INSERT INTO MS_FILE (
                 FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT)
VALUES ( 2, 1, 'main.html', '123', sysdate, sysdate, 'jpg' );

-- 게시글 추가
INSERT INTO MS_BOARD (
                  BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT, DEL_YN, DEL_DATE, REG_DATE, UPD_DATE)
VALUES ( 1, '제목', '내용', 1, 0, 0, 'N', NULL, sysdate, sysdate );

-- 유저 추가
INSERT INTO MS_USER (
                  USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH, TEL, ADDRESS, REG_DATE, UPD_DATE, CTZ_NO, GENDER )
VALUES ( 1, 'ALOHA', '123456', '김휴먼', TO_DATE('2003/01/01', 'YYYY/MM/DD'), '010-1234-1234', '영등포', sysdate, sysdate, '030101-3334444', '기타');

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;

-- 77.
-- 테이블 MS_FILE 의 EXT 속성이 ('jpg', 'jpeg', 'gif', 'png') 값을 갖도록 하는 제약조건을 추가하시오

ALTER TABLE MS_FILE
ADD CONSTRAINT MS_FILE_EXT_CHECK
CHECK (EXT IN('jpg', 'jpeg', 'gif', 'png'));

ALTER TABLE MS_FILE
DROP CONSTRAINT MS_FILE_EXT_CHECK;

-- 78.
-- MS_USER, MS_BOARD, MS_FILE, MS_REPLY 테이블의 모든 데이터를 삭제하는 명령어를 작성하시오
TRUNCATE TABLE MS_USER;
TRUNCATE TABLE MS_BOARD;
TRUNCATE TABLE MS_FILE;
TRUNCATE TABLE MS_REPLY;

DELETE FROM MS_USER;
DELETE FROM MS_BOARD;
DELETE FROM MS_FILE;
DELETE FROM MS_REPLY;

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;
SELECT * FROM MS_REPLY;

-- DDL, DML, DCL

-- DELETE vs TRUNCATE
-- * DELETE - 데이터 조작어(DML)
--   - 한 행 단위로 데이터를 삭제한다
--   - COMMIT, ROLLABCK 를 이용하여 변경사항을 적용하거나 되돌릴 수 있음

-- * TRUNCATE - 데이터 정의어 (DDL)
--   - 모든 행을 삭제한다
--   - 삭제된 데이터를 되돌릴 수 없음

-- 79.
-- 테이블의 속성을 삭제하시오
-- * MS_BOARD 테이블의 WRITER 속성
-- * MS_FILE 테이블의 BOARD_NO 속성
-- * MS_REPLY 테이블의 BOARD_NO 속성
ALTER TABLE MS_BOARD DROP COLUMN WRITER;
ALTER TABLE MS_FILE DROP COLUMN BOARD_NO;
ALTER TABLE MS_REPLY DROP COLUMN BOARD_NO;

-- 80.
-- 각 테이블에 속성들을 추가한 뒤, 외래키로 지정하시오
-- 해당 외래키에 대하여 참조 테이블의 데이터 삭제 시,
-- 연결된 속성의 값도 삭제하는 옵션도 지정하시오

-- 1)
-- MS_BOARD 에 WRITER 속성 추가
ALTER TABLE MS_BOARD ADD WRITER NUMBER NOT NULL;

-- WRITER 속성을 외래키로 지정
-- + 참조 테이블 데이터 삭제 시, 연쇄적으로 함께 삭제하는 옵션 지정
ALTER TABLE MS_BOARD
ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY (WRITER) REFERENCES MS_USER (USER_NO)
ON DELETE CASCADE;
-- ON DELETE [NO ACTION, RESTRICT, CASCADE, SET NULL]
-- * RESTRICT : 자식 테이블의 데이터가 존재하면, 삭제 안 함
-- * CASCADE : 자식 테이블의 데이터도 함께 삭제
-- * SET NULL : 자식 테이블의 데이터를 NULL 로 지정

-- 2)
-- MS_FILE 에 BOARD_NO 속성 추가
ALTER TABLE MS_FILE ADD BOARD_NO NUMBER NOT NULL;

-- BOARD_NO 속성을 외래키로 추가
-- + 참조 테이블 데이터 삭제 시, 연쇄적으로 함께 삭제하는 옵션 지정
ALTER TABLE MS_FILE
ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD (BOARD_NO)
ON DELETE CASCADE;

-- 3)
-- MS_REPLY 에 BOARD_NO 속성 추가
ALTER TABLE MS_REPLY ADD BOARD_NO NUMBER NOT NULL;

-- BOARD_NO 속성을 외래키로 추가
-- 참조 테이블 : MS_BOARD, 참조 속성 : BOARD_NO
-- + 참조 테이블 데이터 삭제 시, 연쇄적으로 함께 삭제하는 옵션 지정
ALTER TABLE MS_REPLY
ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD (BOARD_NO)
ON DELETE CASCADE;

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;
SELECT * FROM MS_REPLY;
SELECT * FROM MS_FILE;

-- 회원탈퇴 (회원번호:1)
DELETE FROM MS_USER WHERE USER_NO = 1;

-- ON DELETE CASCADE 옵션으로 외래키 지정 시,
-- MS_USER 의 데이터를 삭제하면, 
-- MS-BOARD 의 참조된 데이터도 연쇄적으로 삭제된다

-- MS_BOARD 의 데이터가 삭제되면,
-- MS_FILE 의 참조된 데이터도 연쇄적으로 삭제된다

-- 외래키 제약조건 정리
ALTER TABLE 테이블명
ADD CONSTRAINT 제약조건명 FOREIGN KEY (외래키 속성)
REFERENCES 참조테이블 (참조 속성);
-- 옵션
-- ON UPDATE                -- 참조 테이블 수정 시,
-- * CASCADE                 : 자식 데이터 수정
-- * SET NULL                 : 자식 데이터는 NULL
-- * SET DEFAULT             : 자식 데이터는 기본값
-- * RESTRICT                  : 자식 테이블의 참조하는 데이터가 존재하면, 부모 데이터 수정 불가
-- * NO ACTION              : 아무런 행위도 취하지 않는다 (기본값)

-- ON DELETE                -- 참조 테이블 삭제 시,
-- * CASCADE                 : 자식 데이터 삭제
-- * SET NULL                 : 자식 데이터는 NULL
-- * SET DEFAULT             : 자식 데이터는 기본값
-- * RESTRICT                  : 자식 테이블의 참조하는 데이터가 존재하면, 부모 데이터 삭제 불가
-- * NO ACTION              : 아무런 행위도 취하지 않는다 (기본값)

-- 81.
-- ▶ 서브쿼리
/* 
    : SQL 문 내부에 사용하는 SELECT 문
    * 메인쿼리 : 서브쿼리를 사용하는 최종적인 SELECT 문
    
    * 서브쿼리 종류
    - 스칼라 서브쿼리      : SELECT 절에서 사용하는 서브쿼리
    - 인라인 뷰              : FROM 절에서 사용하는 서브쿼리
    - 서브 쿼리              : WHERE 절에서 사용하는 서브쿼리
*/

-- 81
-- EMPLOYEE, DEPARTMENT, JOB 테이블을 사용하여
-- 스칼라 서브쿼리로 출력결과와 같이 조회하시오
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM job;

SELECT emp_id AS 사원번호
         ,emp_name AS 직원명
         ,(SELECT dept_title FROM department d WHERE d.dept_id = e.dept_code) 부서명
         ,(SELECT job_name FROM job j WHERE j.job_code = e.job_code) 직급명
FROM employee e;

-- JOIN
-- INNER JOIN(내부조인)
SELECT e.emp_id 사원번호
         ,e.emp_name 직원명
         ,d.dept_title 부서명
         ,j.job_name 직급명
FROM employee e
        JOIN department d ON e.dept_code = d.dept_id
        JOIN job j ON e.job_code = j.job_code
;
        
-- EQUI JOIN
SELECT e.emp_id 사원번호
         ,e.emp_name 직원명
         ,d.dept_title 부서명
         ,j.job_name 직급명
FROM employee e, department d, job j
WHERE e.dept_code = d.dept_id
   AND e.job_code = j.job_code
;

-- 82. 
-- 출력결과를 참고하여 ,
-- 인라인 뷰를 이용해 부서별로 최고급여를 받는 직원을 조회하시오.

-- 1. 부서별로 최고급여를 조회
SELECT ,dept_code              -- emp_id 사용불가 
        ,MAX(salary) MAX_SAL
        ,MIN(salary) MIN_SAL
        ,AVG(salary) AVG_SAL
FROM employee
GROUP BY dept_code
;

-- 2. 부서별 최고급여 조회결과를 서브쿼리 (인라인 뷰) 로 지정
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,e.salary 급여
      ,t.max_sal 최고급여
      ,t.min_sal 최저급여
      ,t.avg_sal 평균급여 
      ,ROUND(t.avg_sal, 2) 평균급여 
FROM employee e, department d,
    (SELECT ,dept_code  
        ,MAX(salary) MAX_SAL
        ,MIN(salary) MIN_SAL
        ,AVG(salary) AVG_SAL
    FROM employee
    GROUP BY dept_code ) t 
WHERE e,dept_code = d,dept_id
    AND e.salary  = t.max_sal;
    
-- 83.
-- 서브쿼리를 사용하여,
-- 직원명이 '이태림' 인 사원과 같음 부서 직원들을 조회하시오.
SELECT.emp_id 사원번호
      .emp_name 직원명
      .email 이메일
      .phone 전화번호
FROM employee
WHERE dept_code = ( 
                    SELECT dept_code
                    FROM employee
                    WHERE emp_name = '이래림'
                    )
      
SELECT *FROM employee WHERE emp_name '이태림' ;

SELECT *FROM employee WHERE emp_name 'D8';

-- 84. 
-- 사원 테이블에 존재하는 부서코드만 포함하는 부서를 조회하시오
-- (사원이 존재하는 부서만 조회하시오.)
SELECT dept_id FROM department; -- D1~D9 
SELECT DISTINCT dept_code FROM employee; -- D1, D2,D5,D6,D8,D9
-- 사원이없는부서 : D3,D4,D7

-- 
SELECT dept_id 부서번호
       ,dept_title 부서명
       ,location_id 지역멍
FROM department
WHERE dept_id IN( 
                SELECT DISTINCT dept_code
                FORM employee
                WHERE dept_code IS NOT NULL
                )
ORDER BY dept_id ASC 
;


-- 2) EXISTS
SELECT dept_id 부서번호
       ,dept_title 부서명
       ,location_id 지역멍
FROM department d
WHERE EXISTS ( SELECT * FROM employee e WHERE e.dept_code = d.dept_id )
ORDER BY dept_id ASC
;


-- 85. 
-- 사원 테이블에 존재하지않는 부서코드만 포함하는 부서를 조회하시오
-- (사원이 존재하지않는 부서만 조회하시오.)
SELECT dept_id FROM department; -- D1~D9 
SELECT DISTINCT dept_code FROM employee; -- D1, D2,D5,D6,D8,D9
-- 사원이없는부서 : D3,D4,D7

-- 
SELECT dept_id 부서번호
       ,dept_title 부서명
       ,location_id 지역멍
FROM department
WHERE dept_id NOT IN( 
                SELECT DISTINCT dept_code
                FORM employee
                WHERE dept_code IS NOT NULL
                )
ORDER BY dept_id ASC 
;


-- 2) EXISTS
SELECT dept_id 부서번호
       ,dept_title 부서명
       ,location_id 지역멍
FROM department d
WHERE NOT EXISTS ( SELECT * FROM employee e WHERE e.dept_code = d.dept_id )
ORDER BY dept_id ASC
;

-- 86. 
SELECT   e.emp_id 사원번호
        ,e.emp_name 직원명
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,e.salray 급여 
FROM employee e, department d   ;


-- 86. 급여 사원 
SELECT *
FROM employee, department -- 23x9 =207
;

SELECT *FROM employee;      -- 23건
SELECT *FROM department      -- 9건 
;

SELECT e.emp_id 사원번호
        ,e.emp_name 직원명 
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,e.salray   급여
        
FORM employee e, department d
WHERE (e.dept_code = d.dept_id) -- 가장중요

-- 1. 부서코드가 'D1'인 사원의 최대급여 
SELECT MAX (salary)
FROM employee 
WHERE dept_code = "D1" ;


-- 2 급여가 366000 보다 큰사원 조회

SELECT e.emp_id 사원번호
        ,e.emp_name 직원명 
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,e.salray   급여
        
FORM employee e, department d
WHERE (e.dept_code = d.dept_id)
    AND e.salary >366000
    ;

--3 366000 자리에 1번을 서브쿼리로 변경
SELECT e.emp_id 사원번호
        ,e.emp_name 직원명 
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,TO_CHAR (e.salray, '999 ,999 ,999')   급여
        
FORM employee e, department d
WHERE e.dept_code = d.dept_id
AND   e.salray > ALL ( 
                    SELECT MAX (salray) 
                    FROM employee
                    WHERE dept_code = 'D1';
                 
                    
--2) 
SELECT e.emp_id 사원번호
        ,e.emp_name 직원명 
        ,d.dept_id 부서번호
        ,d.dept_title 부서명
        ,TO_CHAR(e.salary,'999,999,999') 급여

FORM employee e, department d
WHERE e.dept_code = d.dept_id)


-- 87.
--EMPLOYEE 테이블의 DEPT_CODE 가 'D9' 인 부서의 최저급여 보다
-- 더큰 급여를 받는 사원을 조회하시오.

-- 1) 
-- 1. DEPT_CODE 가 'D9' 인 부서의 최저급여
SELECT MIN(SALARY)
FROM EMPLOYEE
WHERE dept_code = 'D9';

--2. 급여 > 최저급여
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,TO_CHAR(e.salary,'999,999,999') 급여      
FORM employee e, 
department d
WHERE e.dept_code = d.dept_id
AND   e.salray > ALL ( 
                    SELECT MAX (salray) 
                    FROM employee
                    WHERE dept_code = 'D9'
)
;

-- 2) 
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,TO_CHAR(e.salary,'999,999,999') 급여      
FORM employee e, 
department d
WHERE e.dept_code = d.dept_id
 AND e.salary > ANY ( 
                        SELECT SALARY
                        FROM employee
                        WHERE dept_code = 'D9'
                        )


-- 88 SELECT
-- EMPLOYEE 외 DEPARTMENT 테이브를 조인하여 , 출력하되,
-- 부서가 없는 직원도 포함하여 출력하시오

SELECT*
 e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명

FROM EMPLOYEE e
 LEFT JOIN DEPARTMENT d
 ON (e.dept_code = d.defet_)

-- 89.
-- EMPLOYEE 와 DEPARTMENT 테이블을 조인하여 출력하되,
-- 직원이 없는 부서도 포함하여 출력하시오.

SELECT*
 e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명

FROM EMPLOYEE e
 RIGHT JOIN DEPARTMENT d
 ON (e.dept_code = d.defet_);

 --NUll 나오는 데이터  : 사원이 없는 부서 
 
 -- 90.
 -- 직원 및 부서 유무에 상관없이 출력하는 SQL문을 작성하시오
 
 SELECT NVL ( e.emp_id, '(없음)') 사원번호
          ,NVL ( e.emp_name, '(없음)') 직원명
          ,NVL ( d.dept_id, '(없음)') 부서번호
          ,NVL ( d.dept_title, '(없음)') 부서명
FROM employee e
          FULL JOIN department d
          ON ( e.dept_code = d.dept_id)
;

-- 91.
-- 사원번호, 직원명, 부서번호, 지역명, 국가명, 급여, 입사일자를 출력하시오
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM location;
SELECT * FROM national;

SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,l.local_name 지역명
FROM employee e
      LEFT JOIN department d ON e.dept_code = d.dept_id
      LEFT JOIN location l ON d.location_id = l.local_code
      LEFT JOIN national n ON l.national_code = n.national_code
      ;

-- 92.
-- 사원들 중 매니저를 출력하시오
-- 사원번호, 직원명, 부서명, 직급, 구분 ('매니저')

-- 1.
-- manager_id 컬럼이 NULL 이 아닌 사원을 중복없이 조회
-- 매니저들의 사원 번호
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEES
WHERE manager_id IS NOT NULL;

-- 2.
-- employee, department, job 테이블을 조인하여 조회
SELECT *
FROM employee e
       LEFT JOIN department d ON e.dept_code = d.dept_id
       JOIN job j ON e.job_code = j.job_code
;

-- 3.
-- 조인 결과 중, emp_id 가 매니저 사원번호인 경우만을 조회

SELECT e.emp_id 사원번호
         ,e.emp_name 직원명
         ,d.dept_title 부서명
         ,j.job_name 직급
         ,'매니저' 구분
FROM employee e
       LEFT JOIN department d ON e.dept_code = d.dept_id
       JOIN job j ON e.job_code = j.job_code
WHERE emp_id IN ( 
                        SELECT DISTINCT MANAGER_ID
                        FROM employee
                        WHERE manager_id IS NOT NULL
                        )
;

-- 93.
-- 사원(매니저가 아닌)만 조회하시오
SELECT e.emp_id 사원번호
         ,e.emp_name 직원명
         ,d.dept_title 부서명
         ,j.job_name 직급
         ,'사원' 구분
FROM employee e
       LEFT JOIN department d ON e.dept_code = d.dept_id
       JOIN job j ON e.job_code = j.job_code
WHERE emp_id NOT IN ( 
                              SELECT DISTINCT MANAGER_ID
                              FROM employee
                              WHERE manager_id IS NOT NULL
                               )
;


-- 94.
-- UNION 키워드를 사용하여,
-- 매니저와 사원 구분하여 조회하시오
SELECT e.emp_id 사원번호
         ,e.emp_name 직원명
         ,d.dept_title 부서명
         ,j.job_name 직급
         ,'매니저' 구분
FROM employee e
       LEFT JOIN department d ON e.dept_code = d.dept_id
       JOIN job j ON e.job_code = j.job_code
WHERE emp_id IN ( 
                        SELECT DISTINCT MANAGER_ID
                        FROM employee
                        WHERE manager_id IS NOT NULL
                        )
UNION
SELECT e.emp_id 사원번호
         ,e.emp_name 직원명
         ,d.dept_title 부서명
         ,j.job_name 직급
         ,'사원' 구분
FROM employee e
       LEFT JOIN department d ON e.dept_code = d.dept_id
       JOIN job j ON e.job_code = j.job_code
WHERE emp_id NOT IN ( 
                              SELECT DISTINCT MANAGER_ID
                              FROM employee
                              WHERE manager_id IS NOT NULL
                               )
;


-- 95.
-- CASE 키워드를 사용하여,
-- 매니저와 사원을 구분하여 출력하시오
SELECT e.emp_id 사원번호
         ,e.emp_name 직원명
         ,d.dept_title 부서명
         ,j.job_name 직급
         --
         , CASE
                WHEN emp_id IN (
                                        SELECT DISTINCT manager_id
                                        FROM employee
                                        WHERE manager_id IS NOT NULL
                                        )
                THEN '매니저'
                ELSE  '사원'
            END 구분
FROM employee e
         LEFT JOIN department d ON e.dept_code = d.dept_id
         JOIN job j ON e.job_code = j.job_code
;


-- 96.
-- EMPLOYEE, DEPARTMENT, JOB 테이블을 조인하여 조회하시오
-- 사원의 나이와 성별을 구하여 출력하고,
-- 주민등록번호 뒷자리 첫글자를 제외하고 마스킹하여 출력하시오

SELECT e.emp_id 사원번호
         ,e.emp_name 직원명
         ,d.dept_title 부서명
         ,j.job_name 직급명
         ,CASE
                WHEN emp_id IN (
                                        SELECT DISTINCT manager_id
                                        FROM employee
                                        WHERE manager_id IS NOT NULL
                                        )
                THEN '매니저'
                ELSE '사원'
          END 구분
          
          -- 성별
          -- 1, 3 (남자), 2, 4 (여자)
          ,CASE
                    WHEN SUBSTR (emp_no, 8, 1) IN ('1', '3') THEN '남자'
                    WHEN SUBSTR (emp_no, 8, 1) IN ('2', '4') THEN '여자'
           END 성별
           
          -- 나이
          ,TO_CHAR (sysdate, 'YYYY')
          -
          ( CASE
                 -- 1900년대 출생
                 WHEN SUBSTR (emp_no, 8, 1) IN ('1', '2') THEN '19'
                 -- 2000년대 출생
                WHEN SUBSTR (emp_no, 8, 1) IN ('3', '4') THEN '20'
            END || SUBSTR(emp_no, 1, 2) +1 ) 나이
          
          -- 주민등록번호(마스킹)
          -- 861015-1356452 (14자리)
          ,RPAD ( SUBSTR (emp_no, 1, 8), 14, '*') 주민등록번호
          
FROM employee e
         LEFT JOIN department d ON e.dept_code = d.dept_id
         JOIN job j USING ( job_code )
;
-- USING : 조인하고자 하는 두 테이블의 컬럼명이 같으면,
--            ON 키워드 대신 조인 조건을 간단하게 작성하는 키워드

-- 주민등록번호 뒷자리 첫글자 가져오기
SELECT SUBSTR (emp_no, 8, 1)
FROM employee;

-- 주민등록번호에서 출생년도 추출하기
-- 1985.05.04 --> 850504 -- 뒷 첫글자 1, 2
-- 2002.10.06 --> 021006 -- 뒷 첫글자 3, 4

-- 현재연도 - 출생연도 + 1 = 나이
SELECT emp_name,
    CASE
            -- 1900년대 출생
            WHEN SUBSTR (emp_no, 8, 1) IN ('1', '2') THEN '19'
            -- 2000년대 출생
            WHEN SUBSTR (emp_no, 8, 1) IN ('3', '4') THEN '20'
    END || SUBSTR(emp_no, 1, 2) 출생년도
            -- 1985, 2002
FROM employee;

-- 현재연도 구하기
SELECT TO_CHAR (sysdate, 'YYYY') 현재연도
FROM dual;

-- 나이 구하기
-- 현재연도 - 출생연도 + 1 = 나이
SELECT emp_name,
    TO_CHAR (sysdate, 'YYYY')
    -
     ( CASE
         -- 1900년대 출생
         WHEN SUBSTR (emp_no, 8, 1) IN ('1', '2') THEN '19'
         -- 2000년대 출생
         WHEN SUBSTR (emp_no, 8, 1) IN ('3', '4') THEN '20'
      END || SUBSTR(emp_no, 1, 2) + 1) 나이
      -- 1985, 2002
FROM employee;

-- 만 나이 구하기
SELECT emp_name, "만 나이"
FROM employee;
-- 
SELECT  TRUNC(MONTHS_BETWEEN( sysdate, TO_DATE(
                        CASE 
                              WHEN SUBSTR(emp_no, 8, 1) IN ('1','2') THEN '19'
                              WHEN SUBSTR(emp_no, 8, 1) IN ('3','4') THEN '20'
                        END || SUBSTR(emp_no, 1, 6) , 'YYYYMMDD' ) ) / 12 )  만나이
FROM employee;


-- 97.
-- 96번 조회결과에
-- 순번, 만 나이, 근속연수, 입사일자, 연봉 추가하시오    
SELECT ROWNUM 순번
      ,e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급명
      , CASE
            WHEN emp_id IN (
                              SELECT DISTINCT manager_id 
                              FROM employee
                              WHERE manager_id IS NOT NULL
                           )
            THEN '매니저'
            ELSE '사원'
        END 구분
        
      -- 성별 (주민등록번호 뒷자리 첫글자)
      -- 1,3(남자), 2,4(여자)
      , CASE
            WHEN SUBSTR(emp_no, 8, 1) IN ('1','3') THEN '남자'
            WHEN SUBSTR(emp_no, 8, 1) IN ('2','4') THEN '여자'
        END 성별
        
      -- 나이
      ,TO_CHAR(sysdate, 'YYYY')
      -
      ( CASE 
            -- 1900년대 출생
            WHEN SUBSTR(emp_no, 8, 1) IN ('1','2') THEN '19'
            -- 2000년대 출생
            WHEN SUBSTR(emp_no, 8, 1) IN ('3','4') THEN '20'
      END || SUBSTR(emp_no, 1, 2) ) + 1 현재나이     
      
      -- 만 나이
      ,TRUNC(
            MONTHS_BETWEEN( sysdate, 
                  TO_DATE(
                        CASE 
                              WHEN SUBSTR(emp_no, 8, 1) IN ('1','2') THEN '19'
                              WHEN SUBSTR(emp_no, 8, 1) IN ('3','4') THEN '20'
                        END || SUBSTR(emp_no, 1, 6) , 'YYYYMMDD'  ) ) / 12 )  만나이 
            
      -- 근속연수 : 현재일자-입사일자 [연도]
      ,TRUNC ( MONTHS_BETWEEN ( sysdate, hire_date ) / 12 ) 근속연수
      
      -- 주민번호(마스킹)
      ,RPAD( SUBSTR(emp_no, 1, 8), 14, '*' ) 주민등록번호
      
      -- 입사일자
      ,TO_CHAR( hire_date, 'YYYY.MM.DD') 입사일자
      
      -- 연봉 : (급여 + (급여*보너스)) * 12
      ,TO_CHAR( ( salary + NVL( (salary*bonus), 0) ) * 12, '999,999,999,999' ) 연봉
      
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
;
 
SELECT * FROM employee;

-- 뷰 생성하기
-- 사원, 부서 테이블 조인 조회한 결과를 뷰로 생성
-- 1. 사원, 부서 테이블 조인
SELECT e.emp_id
         ,e.emp_name
         ,d.dept_id
         ,d.dept_title
FROM employee e
         LEFT JOIN department d
         ON e.dept_code = d.dept_id
;

-- 2. 뷰 생성
CREATE VIEW v_emp_dept AS
SELECT e.emp_id
         ,e.emp_name
         ,d.dept_id
         ,d.dept_title
FROM employee e
         LEFT JOIN department d
         ON e.dept_code = d.dept_id
;

SELECT * FROM v_emp_dept;

-- 뷰 삭제
DROP VIEW v_emp_dept;


-- 98.
-- employee, department 테이블을 조인하여,
-- 사원번호, 직원명, 부서번호, 부서명, 이메일, 전화번호,
-- 주민번호, 입사일자, 급여, 연봉을 조회하시오

-- CREATE OR REPLACE 객체
-- - 없으면, 새로 생성
-- - 있으면, 대체 (기존에 생성되어 있어도 에러발생 X)
CREATE OR REPLACE VIEW ve_emp_dept AS
SELECT e.emp_id
         ,e.emp_name
         ,d.dept_id
         ,d.dept_title
         ,e.email
         ,e.phone
         -- 주민등록번호
         ,RPAD( SUBSTR ( emp_no, 1, 8 ), 14, '*' ) emp_no
         
         -- 입상일자
         ,TO_CHAR ( hire_date, 'YYYY.MM.DD' ) hire_date
         
         -- 급여
         ,TO_CHAR ( salary, '999,999,999' ) salary
         
         -- 연봉
         ,TO_CHAR ( (salary + NVL (salary * bonus, 0 ) ) * 12, '999,999,999,999' ) yr_salary
FROM employee e
         LEFT JOIN department d ON (e.dept_code = d.dept_id)
;

SELECT *
FROM ve_emp_dept;


-- 시퀀스 생성
/*
        CREATE SEQUENCE 시퀀스명
        INCREMENT BY 증감숫자
        START WITH 시작숫자
        MINVALUE 최소값
        MAXVALUE 최대값;
*/
-- 예시
CREATE SEQUENCE my_seq
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 10000;

-- 현재 순번
SELECT my_seq.currval FROM dual;

-- 다음 순번
SELECT my_seq.nextval FROM dual;

-- 시퀀스 삭제
DROP SEQUENCE my_seq;


-- 99.
-- 시퀀스를 생성하시오
CREATE SEQUENCE SEQ_MS_USER
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000000;

CREATE SEQUENCE SEQ_MS_BOARD
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000000;

CREATE SEQUENCE SEQ_MS_FILE
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000000;

CREATE SEQUENCE SEQ_MS_REPLY
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000000;


-- 100.
-- SEQ_MS_USER 의 다음 번호와 현재 번호를 출력하시오
SELECT SEQ_MS_USER.currval FROM dual;
SELECT SEQ_MS_USER.nextval FROM dual;

-- 101.
-- SEQ_MS_USER 를 삭제하시오
DROP SEQUENCE SEQ_MS_USER;

-- 102.
-- SEQ_MS_USER 를 이용하여, MS_USER 의 user_no 가
-- 시퀀스 번호로 적용될 수 있도록 데이터를 추가해보시오
TRUNCATE TABLE MS_USER;

INSERT INTO MS_USER(user_no, user_id, user_pw, user_name, birth, tel, address, reg_date, upd_date, ctz_no, gender)
VALUES (
            SEQ_MS_USER.nextval, 'human', '123456', '김휴먼', '2002/01/01', '010-1234-5678', '서울 영등포', sysdate, sysdate, '020101-1234567', '남'
            );
            
INSERT INTO MS_USER(user_no, user_id, user_pw, user_name, birth, tel, address, reg_date, upd_date, ctz_no, gender)
VALUES (
            SEQ_MS_USER.nextval, 'human2', '123456', '박휴먼', '2002/01/01', '010-1211-5238', '서울 강남', sysdate, sysdate, '130101-2223333', '여'
            );       
SELECT * FROM ms_user;


-- 103.
-- 시퀀스 SEQ_MS_USER의 최대값을 100,000,000으로 수정하시오
ALTER SEQUENCE SEQ_MS_USER MAXVALUE 100000000;

-- 104.
-- USER_IND_COLUMNS 테이블을 조회하시오
-- * 사용자가 정의한 인덱스 정보가 들어있다
SELECT index_name, table_name, column_name
FROM user_ind_columns;

-- 105.
-- MS_USER 테이블의 USER_NAME 에 대한
-- 인덱스 IDX_MS_USER_NAME을 생성하시오

-- 인덱스 생성
CREATE INDEX IDX_MS_USER_NAME ON MS_USER(user_name);

-- 인덱스 삭제
DROP INDEX IDX_MS_USER_NAME;


-- 추가 실습
-- COALESCE ( )
SELECT employee_id 사원번호
         ,first_name  이름
         ,COALESCE ( salary * commission_pct, salary ) 최종급여
         ,commission_pct
FROM employees;

-- LNNVL (조건식) <hr>
-- TRUE --> FALSE
-- FALSE, NULL --> TRUE
-- LNNVL 과 NVL 은 반대
SELECT employee_id, commission_pct
FROM employees
WHERE LNNVL ( commission_pct >= 0.2 );

SELECT employee_id, commission_pct
FROM employees
WHERE NVL ( commission_pct, 0 ) < 0.2;

SELECT employee_id, commission_pct
FROM employees
WHERE commission_pct <= 0.2 ;

-- NULLIF ( )
SELECT employee_id
         ,TO_CHAR ( start_date, 'YYYY' ) start_year
         ,TO_CHAR ( end_date, 'YYYY' ) end_year
         ,NULLIF ( TO_CHAR ( end_date, 'YYYY' ), TO_CHAR ( start_date, 'YYYY' ) )
FROM job_history;    

-- 그룹 관련 함수 <human2>
-- ROLLUP
-- 부서별, 직급별 급여 최대값, 합계, 평균
-- * ROLLUP 미사용
SELECT dept_code, job_code
         ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2 )
FROM employee
GROUP BY dept_code, job_code
ORDER BY dept_code, job_code
;

-- * ROLLUP 사용
-- 그룹 기준으로 집계한 결과와 추가적으로 총 집계 정보 출력하는 함수
SELECT dept_code, job_code
         ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2 )
FROM employee
WHERE dept_code IS NOT NULL
   AND job_code IS NOT NULL
GROUP BY ROLLUP (dept_code, job_code)
ORDER BY dept_code, job_code
;

-- CUBE
SELECT dept_code, job_code
         ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2 )
FROM employee
WHERE dept_code IS NOT NULL
   AND job_code IS NOT NULL
GROUP BY CUBE (dept_code, job_code)
ORDER BY dept_code, job_code
;

-- GROUPING SETS ( )
-- 각각 부서별, 직급별 별도로 인원수
SELECT dept_code, job_code, COUNT (*)
FROM employee
GROUP BY GROUPING SETS ( (dept_code), (job_code) )
ORDER BY dept_code, job_code
;

-- 특정 부서의 직급별 인원 수
SELECT dept_code, job_code, COUNT (*)
FROM employee
GROUP BY dept_code, job_code
ORDER BY dept_code, job_code
;

-- GROUPING
SELECT dept_code, job_code
         ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2 )
         ,GROUPING(dept_code) "부서코드 그룹여부"
         ,GROUPING(job_code) "직급코드 그룹여부"
FROM employee
WHERE dept_code IS NOT NULL
   AND job_code IS NOT NULL
GROUP BY CUBE (dept_code, job_code)
ORDER BY dept_code, job_code
;

-- LISTAGG
SELECT dept_code 부서코드
         ,LISTAGG ( emp_name, ', ' )
         WITHIN GROUP ( ORDER BY emp_name ) "부서별 사원이름 목록"
FROM employee
GROUP BY dept_code
ORDER BY dept_code
;

-- PIVOT
-- 직급을 행에 표시, 부서는 열에 그룹화하여 최고급여를 출력하시오
SELECT *
FROM (
            SELECT dept_code, job_code, salary
            FROM employee
        )
        PIVOT (
            MAX ( salary )
            -- 열에 올릴 컬럼들
            FOR dept_code IN ( 'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9' )
            /* 
                    SELECT LISTAGG ( dept_id, ',' )
                    FROM department
            */        
        )
ORDER BY job_code
;

-- UNPIVOT

SELECT *
FROM (
            SELECT dept_code
                     ,MAX ( DECODE ( job_code, 'J1', salary ) ) J1
                     ,MAX ( DECODE ( job_code, 'J2', salary ) ) J2
                     ,MAX ( DECODE ( job_code, 'J3', salary ) ) J3
                     ,MAX ( DECODE ( job_code, 'J4', salary ) ) J4
                     ,MAX ( DECODE ( job_code, 'J5', salary ) ) J5
                     ,MAX ( DECODE ( job_code, 'J6', salary ) ) J6
                     ,MAX ( DECODE ( job_code, 'J7', salary ) ) J7
            FROM employee
            GROUP BY dept_code
            ORDER BY dept_code
        )
        UNPIVOT (
                        salary
                        FOR job_code IN ( J1, J2, J3, J4, J5, J6, J7 )
                      )
; 


-- 기타 함수
-- GREATEST ( )
-- LEAST ( )
-- 인자 : 표현식
SELECT GREATEST ( 1, 2, 3, 4, 5 ) "가장 큰 값"
         ,LEAST ( 1, 2, 3, 4, 5 ) "가장 작은 값"
FROM dual;

SELECT GREATEST ( '김휴먼', '박휴먼', '홍휴먼' ) "사준 순 마지막"
         ,LEAST ( '김휴먼', '박휴먼', '홍휴먼' ) "사준 순 처음"
FROM dual;


-- 조인
-- * 내부 조인
-- 동등 조인
SELECT e.employee_id
         ,e.first_name
         ,d.department_id
         ,d.department_name
FROM employees e
        ,departments d
WHERE e.department_id = d.department_id;

-- 세미 조인
-- EXISTS 사용
SELECT department_id, department_name
FROM departments d
WHERE EXISTS ( SELECT *
                     FROM employees e
                     WHERE e.department_id = d.department_id
                     AND e.salary > 3000 )
ORDER BY d.department_name;

-- IN 사용
SELECT department_id, department_name
FROM departments d
WHERE d.department_id IN ( SELECT e.department_id
                                    FROM employees e
                                    WHERE e.salary > 3000 )
ORDER BY d.department_name
;

-- 안티 조인
-- NOT EXISTS 사용
SELECT department_id, department_name
FROM departments d
WHERE NOT EXISTS ( SELECT *
                            FROM employees e
                            WHERE e.department_id = d.department_id
                             AND e.salary > 3000 )
ORDER BY d.department_name;

-- IN 사용
SELECT e.employee_id
         ,e.first_name
         ,d.department_id
         ,d.department_name
FROM employees e
        ,departments d
WHERE e.department_id = d.department_id
AND e.department_id NOT IN (
                                        SELECT department_id
                                        FROM departments
                                        WHERE manager_id IS NULL )
; 

-- 셀프 조인
-- 사원과 관리자를 함께 조회하시오
SELECT a.employee_id 사원번호
         ,a.first_name 사원명
         ,b.employee_id 관리자번호
         ,b.first_name 관리자명
         ,a.department_id 부서번호
FROM employees a,
         employees b
WHERE a.employee_id = b.employee_id
AND a.department_id = b.department_id
;

-- 외부 조인
-- (+)
-- : 조인 조건에서 데이터가 없는 (NULL) 테이블의 컬럼에 기호를 붙여준다.
SELECT e.emp_id
         ,e.emp_name
         ,d.dept_id
         ,d.dept_title
FROM employee e
        ,department d
WHERE e.dept_code = d.dept_id (+)
;

-- ANSI
SELECT e.emp_id
         ,e.emp_name
         ,d.dept_id
         ,d.dept_title
FROM employee e LEFT OUTER JOIN department d -- OUTER 생략가능
                        ON e.dept_code = d.dept_id
;                        

-- RIGHT OUTER JOIN
-- (+)
-- : 조인 조건에서 데이터가 없는 (NULL) 테이블의 컬럼에 기호를 붙여준다.
SELECT e.emp_id
         ,e.emp_name
         ,d.dept_id
         ,d.dept_title
FROM employee e
        ,department d
WHERE e.dept_code(+) = d.dept_id
;

-- ANSI
SELECT e.emp_id
         ,e.emp_name
         ,d.dept_id
         ,d.dept_title
FROM employee e RIGHT OUTER JOIN department d -- OUTER 생략가능
                        ON e.dept_code = d.dept_id
;       

-- 외부 조인 유의사항
-- * 두 테이블의 조인 조건이 되는 공통 컬럼에 모두 (+) 기호를 붙여야한다
-- ex) 공통컬럼 : employee_id, department_id
SELECT e.employee_id
         ,e.first_name
         ,j.job_id
         ,j.department_id
FROM employees e
        ,job_history j
WHERE e.employee_id = j.employee_id(+)
AND e.department_id = j.department_id(+)
;

SELECT * FROM employees;
SELECT * FROM job_history;
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM job_history;

-- FULL OUTER JOIN
SELECT *
FROM employee e
        ,department d
WHERE e.dept_code(+) = d.dept_id(+);    -- (+) 기호로는 FULL JOIN 불가

SELECT e.emp_name
         ,d.dept_title
FROM employee e
        FULL OUTER JOIN department d
        ON dept_code = d.dept_id;
        
        
-- 데이터 사전 뷰
SELECT *
FROM user_tables
;





























