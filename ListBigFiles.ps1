#List big files on the system 
Get-ChildItem -Recurse -Path "C:\" -ErrorAction silentlycontinue | Where-Object { $_.length -gt 100000000 } | ForEach {
Write-Progress -activity "Fichiers de plus de 100Mo" -Status $_.FullName
$size = “{0:N2}” -f ($_.Length/1mb)
$logfile = ".\logs\Gros_fichiers.txt"
	$present = Test-Path -Path $logfile
	if ( $present -ne "true") {
Write-host "Création de $logfile"
$resfile = New-Item -ItemType file -Path $logfile -Force
Add-Content -Path $logfile -Value "Nom;Chemin;Taille"
Add-Content -Path $logfile -Value "$($_.name );$($_.DirectoryName);$($size)"
}
Else {
Add-Content -Path $logfile -Value "$($_.name );$($_.DirectoryName);$($size)"
}
}
