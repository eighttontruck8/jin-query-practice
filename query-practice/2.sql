/*
    [유한대학교 쿼리 연습 2]

    주제: 중복을 제거한 모집단위 코드 조회
    난이도: ★☆☆☆☆

    ApplyInfo 테이블에서 다음 조건을 모두 만족하는 모집단위(학과) 코드를
    중복 없이 조회하세요.

    조회할 컬럼
    1. MajorCode : 모집단위(학과) 코드

    조회 조건
    - IpsiYear가 2024인 지원자
    - IpsiGubun이 1인 지원자
    - MajorCode가 NULL이 아닌 지원자

    정렬 조건
    - MajorCode를 기준으로 오름차순 정렬

    이번 문제에서 새로 연습할 문법
    - DISTINCT : 조회 결과의 중복 행 제거
    - IS NOT NULL : NULL이 아닌 데이터만 조회

    이전 문제에서 연습한 문법도 함께 사용하세요.
    - SELECT
    - FROM
    - WHERE
    - AND
    - ORDER BY

    주의
    - GROUP BY는 사용하지 마세요.
    - MajorCode에는 같은 값이 여러 번 존재할 수 있지만,
      결과에는 각 코드가 한 번씩만 나와야 합니다.
*/

-- 아래에 쿼리를 작성하세요.

SELECT DISTINCT MAJORCODE
FROM APPLYINFO
WHERE IPSIYEAR = 2024 AND IPSIGUBUN = 1 AND MAJORCODE IS NOT NULL
ORDER BY MAJORCODE;