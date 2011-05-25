$filePath = "c:\Users\bav\Documents\IISExpress\Logs\EVT2.log"
.\LogParser.exe -i:W3C "SELECT Client-IP As Machine, REVERSEDNS(Client-Ip) As Name,COUNT(*) As Hits From $filePath GROUP BY Machine ORDER BY Hits DESC" -o:CSV
.\LogParser.exe -i:W3C "SELECT TOP 25  EXTRACT_EXTENSION(uri-stem) As Extension, COUNT(*) As Hits FROM $filePath GROUP BY Extension  ORDER BY Hits DESC" -o:CSV
.\LogParser.exe -i:W3C "SELECT TOP 25  uri-stem as Url, COUNT(*) As Hits  FROM $filePath GROUP BY uri-stem  ORDER By Hits DESC" -o:CSV
.\LogParser.exe -i:W3C "SELECT TOP 25  uri-stem as URL, MAX(time-taken) As Max, MIN(time-taken) As Min, Avg(time-taken) As Average FROM $filePath GROUP BY URL ORDER By Average DESC" -o:CSV
.\LogParser.exe -i:W3C "SELECT  User-Agent As UserAgent, COUNT(*) as Hits  FROM $filePath GROUP BY UserAgent ORDER BY Hits DESC" -o:CSV

