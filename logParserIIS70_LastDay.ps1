$filePath = "d:\EVTbackups\logs\LogFiles\W3SVC1\*.log"
$date =Get-Date -format "yyyy-MM-dd"
 
Write-Host "Hits by IP:"
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT C-IP As Machine, REVERSEDNS(C-Ip) As Name,COUNT(*) As Hits From $filePath  WHERE date='$date' GROUP BY Machine ORDER BY Hits DESC" -o:CSV
Write-Host "Hits by extension:"
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT TOP 25  EXTRACT_EXTENSION(cs-uri-stem) As Extension, COUNT(*) As Hits FROM $filePath WHERE date='$date' GROUP BY Extension  ORDER BY Hits DESC" -o:CSV
Write-Host "Top 25 url by number of hits:"
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT TOP 25  cs-uri-stem as Url, COUNT(*) As Hits  FROM $filePath  WHERE date='$date' GROUP BY cs-uri-stem ORDER By Hits DESC" -o:CSV
Write-Host "Slowest url(by average load time):"
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT TOP 25  cs-uri-stem as URL, MAX(time-taken) As Max, MIN(time-taken) As Min, Avg(time-taken) As Average FROM $filePath WHERE date='$date' GROUP BY URL ORDER By Average DESC" -o:CSV
Write-Host "Hits By user agent:"
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT  cs(User-Agent) As UserAgent, COUNT(*) as Hits  FROM $filePath WHERE date='$date' GROUP BY UserAgent ORDER BY Hits DESC" -o:CSV
Write-Host "Hits per hour:"
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT QUANTIZE(TO_LOCALTIME(TO_TIMESTAMP(date, time)),3600) AS Hour, COUNT(*) AS Hits  FROM $filePath  WHERE date='$date' Group By Hour" -o:CSV
Write-Host "Win32 error codes by total and page:"
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT cs-uri-stem AS Url, WIN32_ERROR_DESCRIPTION(sc-win32-status) AS Error, Count(*) AS Total FROM $filePath WHERE (sc-win32-status > 0 AND date='$date') GROUP BY Url, Error ORDER BY Total DESC" -o:CSV
#Write-Host "Bytes sent from the server:"
#Read-Host 'Please press ENTER' | Out-Null
#.\LogParser.exe -i:W3C "SELECT cs-uri-stem AS Url, Count(*) AS Hits, AVG(sc-bytes) AS Avg, Max(sc-bytes) AS Max, Min(sc-bytes) AS Min, Sum(sc-bytes) AS TotalBytes FROM $filePath GROUP BY cs-uri-stem HAVING (Hits > 100) ORDER BY [Avg] DESC" -o:CSV
#Write-Host "Bytes sent from the client:"
#Read-Host 'Please press ENTER' | Out-Null
#.\LogParser.exe -i:W3C "SELECT cs-uri-stem AS Url, Count(*) AS Hits, AVG(cs-bytes) AS Avg, Max(cs-bytes) AS Max, Min(cs-bytes) AS Min, Sum(cs-bytes) AS TotalBytes FROM $filePath GROUP BY Url HAVING (Hits > 100) ORDER BY [Avg] DESC" -o:CSV
Write-Host "Standard deviation:"
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT cs-uri-stem AS Url, Count(*) AS Hits, DIV(MUL(1.0, SUM(time-taken)), Hits ) as AvgTime, SQRROOT ( SUB ( DIV ( MUL(1.0, SUM(SQR(time-taken)) ), Hits ) , SQR(AvgTime) ) ) AS StDev FROM $filePath WHERE date='$date' GROUP BY URL ORDER BY AvgTime" -o:CSV
Write-Host "All unique URLs:"
Read-Host 'Please press ENTER' | Out-Null
.\LogParser.exe -i:W3C "SELECT DISTINCT TO_LOWERCASE(cs-uri-stem) AS Url, Count(*) AS Hits FROM $filePath WHERE sc-status=200 AND date='$date'  GROUP BY Url ORDER BY Url" -o:CSV
#Write-Host "Graph ping:"
#Read-Host 'Please press ENTER' | Out-Null
#.\ping -n 15 www.yahoo.com | logparser "SELECT TO_INT(REPLACE_STR(EXTRACT_VALUE(Text,'time',' '),'ms','')) AS Response INTO Ping.gif FROM stdin WHERE Text LIKE '%%Reply%%' GROUP BY Response" -i textline -legend off -chartTitle "Ping Times" -view