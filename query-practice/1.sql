/*
    [유한대학교 쿼리 연습 1]

    주제: 지원자 기본정보 조회
    난이도: ★☆☆☆☆

    ApplyInfo 테이블에서 다음 조건을 모두 만족하는 지원자를 조회하세요.

    조회할 컬럼 (아래 순서대로)
    1. IpsiYear    : 입학연도
    2. IpsiGubun   : 모집시기
    3. SuhumNo     : 수험번호
    4. StuKorName  : 지원자 한글 이름
    5. MajorCode   : 모집단위(학과) 코드
    6. ApplyTime   : 접수일자

    조회 조건
    - IpsiYear가 2024인 지원자
    - IpsiGubun이 1인 지원자

    정렬 조건
    - SuhumNo를 기준으로 오름차순 정렬

    이번 문제에서 연습할 문법
    - SELECT
    - FROM
    - WHERE
    - AND
    - ORDER BY

    주의
    - SELECT *를 사용하지 마세요.
    - 테이블명과 컬럼명은 위에 적힌 이름을 그대로 사용하세요.
*/

-- 아래에 쿼리를 작성하세요.
select ipsiyear, ipsigubun, suhumno, StuKorName, majorcode, ApplyTime
from applyinfo
where ipsiyear = 2024 and ipsigubun = 1
order by 3;