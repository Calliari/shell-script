# Check the dedinition of an cmdLet - e.g
# (Get-Command new-item).Definition

# enter where to write the outputs filepath
$filePath = "process.txt"

# get the machine hostname
$getHost = hostname 

# get the top 5 process running by CPU
$topProccess =  Get-Process | Sort-Object -Property CPU | select -Last 5

# create a file if it doesn't exist and make sure file is empty
if (!(Test-Path $filePath)) {
    Write-Warning "$filePath file doesn't exist!!!"
    write-host "creating a file $filePath"; New-Item $filePath | Out-Null
} elseif ((Get-Content $filePath) -eq $Null) {
    "File is blank, good to continue..."
} elseif ( (Test-Path $filePath) -and (!(Get-Content $filePath).Length -eq 0 ) ) {
    Write-Warning "File exist but it is not empty"
}

## different ways of writinf the output to a file 
# Write-Output "Output generated on:" > process.txt
# Write-Output "" | Out-File -append process.txt
# $getHost, $topProccess | Out-File -append process.txt
# "Done!" | Add-Content process.txt

## %{} block is called for every value in the array. i.g - 
## 1,2,3 | %{ write-host $_ }
"Output generated on: $(get-date)", "", "Hostname: $getHost", $topProccess, "Done!"  | %{ write-output $_ } | Out-File -append $filePath