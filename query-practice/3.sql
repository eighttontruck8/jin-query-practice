/*
    [유한대학교 쿼리 연습 3]

    주제: 모집단위별 지원자 수 집계
    난이도: ★★★☆☆

    ApplyInfo 테이블을 이용하여 2024년도 모집시기 1의
    모집단위(학과)별 지원자 수를 조회하세요.

    조회할 컬럼 (아래 순서대로)
    1. MajorCode : 모집단위(학과) 코드
    2. 해당 모집단위의 지원자 수
       - COUNT를 사용하세요.
       - 결과 컬럼의 별칭은 ApplyCount로 지정하세요.

    행을 집계하기 전의 조회 조건
    - IpsiYear가 2024인 지원자
    - IpsiGubun이 1인 지원자
    - MajorCode가 NULL이 아닌 지원자

    그룹 조건
    - 같은 MajorCode를 하나의 그룹으로 묶으세요.

    집계한 후의 그룹 필터 조건
    - 지원자 수가 10명 이상인 모집단위만 조회하세요.

    정렬 조건 (우선순위 순서)
    1. 지원자 수가 많은 모집단위부터 조회
    2. 지원자 수가 같으면 MajorCode를 오름차순으로 정렬

    이번 문제에서 새로 연습할 문법
    - COUNT
    - AS를 이용한 컬럼 별칭
    - GROUP BY
    - HAVING
    - 여러 정렬 조건 지정

    주의
    - WHERE 절에서 COUNT 결과를 필터링할 수 없습니다.
    - DISTINCT는 사용하지 마세요.
    - 서브쿼리는 사용하지 마세요.
    - SELECT *를 사용하지 마세요.
*/

-- 아래에 쿼리를 작성하세요.

SELECT MAJORCODE, COUNT(*) AS APPLYCOUNT
FROM APPLYINFO
WHERE IPSIYEAR = 2024 AND IPSIGUBUN = 1 AND MAJORCODE IS NOT NULL
GROUP BY MAJORCODE
HAVING COUNT(*) >= 10
ORDER BY APPLYCOUNT DESC, MAJORCODE;