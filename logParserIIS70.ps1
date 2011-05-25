$filePath = "d:\EVTbackups\logs\LogFiles\W3SVC1\*.log"
.\LogParser.exe -i:W3C "SELECT C-IP As Machine, REVERSEDNS(C-Ip) As Name,COUNT(*) As Hits From $filePath GROUP BY Machine ORDER BY Hits DESC" -o:CSV
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT TOP 25  EXTRACT_EXTENSION(cs-uri-stem) As Extension, COUNT(*) As Hits FROM $filePath GROUP BY Extension  ORDER BY Hits DESC" -o:CSV
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT TOP 25  cs-uri-stem as Url, COUNT(*) As Hits  FROM $filePath GROUP BY cs-uri-stem  ORDER By Hits DESC" -o:CSV
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT TOP 25  cs-uri-stem as URL, MAX(time-taken) As Max, MIN(time-taken) As Min, Avg(time-taken) As Average FROM $filePath GROUP BY URL ORDER By Average DESC" -o:CSV
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT  cs(User-Agent) As UserAgent, COUNT(*) as Hits  FROM $filePath GROUP BY UserAgent ORDER BY Hits DESC" -o:CSV
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT QUANTIZE(TO_LOCALTIME(TO_TIMESTAMP(date, time)),3600) AS Hour, COUNT(*) AS Hits  FROM $filePath  WHERE date>'2009-03-01' and date<'2012-04-01' Group By Hour" -o:CSV
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT sc-win32-status As Win32-Status, WIN32_ERROR_DESCRIPTION(sc-win32-status) as Description, COUNT(*) AS Hits FROM $filePath WHERE Win32-Status<>0  GROUP BY Win32-Status  ORDER BY Win32-Status ASC" -o:CSV
