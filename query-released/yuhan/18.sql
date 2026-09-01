-- 18. 서류도착자 명단
Select AI.IpsiYear, AI.SelTypeName, AI.MajorName, AI.SuhumNo, AI.StuKorName, AD.SUBMITSTATUS, AD.SUBMITDATETIME
From APPLYSUBMITDOCS AD
Inner Join VWAPPLYINFO AI ON AI.ipsiYear = AD.IpsiYear AND AI.ipsiGubun = AD.IpsiGUbun AND AI.SuhumNo = AD.SuhumNo 
Where AD.IpsIYear = 2024 AND AD.IpsiGubun = 1 --AND TO_CHAR(AD.SUBMITDATETIME, 'YYYY/MM/DD HH:MI:SS') = '2023/08/11 09:00:00'
    AND AD.SUBMITSTATUS = 'Y'