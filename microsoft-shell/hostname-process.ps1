# get the machine hostname
$getHost = hostname 

# get the top 5 process running by CPU
$topProccess =  Get-Process | Sort-Object -Property CPU | select -Last 5

# write the output to a file 
"This is a test" | Add-Content process.txt
$getHost | Out-File process.txt
$topProccess | Out-File -append process.txt


# Write-Output $getHost $topProccess process.txt