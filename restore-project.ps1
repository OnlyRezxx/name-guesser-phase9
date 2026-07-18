$ErrorActionPreference = 'Stop'
$parts = Get-ChildItem -Path "$PSScriptRoot\archive" -Filter 'part-*' | Sort-Object Name
if ($parts.Count -eq 0) { throw 'Bagian arsip tidak ditemukan.' }
$base64 = ($parts | ForEach-Object { Get-Content $_.FullName -Raw }) -join ''
$bytes = [Convert]::FromBase64String($base64)
$zip = Join-Path $PSScriptRoot 'name-guesser-phase9-source.zip'
[IO.File]::WriteAllBytes($zip, $bytes)
$target = Join-Path $PSScriptRoot 'name-guesser-phase9-source'
if (Test-Path $target) { Remove-Item $target -Recurse -Force }
Expand-Archive -Path $zip -DestinationPath $PSScriptRoot -Force
Write-Host "Selesai. Proyek diekstrak ke: $target"
Write-Host 'Masuk ke folder itu lalu jalankan: .\setup-windows.ps1'
