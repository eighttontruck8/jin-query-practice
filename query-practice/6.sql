/*
    [유한대학교 쿼리 연습 6]

    주제: 전형·모집단위별 경쟁률 계산
    난이도: ★★★★☆
    참고 패턴: query-released/yuhan/2.sql ~ 17.sql

    전형모델 통합 뷰와 지원자 기본정보 테이블을 이용하여
    2024년도 모집시기 1의 전형·모집단위별 모집 현황과 경쟁률을 조회하세요.

    5번 문제의 구조를 그대로 활용하되 경쟁률을 추가하는 문제입니다.

    사용할 대상과 별칭
    - 전형모델 통합 뷰: STM
    - 지원자 수를 집계하는 인라인 뷰: AI

    조회할 항목과 결과 별칭 (아래 순서대로)
    1. 입학연도                 -> "입학연도"
    2. 모집시기명               -> "모집시기"
    3. 전형명                   -> "전형명"
    4. 모집단위(학과)명         -> "모집학과"
    5. 학과별 모집인원          -> "모집인원"
    6. 해당 전형·학과 지원자 수 -> "지원인원"
    7. 지원인원 ÷ 모집인원      -> "경쟁률"

    지원자 집계 및 조인 요구사항
    - 지원자 기본정보 테이블을 인라인 뷰에서 먼저 집계하세요.
    - 입학연도, 모집시기, 모집군, 전형코드, 학과코드를 기준으로 집계하세요.
    - 각 그룹의 행 개수를 지원인원으로 사용하세요.
    - 전형모델 통합 뷰를 기준으로 LEFT JOIN하세요.
    - 위의 다섯 업무 항목을 모두 조인 조건에 사용하세요.
    - 지원자가 없는 경우 지원인원은 0으로 표시하세요.

    경쟁률 계산 요구사항
    - 계산식: 지원인원 / 학과별 모집인원
    - 모집인원이 NULL 또는 0이면 경쟁률을 0으로 표시하세요.
    - 지원자가 없으면 경쟁률도 0으로 표시하세요.
    - 정수 나눗셈으로 소수 부분이 사라지지 않게 처리하세요.
    - 경쟁률은 소수점 둘째 자리까지 반올림하세요.
    - CASE와 ROUND를 사용하세요.

    조회 조건
    - 전형모델 통합 뷰를 기준으로 입학연도 2024
    - 전형모델 통합 뷰를 기준으로 모집시기 1

    정렬 조건 (우선순위 순서)
    1. 전형 표시순서 오름차순
    2. 모집단위(학과) 표시순서 오름차순

    이번 문제에서 새로 연습할 내용
    - CASE를 이용한 분기 처리
    - 0으로 나누는 오류 방지
    - 정수 나눗셈 방지
    - ROUND를 이용한 반올림

    주의
    - 실제 컬럼명은 createtable.sql에서 직접 찾으세요.
    - 결과의 한글 별칭은 위에서 지정한 이름과 정확히 맞추세요.
    - 경쟁률 계산에 전형 전체 모집인원이 아닌 학과별 모집인원을 사용하세요.
    - 지원인원을 세기 위해 원본 지원자 행을 전형모델 뷰에 바로 JOIN하지 마세요.
    - SELECT *를 사용하지 마세요.
*/

-- 아래에 쿼리를 작성하세요.
SELECT STM.IPSIYEAR "입학연도", IPSINAME "모집시기", SELTYPENAME "전형명", MAJORNAME "모집학과", ISNULL(MAJORPERSONNEL,0) "모집인원"
, ISNULL(AI.지원인원, 0)
, CASE WHEN MAJORPERSONNEL IS NULL OR MAJORPERSONNEL = 0 OR AI.지원인원 = 0 THEN 0 ELSE ROUND(AI.지원인원 * 1.0 / MAJORPERSONNEL, 0) END "경쟁률" 
FROM vwSelectTypeModel STM
LEFT JOIN
(
	SELECT IPSIYEAR, IPSIGUBUN, GUNID, SELTYPECODE, MAJORCODE, COUNT(*) "지원인원"
	FROM APPLYINFO
	GROUP BY IPSIYEAR, IPSIGUBUN, GUNID, SELTYPECODE, MAJORCODE
) AS AI
ON STM.IPSIYEAR = AI.IPSIYEAR AND STM.IPSIGUBUN = AI.IPSIGUBUN AND STM.GUNID = AI.GUNID AND STM.SELTYPECODE = AI.SELTYPECODE AND STM.MAJORCODE = AI.MAJORCODE
WHERE STM.IPSIYEAR = 2024 AND STM.IPSIGUBUN = 1
ORDER BY STM.SELTYPEORDER, STM.MajorOrder;
