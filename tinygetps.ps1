$url = ""
$server = ""
.\tinyget -srv:$server -uri:$url -threads:1 -loop:1 -h
Measure-Command {.\tinyget -srv:$server -uri:$url -threads:50 -loop:10}
[System.Threading.Thread]::Sleep(2000)
Measure-Command {.\tinyget -srv:$server -uri:$url -threads:100 -loop:10}
[System.Threading.Thread]::Sleep(2000)
Measure-Command {.\tinyget -srv:$server -uri:$url -threads:150 -loop:10}
[System.Threading.Thread]::Sleep(2000)
Measure-Command {.\tinyget -srv:$server -uri:$url -threads:200 -loop:10}
