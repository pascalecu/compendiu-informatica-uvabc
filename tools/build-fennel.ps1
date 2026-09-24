$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$source = Join-Path $root 'src\compendium.fnl'
$buildDir = Join-Path $root '.build\lua'
$output = Join-Path $buildDir 'compendium.lua'
$temp = "$output.tmp"

New-Item -ItemType Directory -Force $buildDir | Out-Null

try {
    $generated = & fennel --compile $source

    if ($LASTEXITCODE -ne 0) {
        throw "Fennel compilation failed with exit code $LASTEXITCODE."
    }

    [System.IO.File]::WriteAllText(
        $temp,
        ($generated -join "`n") + "`n",
        [System.Text.UTF8Encoding]::new($false)
    )

    Move-Item -Force $temp $output

    Write-Host "Generated $output"
}
catch {
    Remove-Item $temp -Force -ErrorAction SilentlyContinue
    throw
}