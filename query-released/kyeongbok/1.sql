/*
1010	특성화고
5000	전문대학졸업이상자
6000	일반
7000	기회균형선발
C000	특기자
J000	일반고
K000	대학자체
M000	고른기회1
N000	순수외국인
Q000	블록외국인
R000	고른기회2
*/

Select 
	MAX(STM.MajorName) AS "학과명"
	, STM.IpsiYear AS "학년도"
	-- 일반전형
	, MAX(Case When STM.SelTypeCode = '6000' THEN STM.OldPersonnel END) "일반_모집인원"
	, MAX(Case When STM.SelTypeCode = '6000' THEN AI.ApplyCnt END) "일반_지원인원"
	, Convert(Decimal(10,2), MAX(Case When STM.SelTypeCode = '6000' THEN AI.ApplyCnt END) * 1.0 /
	  MAX(Case When STM.SelTypeCode = '6000' THEN STM.OldPersonnel END) * 1.0) "일반_경쟁률"
	, MAX(Case When STM.SelTypeCode = '6000' THEN AI.MAXCalcGrade END) "일반_최저"
	, MAX(Case When STM.SelTypeCode = '6000' THEN AI.AVGCalcGrade END) "일반_평균"
	, MAX(Case When STM.SelTypeCode = '6000' THEN AI.LastSpareRank END) "일반_예비"
	-- 일반고전형
	, MAX(Case When STM.SelTypeCode = 'J000' THEN STM.OldPersonnel END) "일반고_모집인원"
	, MAX(Case When STM.SelTypeCode = 'J000' THEN AI.ApplyCnt END) "일반고_지원인원"
	, Convert(Decimal(10,2), MAX(Case When STM.SelTypeCode = 'J000' THEN AI.ApplyCnt END) * 1.0 /
	  MAX(Case When STM.SelTypeCode = 'J000' THEN STM.OldPersonnel END) * 1.0) "일반고_경쟁률"
	, MAX(Case When STM.SelTypeCode = 'J000' THEN AI.MAXCalcGrade END) "일반고_최저"
	, MAX(Case When STM.SelTypeCode = 'J000' THEN AI.AVGCalcGrade END) "일반고_평균"
	, MAX(Case When STM.SelTypeCode = 'J000' THEN AI.LastSpareRank END) "일반고_예비"
	-- 특성화고전형
	, MAX(Case When STM.SelTypeCode = '1010' THEN STM.OldPersonnel END) "특성화고_모집인원"
	, MAX(Case When STM.SelTypeCode = '1010' THEN AI.ApplyCnt END) "특성화고_지원인원"
	, Convert(Decimal(10,2), MAX(Case When STM.SelTypeCode = '1010' THEN AI.ApplyCnt END) * 1.0 /
	  MAX(Case When STM.SelTypeCode = '1010' THEN STM.OldPersonnel END) * 1.0) "특성화고_경쟁률"
	, MAX(Case When STM.SelTypeCode = '1010' THEN AI.MAXCalcGrade END) "특성화고_최저"
	, MAX(Case When STM.SelTypeCode = '1010' THEN AI.AVGCalcGrade END) "특성화고_평균"
	, MAX(Case When STM.SelTypeCode = '1010' THEN AI.LastSpareRank END) "특성화고_예비"
	-- 특기자전형
	, MAX(Case When STM.SelTypeCode = 'C000' THEN STM.OldPersonnel END) "특기자_모집인원"
	, MAX(Case When STM.SelTypeCode = 'C000' THEN AI.ApplyCnt END) "특기자_지원인원"
	, Convert(Decimal(10,2), MAX(Case When STM.SelTypeCode = 'C000' THEN AI.ApplyCnt END) * 1.0 /
	  MAX(Case When STM.SelTypeCode = 'C000' THEN STM.OldPersonnel END) * 1.0) "특기자_경쟁률"
	, MAX(Case When STM.SelTypeCode = 'C000' THEN AI.MAXCalcGrade END) "특기자_최저"
	, MAX(Case When STM.SelTypeCode = 'C000' THEN AI.AVGCalcGrade END) "특기자_평균"
	, MAX(Case When STM.SelTypeCode = 'C000' THEN AI.LastSpareRank END) "특기자_예비"
	-- 대학자체전형
	, MAX(Case When STM.SelTypeCode = 'K000' THEN STM.OldPersonnel END) "대학자체_모집인원"
	, MAX(Case When STM.SelTypeCode = 'K000' THEN AI.ApplyCnt END) "대학자체_지원인원"
	, Convert(Decimal(10,2), MAX(Case When STM.SelTypeCode = 'K000' THEN AI.ApplyCnt END) * 1.0 /
	  MAX(Case When STM.SelTypeCode = 'K000' THEN STM.OldPersonnel END) * 1.0) "대학자체_경쟁률"
	, MAX(Case When STM.SelTypeCode = 'K000' THEN AI.MAXCalcGrade END) "대학자체_최저"
	, MAX(Case When STM.SelTypeCode = 'K000' THEN AI.AVGCalcGrade END) "대학자체_평균"
	, MAX(Case When STM.SelTypeCode = 'K000' THEN AI.LastSpareRank END) "대학자체_예비"
	-- 고른기회1전형
	, MAX(Case When STM.SelTypeCode = 'M000' THEN STM.OldPersonnel END) "고른기회1_모집인원"
	, MAX(Case When STM.SelTypeCode = 'M000' THEN AI.ApplyCnt END) "고른기회1_지원인원"
	, Convert(Decimal(10,2), MAX(Case When STM.SelTypeCode = 'M000' THEN AI.ApplyCnt END) * 1.0 /
	  MAX(Case When STM.SelTypeCode = 'M000' THEN STM.OldPersonnel END) * 1.0) "고른기회1_경쟁률"
	, MAX(Case When STM.SelTypeCode = 'M000' THEN AI.MAXCalcGrade END) "고른기회1_최저"
	, MAX(Case When STM.SelTypeCode = 'M000' THEN AI.AVGCalcGrade END) "고른기회1_평균"
	, MAX(Case When STM.SelTypeCode = 'M000' THEN AI.LastSpareRank END) "고른기회1_예비"
	-- 고른기회2전형
	, MAX(Case When STM.SelTypeCode = 'R000' THEN STM.OldPersonnel END) "고른기회2_모집인원"
	, MAX(Case When STM.SelTypeCode = 'R000' THEN AI.ApplyCnt END) "고른기회2_지원인원"
	, Convert(Decimal(10,2), MAX(Case When STM.SelTypeCode = 'R000' THEN AI.ApplyCnt END) * 1.0 /
	  MAX(Case When STM.SelTypeCode = 'R000' THEN STM.OldPersonnel END) * 1.0) "고른기회2_경쟁률"
	, MAX(Case When STM.SelTypeCode = 'R000' THEN AI.MAXCalcGrade END) "고른기회2_최저"
	, MAX(Case When STM.SelTypeCode = 'R000' THEN AI.AVGCalcGrade END) "고른기회2_평균"
	, MAX(Case When STM.SelTypeCode = 'R000' THEN AI.LastSpareRank END) "고른기회2_예비"
	-- 전문대졸전형
	, MAX(Case When STM.SelTypeCode = '5000' THEN STM.OldPersonnel END) "전문대졸_모집인원"
	, MAX(Case When STM.SelTypeCode = '5000' THEN AI.ApplyCnt END) "전문대졸_지원인원"
	, Convert(Decimal(10,2), MAX(Case When STM.SelTypeCode = '5000' THEN AI.ApplyCnt END) * 1.0 /
	  MAX(Case When STM.SelTypeCode = '5000' THEN STM.OldPersonnel END) * 1.0) "전문대졸_경쟁률"
	, MAX(Case When STM.SelTypeCode = '5000' THEN AI.MINUNIVAVG END) "전문대졸_최저"
	, MAX(Case When STM.SelTypeCode = '5000' THEN AI.AVGUNIVAVG END) "전문대졸_평균"
	, MAX(Case When STM.SelTypeCode = '5000' THEN AI.LastSpareRank END) "전문대졸_예비"
	-- 기회균형전형
	, MAX(Case When STM.SelTypeCode = '7000' THEN STM.OldPersonnel END) "기회균형_모집인원"
	, MAX(Case When STM.SelTypeCode = '7000' THEN AI.ApplyCnt END) "기회균형_지원인원"
	, Convert(Decimal(10,2), MAX(Case When STM.SelTypeCode = '7000' THEN AI.ApplyCnt END) * 1.0 /
	  MAX(Case When STM.SelTypeCode = '7000' THEN STM.OldPersonnel END) * 1.0) "기회균형_경쟁률"
	, MAX(Case When STM.SelTypeCode = '7000' THEN AI.MAXCalcGrade END) "기회균형_최저"
	, MAX(Case When STM.SelTypeCode = '7000' THEN AI.AVGCalcGrade END) "기회균형_평균"
	, MAX(Case When STM.SelTypeCode = '7000' THEN AI.LastSpareRank END) "기회균형_예비"
