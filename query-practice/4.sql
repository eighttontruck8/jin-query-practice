/*
    [유한대학교 쿼리 연습 4]

    주제: 서류 제출 완료 지원자 명단 조회
    난이도: ★★★☆☆
    참고 패턴: query-released/yuhan/18.sql

    APPLYSUBMITDOCS와 VWAPPLYINFO를 INNER JOIN하여
    서류 제출을 완료한 지원자의 명단을 조회하세요.

    테이블·뷰 설명
    - APPLYSUBMITDOCS: 지원자의 서류 제출 상태를 저장
    - VWAPPLYINFO: 지원자의 전형명, 학과명, 이름 등을 조회할 수 있는 뷰

    반드시 사용할 별칭
    - APPLYSUBMITDOCS: AD
    - VWAPPLYINFO: AI

    두 대상을 연결할 컬럼
    - IpsiYear  : 입학연도
    - IpsiGubun : 모집시기
    - SuhumNo   : 수험번호

    위 세 컬럼이 각각 서로 같은 행끼리 연결하세요.

    조회할 컬럼 (아래 순서대로)
    1. AI.IpsiYear       : 입학연도
    2. AI.SelTypeName    : 전형명
    3. AI.MajorName      : 모집단위(학과)명
    4. AI.SuhumNo        : 수험번호
    5. AI.StuKorName     : 지원자 이름
    6. AD.SubmitStatus   : 서류 제출 상태
    7. AD.SubmitDateTime : 서류 제출 일시

    조회 조건
    - AD.IpsiYear가 2024
    - AD.IpsiGubun이 1
    - AD.SubmitStatus가 'Y'

    정렬 조건 (우선순위 순서)
    1. AI.SelTypeName 오름차순
    2. AI.MajorName 오름차순
    3. AI.SuhumNo 오름차순

    이번 문제에서 새로 연습할 내용
    - 테이블과 뷰에 별칭 부여
    - INNER JOIN ... ON
    - 여러 컬럼으로 조인 조건 작성
    - 어느 테이블의 컬럼인지 별칭으로 명시

    주의
    - 구식 콤마 조인 문법을 사용하지 마세요.
    - JOIN은 반드시 INNER JOIN으로 작성하세요.
    - SELECT *를 사용하지 마세요.
    - 서브쿼리와 GROUP BY는 사용하지 마세요.
*/

-- 아래에 쿼리를 작성하세요.

SELECT AI.IPSIYEAR, AI.SELTYPENAME, AI.MAJORNAME, AI.SUHUMNO, AI.STUKORNAME, AD.SUBMITSTATUS, AD.SUBMITDATETIME
FROM VWAPPLYINFO AI
INNER JOIN APPLYSUBMITDOCS AD
ON AI.IPSIYEAR = AD.IPSIYEAR AND AI.IPSIGUBUN = AD.IPSIGUBUN AND AI.SUHUMNO = AD.SUHUMNO
WHERE AD.IPSIYEAR = 2024 AND AD.IPSIGUBUN = 1 AND AD.SubmitStatus = 'Y'
ORDER BY AI.SELTYPENAME, AI.MAJORNAME, AI.SUHUMNO;