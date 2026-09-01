/*
    [유한대학교 쿼리 연습 5]

    주제: 전형·모집단위별 모집인원 및 지원인원 조회
    난이도: ★★★★☆
    참고 패턴: query-released/yuhan/2.sql ~ 17.sql

    전형모델 통합 뷰와 지원자 기본정보 테이블을 이용하여
    2024년도 모집시기 1의 전형·모집단위별 모집인원과 지원인원을 조회하세요.

    사용할 대상과 별칭
    - 전형모델 통합 뷰: STM
    - 지원자 수를 집계하는 인라인 뷰(서브쿼리): AI

    조회할 항목과 결과 별칭 (아래 순서대로)
    1. 입학연도             -> "입학연도"
    2. 모집시기명           -> "모집시기"
    3. 전형명               -> "전형명"
    4. 모집단위(학과)명     -> "모집학과"
    5. 학과별 모집인원      -> "모집인원"
    6. 해당 전형·학과 지원자 수 -> "지원인원"

    요구사항
    1. 지원자 기본정보 테이블을 인라인 뷰로 먼저 집계하세요.
    2. 다음 다섯 가지 업무 항목이 같은 지원자끼리 하나의 그룹으로 묶으세요.
       - 입학연도
       - 모집시기
       - 모집군
       - 전형코드
       - 모집단위(학과)코드
    3. 각 그룹의 행 개수를 세어 지원인원을 만드세요.
    4. 전형모델 통합 뷰를 기준으로 집계 결과를 LEFT JOIN하세요.
    5. 조인할 때도 위의 다섯 가지 업무 항목이 모두 같아야 합니다.
    6. 지원자가 없는 전형·학과도 결과에 표시해야 합니다.
    7. 지원자가 없는 경우 지원인원을 NULL이 아닌 0으로 표시하세요.
    8. 전형모델 통합 뷰를 기준으로 입학연도 2024, 모집시기 1만 조회하세요.

    정렬 조건 (우선순위 순서)
    1. 전형 표시순서 오름차순
    2. 모집단위(학과) 표시순서 오름차순

    이번 문제에서 새로 연습할 내용
    - FROM 절 안의 집계 서브쿼리(인라인 뷰)
    - 여러 컬럼을 이용한 GROUP BY
    - LEFT JOIN
    - 복합 조인 조건
    - NULL을 0으로 변환하는 함수
    - 한글 컬럼 별칭

    주의
    - 문제에 필요한 실제 컬럼명은 createtable.sql에서 직접 찾으세요.
    - 전형모델 통합 뷰의 학과별 모집인원 컬럼을 사용하세요.
      전형 전체 모집인원 컬럼과 혼동하지 마세요.
    - 지원인원 집계에는 COUNT를 사용하세요.
    - 지원자가 0명인 모집단위를 보존해야 하므로 INNER JOIN을 사용하면 안 됩니다.
    - SELECT *를 사용하지 마세요.
    - 경쟁률은 아직 계산하지 마세요.
*/

-- 아래에 쿼리를 작성하세요.
SELECT STM.IPSIYEAR "입학연도", STM.IpsiName "모집시기", STM.SELTYPENAME "전형명"
, STM.MajorName "모집학과", STM.MAJORPERSONNEL "모집인원"
, ISNULL(AI.지원인원, 0)"지원인원"
FROM VWSelectTypeModel STM

LEFT JOIN (
	SELECT IPSIYEAR, IPSIGUBUN , GUNID , SELTYPECODE , MAJORCODE, COUNT(*) "지원인원"
	FROM APPLYINFO
	GROUP BY IPSIYEAR, IPSIGUBUN, GUNID, SELTYPECODE, MAJORCODE
) AS AI
ON STM.IPSIYEAR = AI.IPSIYEAR AND STM.IPSIGUBUN = AI.IPSIGUBUN AND STM.GunID = AI.GUNID AND STM.SelTypeCode = AI.SELTYPECODE AND STM.MajorCode = AI.MAJORCODE
WHERE STM.IPSIYEAR = 2024 AND STM.IPSIGUBUN = 1
ORDER BY STM.SelTypeOrder, STM.MajorOrder; 
