# ORACLE_KEYWORD Summary
오라클 공부하면서 문법 정리겸, 깜박하고 잊을만한 내용 정리자료 입니다.
___
## SELECT : DB에 저장되어 있는 데이터 조회
#### DISTINCT 
- 열 중복제거
#### AS 
- 별칭
#### ORDER BY 
- 출력데이터를 원하는 순서로 출력
- ASC, DESC
___
## WHERE : 필요한 데이터만 출력
### <연산자>
#### 1. 기본 연산자 
- 산술 연산자: +, -, *, /
- 비교 연산자: <, <=, >=, >
- 등가 비교 연산자 : =, !=, <>, ^=
- 논리 부정 연산자 : NOT
- AND, OR: 또 다른 조건추가 연산자
#### 2. IN
- 특정 열에 해당하는 조건 여러개 지정 출력
#### 3. BETWEEN A AND B
- A이상 B이하
#### 4. LIKE
- 이메일이나 게시판 제목 또는 내용검색 기능처럼 일부 문자열이 포함된 데이터를 조회할 때 사용
- _  : 어떤 값이든 상관없이 한개의 문자 데이터를 의미
- -% : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미
```sql
SELECT * FROM EMP WHERE NAME LIKE 'L%';   --> 대문자 L로 시작하는 데이터조회
SELECT * FROM EMP WHERE NAME LIKE '__L%'; --> 세번째 글자가 대문자 L로 시작하는 데이터 조회
SELECT * FROM EMP WHERE NAME LIKE '%LA%'; --> 대문자 LA를 포함하는 데이터 조회
```
#### 5. IS NULL
- *NULL: '비어있는 상태'(숫자0과 다르다.)
```sql
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
**test
```SQL
REPLACE([문자열 데이터 OR 열 이름(필수)], [찾는 문자(필수)], [대체할 문자(선택)]
``` 
