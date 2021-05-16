# ORACLE_KEYWORD Summary
오라클 공부하면서 문법 정리겸, 깜박하고 잊을만한 내용 정리자료 입니다.
___
## SELECT : 데이터베이스에 저장되어 있는 데이터 조회
#### DISTINCT 
- 열 중복제거
```SQL
SELECT DISTINCT NAME FROM EMP; --> NAME컬럼 데이터 중 중복된 열 값 제거
```

#### AS 
- 별칭
```SQL
SELECT 1+2+3 AS 합계 FROM DUAL; --> 6(1+2+3)의 컬럼명이 '합계'
```

#### ORDER BY 
- 출력데이터를 원하는 순서로 출력
- SELECT문을 작성할 때 사용할 수 있는 여러 절 중 가장 마지막 부분에 작성한다.
- ASC, DESC
```SQL
SELECT[조회할 열1 이름], [열2 이름], ...., [열N 이름]
FROM  [조회할 테이블 이름]
.
. (그 밖의 절)
ORDER BY [정렬하려는 열 이름(여러 열 지정 가능)] [정렬 옵션];
```
```SQL
SELECT * FROM EMP
ORDER BY SALARY;      --> SALARY 컬럼값 오름차순
SELECT * FROM EMP    
ORDER BY SALARY DESC; --> SALARY 컬럼값 내림차순
```
___
## WHERE : 필요한 데이터만 출력하기
### <연산자>
#### 1. 기본 연산자 
- 산술 연산자: +, -, *, /
- 비교 연산자: <, <=, >=, >
- 등가 비교 연산자 : =, !=, <>, ^=
- 논리 부정 연산자 : NOT
- AND, OR: 또 다른 조건추가 연산자

#### 2. IN
- 특정 열에 해당하는 조건 여러개 지정 출력
```SQL
SELECT[조회할 열1 이름], [열2 이름], ...., [열N 이름]
FROM  [조회할 테이블 이름]
WHERE 열 이름 IN (데이터1, 데이터2, ... 데이터N);
```
```SQL
SELECT * FROM EMP 
WHERE NAME IN ('홍길동', '아무개', '하하하'); --> 괄호에 있는 값 중, NAME에 속한 값 출력  
```

#### 3. BETWEEN A AND B
- A이상 B이하
```SQL
SELECT[조회할 열1 이름], [열2 이름], ...., [열N 이름]
FROM  [조회할 테이블 이름]
WHERE 열 이름 BETWEEN 최솟값 AND 최댓값
```
```SQL
SELECT * FROM EMP
WHERE SALARY BETWEEN 1800000 AND 3000000; --> 180만이상 300만이하 값 출력
```

#### 4. LIKE
- 이메일이나 게시판 제목 또는 내용검색 기능처럼 일부 문자열이 포함된 데이터를 조회할 때 사용
- _  : 어떤 값이든 상관없이 한개의 문자 데이터를 의미
- -% : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미
```SQL
SELECT * FROM EMP WHERE NAME LIKE 'L%';   --> 대문자 L로 시작하는 데이터조회
SELECT * FROM EMP WHERE NAME LIKE '__L%'; --> 세번째 글자가 대문자 L로 시작하는 데이터 조회
SELECT * FROM EMP WHERE NAME LIKE '%LA%'; --> 대문자 LA를 포함하는 데이터 조회
```

#### 5. IS NULL
- *NULL: '비어있는 상태'(숫자0과 다르다.)
```SQL
SELECT * FROM EMP WHERE NAME IS NULL;     --> NAME열 값이 존재하지 않는 데이터 출력
SELECT * FROM EMP WHERE NAME IS NOT NULL; --> NAME열 값이 존재하는 데이터 출력
```

### <문자열 함수>
#### 1. UPPER, LOWER, INITCAP, 대소문자
- UPPER(문자열): 괄호 안 문자 데이터 모두 대문자 변환
- LOWER(문자열): 괄호 안 문자 데이터 모두 소문자 변환
- INITCAP(문자열): 괄호 안 문자 데이터 중 첫 글자는 대문자, 나머지 문자 소문자 변환
```SQL
SELECT UPPER(NAME), LOWER(NAME), INITCAP(NAME) FROM EMP;
SELECT * FROM EMP WHERE UPPER(NAME) = UPPER('kimhyuK');
```    

#### 2. LENGTH, 문자열 길이
- 특정 문자열의 길이를 구할 때 사용
```SQL
SELECT NAME FROM EMP WHERE LENGTH(NAME) >= 4;
```

#### 3. SUBSTR, 문자열 일부 추출
- 문자열 중 일부를 추출할 때 사용
```SQL
SELECT 
	SUBSTR(NAME, 2),   --> 2번째 글자부터 끝까지 추출
	SUBSTR(NAME, 3, 2) --> 3번째 글자부터 2글자 추출
FROM EMP;
```

