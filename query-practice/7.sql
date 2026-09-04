/*
    [유한대학교 쿼리 연습 7]

    주제: 모집단위별 정원내·정원외 모집/지원 현황
    난이도: ★★★★☆
    참고 패턴: query-released/yuhan/2.sql ~ 17.sql

    전형모델 통합 뷰와 지원자 기본정보 테이블을 이용하여
    2024년도 모집시기 1의 모집단위별 정원내·정원외 현황을 조회하세요.

    하나의 모집단위에 여러 전형이 존재하더라도 결과는 모집단위별 한 행으로
    표시하고, 전형구분에 따라 모집인원과 지원인원을 서로 다른 컬럼에 합산하세요.

    사용할 대상과 별칭
    - 전형모델 통합 뷰: STM
    - 지원자 수를 집계하는 인라인 뷰: AI

    전형구분 값
    - '1': 정원내
    - '2': 정원외

    조회할 항목과 결과 별칭 (아래 순서대로)
    1. 입학연도                    -> "입학연도"
    2. 모집시기명                  -> "모집시기"
    3. 모집단위(학과)명            -> "모집학과"
    4. 정원내 전형모델 모집인원 합계 -> "정원내_모집인원"
    5. 정원내 지원인원 합계        -> "정원내_지원인원"
    6. 정원외 전형모델 모집인원 합계 -> "정원외_모집인원"
    7. 정원외 지원인원 합계        -> "정원외_지원인원"
    8. 전체 전형모델 모집인원 합계   -> "전체_모집인원"
    9. 전체 지원인원 합계          -> "전체_지원인원"

    지원자 집계 및 조인 요구사항
    - 지원자 기본정보 테이블을 인라인 뷰에서 먼저 집계하세요.
    - 입학연도, 모집시기, 모집군, 전형코드, 학과코드를 기준으로 집계하세요.
    - 각 그룹의 행 개수를 지원인원으로 사용하세요.
    - 전형모델 통합 뷰를 기준으로 집계 결과를 LEFT JOIN하세요.
    - 위의 다섯 업무 항목을 모두 조인 조건에 사용하세요.
    - 지원자가 없는 전형의 지원인원은 0으로 계산하세요.

    최종 집계 요구사항
    - 모집단위별로 결과가 한 행만 나오도록 그룹화하세요.
    - SUM과 CASE를 조합하여 정원내와 정원외를 서로 다른 컬럼으로 집계하세요.
    - CASE에서 해당 전형구분이 아닌 행은 0으로 계산하세요.
    - 전체 모집인원과 전체 지원인원은 전형구분과 관계없이 합산하세요.

    조회 조건
    - 전형모델 통합 뷰를 기준으로 입학연도 2024
    - 전형모델 통합 뷰를 기준으로 모집시기 1

    정렬 조건
    - 모집단위(학과) 표시순서 오름차순

    이번 문제에서 새로 연습할 내용
    - SUM(CASE WHEN ... THEN ... ELSE ... END)
    - 행으로 존재하는 구분값을 여러 결과 컬럼으로 변환
    - LEFT JOIN 결과를 다시 상위 수준으로 집계

    주의
    - 실제 컬럼명은 createtable.sql에서 직접 찾으세요.
    - 결과의 한글 별칭은 위에서 지정한 이름과 정확히 맞추세요.
    - 모집인원은 유한대 운영 쿼리와 동일하게 전형모델의 모집인원을 사용하세요.
    - 계열모집은 같은 전형모델 모집인원이 여러 학과에 표시될 수 있으므로,
      이 결과의 학과별 모집인원을 다시 학교 전체 합계로 더하지 마세요.
    - 정원내·정원외 조건은 전형코드가 아니라 전형구분 값을 사용하세요.
    - 지원인원이 NULL인 경우 합계에서 빠지지 않도록 0으로 변환하세요.
    - 경쟁률은 계산하지 마세요.
    - ROLLUP과 서브쿼리 추가 중첩은 아직 사용하지 마세요.
    - SELECT *를 사용하지 마세요.
*/

-- 아래에 쿼리를 작성하세요.
SELECT 
STM.IPSIYEAR 입학연도, STM.IpsiName 모집시기, STM.MAJORNAME 모집학과
, SUM(CASE WHEN STM.SELTYPEGUBUN = '1' THEN STM.PERSONNEL ELSE 0 END) AS 정원내_모집인원
, ISNULL(SUM(CASE WHEN STM.SELTYPEGUBUN = '1' THEN AI.지원인원 ELSE 0 END), 0) AS 정원내_지원인원
, SUM(CASE WHEN STM.SELTYPEGUBUN = '2' THEN STM.PERSONNEL ELSE 0 END) AS 정원외_모집인원 
, ISNULL(SUM(CASE WHEN STM.SELTYPEGUBUN = '2' THEN AI.지원인원 ELSE 0 END), 0) AS 정원외_지원인원
, SUM(STM.PERSONNEL) 전체_모집인원 
, ISNULL(SUM(AI.지원인원), 0) 전체_지원인원
FROM vwSelectTypeModel STM
LEFT JOIN (
	SELECT IPSIYEAR, IPSIGUBUN, GUNID, SELTYPECODE, MajorCode, COUNT(*) "지원인원"
	FROM APPLYINFO
	GROUP BY IPSIYEAR, IPSIGUBUN, GUNID, SELTYPECODE, MajorCode
) AS AI
ON STM.IPSIYEAR = AI.IPSIYEAR AND STM.IPSIGUBUN = AI.IpsiGubun AND STM.GUNID = AI.GUNID AND STM.SELTYPECODE = AI.SELTYPECODE AND STM.MajorCode = AI.MAJORCODE 
WHERE STM.IPSIYEAR = 2024 AND STM.IPSIGUBUN = 1
GROUP BY STM.IPSIYEAR, STM.IPSINAME, STM.MAJORNAME, STM.MAJORORDER, STM.MAJORCODE
ORDER BY STM.MajorOrder
;