From vwSelectTypeModel STM
Inner Join (
	Select 
		AI.IpsiYear, AI.IpsiGubun, AI.SelTypeCode, AI.MajorCode
		, Count(*) AS ApplyCnt
		, ISNULL(MAX(Case When AM.PassStep > 0 THEN AM.SpareRank END),0) AS LastSpareRank
		, Convert(decimal(5,2), MAX(Case When AM.PassStep > 0 THEN CH.CalcGrade END)) AS MAXCalcGrade
		, Convert(decimal(5,2), AVG(Case When AM.PassStep > 0 THEN CH.CalcGrade END)) AS AVGCalcGrade
		, Convert(decimal(5,2), MIN(Case When AM.PassStep > 0 THEN Convert(Decimal(6,3), AE.UNIVAVG) END)) AS MINUNIVAVG
		, Convert(decimal(5,2), AVG(Case When AM.PassStep > 0 THEN Convert(Decimal(6,3), AE.UNIVAVG) END)) AS AVGUNIVAVG
	From ApplyInfo AI
	Inner Join ApplyInfoMaster AM ON AI.IpsiYear = AM.IpsiYear AND AI.IpsiGubun = AM.IpsiGubun
		AND AI.SuhumNo = AM.SuhumNo
	Left Join ApplyInfoExtend AE ON AI.IpsiYear = AE.IpsiYear AND AI.IpsiGubun = AE.IpsiGubun
		AND AI.SuhumNo = AE.SuhumNo
	Left Join CalcHSB CH ON AI.IpsiYear = CH.IpsiYear AND AI.IpsiGubun = CH.IpsiGubun
		AND AI.SuhumNo = CH.SuhumNo
	Group By AI.IpsiYear, AI.IpsiGubun, AI.SelTypeCode, AI.MajorCode
) AI ON AI.IpsiYear = STM.IPSIYEAR AND AI.IpsiGubun = STM.IPSIGUBUN
	AND AI.SelTypeCode = STM.SelTypeCode AND AI.MajorCode = STM.MajorCode
Where STM.IPSIYEAR = {입학연도} AND STM.IPSIGUBUN = 1
Group By STM.IPSIYEAR, STM.IPSIGUBUN, STM.MajorCode
Order By STM.IPSIYEAR, STM.IPSIGUBUN, MAX(STM.MajorOrder)