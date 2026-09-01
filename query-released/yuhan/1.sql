-- 1. 지원자 학생부 데이터 조회(학교폭력)
Select 
	AI.IpsiYear AS "모집년도"
  , AI.IpsiName AS "모집시기"
  , AI.SelTypeName AS "전형"
  , AI.MajorName AS "모집단위"
  , AI.SuhumNo AS "수험번호"
  , AI.StuKorName AS "이름"
  , HA.Specials AS "출결 특기사항"
  , HO.Opinion AS "행동특성 및 종합의견"
  , HP.Specials AS "학적사항" 
  , HV.VIOCONTENTS AS "학교폭력 조치사항"
From vwApplyInfo AI
Left Join( /*학적 8~9호*/
		Select IpsiYear, IpsiGubun, SuhumNo, Specials
		From HsbPersonalInfo
		Where IpsiYear = {입학연도} And IpsiGubun = {모집시기} And REGEXP_LIKE(Specials, '폭[[:space:]]*력')
			AND SuhumNo IN (Select SuhumNo From ApplyInfo Where IpsiYear = {입학연도} AND IpsiGubun = {모집시기})
	)HP ON AI.IpsiYear = HP.IpsiYear And AI.IpsiGubun = HP.IpsiGubun And AI.SuhumNo = HP.SuhumNo
Left Join ( /*행동특성 1호~3호,7호*/ 
		Select IpsiYear, IpsiGubun, SuhumNo, Opinion
		From HsbOpinion
		Where IpsiYear = {입학연도} And IpsiGubun = {모집시기} And REGEXP_LIKE(Opinion, '폭[[:space:]]*력')
			AND SuhumNo IN (Select SuhumNo From ApplyInfo Where IpsiYear = {입학연도} AND IpsiGubun = {모집시기})
	)HO ON AI.IpsiYear = HO.IpsiYear And AI.IpsiGubun = HO.IpsiGubun And AI.SuhumNo = HO.SuhumNo 
Left Join ( /*출결 4~6호*/
		Select IpsiYear, IpsiGubun, SuhumNo, Specials
		From HsbAttend 
		Where IpsiYear = {입학연도} and IpsiGubun = {모집시기} And REGEXP_LIKE(Specials, '폭[[:space:]]*력')
			AND SuhumNo IN (Select SuhumNo From ApplyInfo Where IpsiYear = {입학연도} AND IpsiGubun = {모집시기})
	)HA on AI.IpsiYear = HA.IpsiYear And AI.IpsiGubun = HA.IpsiGubun And AI.SuhumNo = HA.SuhumNo --And HA.Grade = HO.Grade
Left Join ( /*학폭 */
		Select IpsiYear, IpsiGubun, SuhumNo, VIOCONTENTS
		From HSBVIOLENCE 
		Where IpsiYear = {입학연도} and IpsiGubun = {모집시기} And REGEXP_LIKE(VIOCONTENTS, '폭[[:space:]]*력')
			AND SuhumNo IN (Select SuhumNo From ApplyInfo Where IpsiYear = {입학연도} AND IpsiGubun = {모집시기})
	)HV on AI.IpsiYear = HV.IpsiYear And AI.IpsiGubun = HV.IpsiGubun And AI.SuhumNo = HV.SuhumNo --And HA.Grade = HO.Grade
Where AI.IpsiYear = {입학연도} And AI.IpsiGubun = {모집시기}
	And (HO.Opinion Is Not Null Or HA.Specials IS Not Null Or HP.Specials Is Not NULL Or HV.VIOCONTENTS Is Not Null)
Order by AI.SuhumNo