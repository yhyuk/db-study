# ORACLE_KEYWORD Summary
오라클 공부하면서 문법 정리겸, 깜박하고 잊을만한 내용 정리자료 입니다.

## SELECT : DB에 저장되어 있는 데이터 조회
#### DISTINCT 
- 열 중복제거
#### AS 
- 별칭
#### ORDER BY 
- 출력데이터를 원하는 순서로 출력
- ASC, DESC

## WHERE : 필요한 데이터만 출력
#### 기본 연산자
- 산술 연산자: +, -, *, /
- 비교 연산자: <, <=, >=, >
- 등가 비교 연산자 : =, !=, <>, ^=
- 논리 부정 연산자 : NOT
- AND, OR: 또 다른 조건추가 연산자
#### IN 연산자 
- 특정 열에 해당하는 조건 여러개 지정 출력
#### BETWEEN A AND B 연산자
- A이상 B이하
#### LIKE 연산자
- 이메일이나 게시판 제목 또는 내용검색 기능처럼 일부 문자열이 포함된 데이터를 조회할 때 사용
- _  : 어떤 값이든 상관없이 한개의 문자 데이터를 의미
- -% : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미
```sql
SELECT * FROM EMP WHERE NAME LIKE 'L%';   --> 대문자 L로 시작하는 데이터조회
SELECT * FROM EMP WHERE NAME LIKE '__L%'; --> 세번째 글자가 대문자 L로 시작하는 데이터 조회
SELECT * FROM EMP WHERE NAME LIKE '%LA%'; --> 대문자 LA를 포함하는 데이터 조회
```
#### IS NULL 연산자
- *NULL: '비어있는 상태'(숫자0과 다르다.)
```sql
SELECT * FROM EMP WHERE NAME IS NULL;     --> NAME열 값이 존재하지 않는 데이터 출력
SELECT * FROM EMP WHERE NAME IS NOT NULL; --> NAME열 값이 존재하는 데이터 출력
```

## 문자열 함수
#### UPPER, LOWER, INITCAP, 대소문자
- UPPER(문자열): 괄호 안 문자 데이터 모두 대문자 변환
- LOWER(문자열): 괄호 안 문자 데이터 모두 소문자 변환
- INITCAP(문자열): 괄호 안 문자 데이터 중 첫 글자는 대문자, 나머지 문자 소문자 변환
```SQL
SELECT UPPER(NAME), LOWER(NAME), INITCAP(NAME) FROM EMP;
SELECT * FROM EMP WHERE UPPER(NAME) = UPPER('kimhyuK');
```    

#### LENGTH, 문자열 길이
- 특정 문자열의 길이를 구할 때 사용
```SQL
SELECT NAME FROM EMP WHERE LENGTH(NAME) >= 4;
```