#### 4. INSTR, 특정 문자 위치 찾기
- 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지를 알고자 할 때 사용
```SQL
INSTR([대상 문자열 데이터(필수)],
      [위치를 찾으려는 부분 문자(필수)],
      [위치 찾기를 시작할 대상 문자열 데이터 위치(선택, 기본값=1)],
      [시작 위치에서 찾으려는 문자가 몇 번째인지 지정(선택, 기본값=1)])
```
```SQL
SELECT INSTR('HELLO, WORLD!', 'O') AS STR1,      -->시작위치 지정 X, 출력값: 5
       INSTR('HELLO, WORLD!', 'O', 8) AS STR2,   -->8번째 글자 부터 시작, 출력값: 9
       INSTR('HELLO, WORLD!', 'O', 3, 2) AS STR3 -->3번째 글자 부터 시작 -> 2번째 값 찾기, 출력값: 9
FROM DUAL;
```

#### 5. REPLACE, 특정문자를 다른문자로 바꾸기
- 특정 문자열 데이터에 포함된 문자를 다른 문자로 대체할 경우에 사용
```SQL
REPLACE([문자열 데이터 OR 열 이름(필수)], [찾는 문자(필수)], [대체할 문자(선택)]
``` 
```SQL
SELECT REPLACE('010-1234-5678', '-', ' ') AS RE1, --> 010 1234 5678
       REPLACE('010-1234-5678', '-') AS RE2,      --> 01012345678
       REPLACE('홍길동', '홍', '김') AS RE3       --> 김길동
FROM DUAL;
```

#### 6. LPAD & RPAD, 데이터의 빈 공간 채우기
- Left Padding, Right Padding
- 데이터와 자릿수를 지정한 후 데이터 길이가 지정한 자릿수보다 작을 경우에 나머지 공간을 특정 문자로 채울때 사용
- LPAD는 남은 빈 공간을 왼쪽으로, RPAD는 남은 빈 공간을 오른쪽으로 채운다.
- 만약 빈 공간에 채울 문자를 지정하지 않으면 LPAD와 RPAD는 빈 공간의 자릿수 만큼 공백문자("")로 띄운다.
```SQL
LPAD([문자열 데이터 또는 열이름(필수)], [데이터의 자리수(필수)], [빈 공간에 채울 문자(선택)])
RPAD([문자열 데이터 또는 열이름(필수)], [데이터의 자리수(필수)], [빈 공간에 채울 문자(선택)])
```
```SQL
SELECT LPAD('TEST', 10, '#') AS LPAD1,  --> "######TEST"
       RPAD('TEST', 10, '*') AS RPAD1,  --> "TEST******"
       LPAD('TEST', 10) AS LPAD2,       --> "      TEST"
       RPAD('TEST', 10) AS RPAD2        --> "TEST      "
FROM DUAL; 
```

#### 7. CONCAT, 두 문자열 데이터 합치기
- 두 개의 문자열 데이터를 하나의 데이터로 연결해주는 역할을 한다.
- 두 개의 입력 데이터를 지정을 하고 열이나 문자열 데이터 모두 지정할 수 있다.
```SQL
SELECT CONCAT('HELLO', 'WORLD!'),              --> HELLOWORLD!
       CONCAT('HELLO', CONCAT(', ', 'WORLD!')) --> HELLO, WORLD!
FROM DUAL;       
```

#### 8. TRIM & LTRIM & RTRIM, 특정 문자 지우기(공백제거)
- 문자열 데이터 내에서 특정 문자를 지우기 위해 사용한다.
- 삭제할 문자가 생략될 경우에 기본적으로 공백을 제거한다.
```SQL
TRIM([삭제 옵션(선택)] [삭제할 문자(선택)] FROM [원본 문자열 데이터(필수)])
```
```SQL
SELECT TRIM('  HELLO, WORLD!  ') AS TRIM1,  --> "HELLO, WORLD!"
       LTRIM('  HELLO, WORLD!  ') AS TRIM2, --> "HELLO, WORLD!  "
       RTRIM('  HELLO, WORLD!  ') AS TRIM3  --> "  HELLO, WORLD!"
FROM DUAL;
```

### <숫자형 함수>
#### 1. ROUND, 반올림
- 지정된 숫자의 특정 위치에서 반올림한 값을 반환한다.
- 반올림할 위치를 지정하지 않으면 소수점 첫째 자리에서 반올림한 결과를 반환한다.
```SQL
ROUND([숫자(필수)], [반올림 위치(선택)])
```
```SQL
SELECT ROUND(1234.5678) AS ROUND1,      --> 1235
       ROUND(1234.5678, 2) AS ROUND2,   --> 1234.57
       ROUND(1234.5678, -1) AS ROUND3,  --> 1230
       ROUND(1234.5678, -2) AS ROUND4   --> 1200
FROM DUAL;
```

#### 2. TRUNC, 버림값
- 지정된 숫자의 특정 위치에서 버림한 값을 반환한다. 
```SQL
ROUND([숫자(필수)], [버림 위치(선택)])
```
```SQL
SELECT TRUNC(1234.5678) AS ROUND1,      --> 1234
       TRUNC(1234.5678, 2) AS ROUND2,   --> 1234.56
       TRUNC(1234.5678, -1) AS ROUND3,  --> 1230
       TRUNC(1234.5678, -2) AS ROUND4   --> 1200
FROM DUAL;
```

#### 3. CEIL & FLOOR, 무조건 올림, 내림
- CEIL:  지정된 숫자보다 큰 정수 중 가장 작은 정수를 반환한다.
- FLOOR: 지정된 숫자보다 작은 정수 중 작은 큰 정수를 반환한다.
```SQL
CEIL([숫자(필수)])
FLOOR([숫자(필수)])
```
```SQL
SELECT CEIL(3.14),   --> 4
       FLOOR(3.14),  --> 3
       CEIL(-3.14),  --> -3
       FLOOR(-3.14)  --> -4
FROM DUAL;
```

#### 5. MOD, 나머지
- 지정된 숫자를 나눈 나머지 값을 반환한다.
```SQL
MOD([나눗셈 될 숫자(필수)], [나눌 숫자(필수)])
```
```SQL
SELECT MOD(10, 3),  --> 1
       MOD(15, 6),  --> 3
       MOD(10, 2),  --> 0
FROM DUAL;
```

### <집계 함수>
#### 1. COUNT, 갯수
- 결과셋의 레코드 갯수를 반환한다.
```SQL
COUNT([DISTINCT, ALL 중 하나를 선택하거나 아무 값도 지정하지 않음(선택)]
      [개수를 구할 열이나 연산자, 함수를 사용한 데이터(필수)])
```
```SQL
SELECT COUNT(*) FROM EMP;    --> EMP테이블에 속한 열 개수 출력
SELECT COUNT(NAME) FROM EMP; --> NAME컬럼에  속한 열 개수 출력
SELECT COUNT(NAME) FROM EMP WHERE POSITION = '부장'; --> POSITION 컬럼 안에 '부장'인 데이터 중 NAME 개수
```

#### 2. SUM, 합계
- 데이터의 합을 구하는 함수이다. 
- 숫자형만 대상이다.(문자형X, 날짜X)
```SQL
SUM([DISTINCT, ALL 중 하나를 선택하거나 아무 값도 지정하지 않음(선택)]
    [합계를 구할 열이나 연산자, 함수를 사용한 데이터(필수)])
```
```SQL
SELECT SUM(10+5) FROM DUAL;    --> 15
SELECT SUM(WEIGHT) FROM EMP;   --> WEIGHT열의 총 합
```

#### 3. AVG, 평균
- 입력 데이터의 평균 값을 구하는 함수이다.
```SQL
AVG([DISTINCT, ALL 중 하나를 선택하거나 아무 값도 지정하지 않음(선택)]
    [평균 값을 구할 열이나 연산자, 함수를 사용한 데이터(필수)])
```
```SQL
SELECT AVG(SALARY) FROM EMP;                         --> SALARY컬럼 안의 데이터 평균값
SELECT AVG(SALARY) FROM EMP WHERE POSITION = '부장'; --> POSITION 컬럼 안에 '부장'인 데이터 중 평균값
```

#### 4. MAX & MIN, 최댓값 & 최솟값
- 입력 데이터 중 최대값과 최솟값을 반환한다.
- 숫자형, 문자형, 날짜형에 사용 가능하다.
```SQL
MAX([DISTINCT, ALL 중 하나를 선택하거나 아무 값도 지정하지 않음(선택)]
    [최대값을 구할 열이나 연산자, 함수를 사용한 데이터(필수)])
MIN([DISTINCT, ALL 중 하나를 선택하거나 아무 값도 지정하지 않음(선택)]
    [최소값을 구할 열이나 연산자, 함수를 사용한 데이터(필수)])
```
```SQL
SELECT MAX(SALARY) FROM EMP;               --> SALARY 컬럼 안에 데이터 중 최대값 반환
SELECT MIN(SALARY) FROM EMP;               --> SALARY 컬럼 안에 데이터 중 최솟값 반환
SELECT MAX(SALARY) FROM WHERE NUMBER = 10; --> NUMBER 컬럼 안에 10인 데이터중 SALARY 최대값
SELECT MAX(SALARY) FROM WHERE NUMBER = 10; --> NUMBER 컬럼 안에 10인 데이터중 SALARY 최소값
```
