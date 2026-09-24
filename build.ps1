$ErrorActionPreference = 'Stop'

$root = $PSScriptRoot

& "$root\tools\build-fennel.ps1"

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

$texBuildDir = Join-Path $root '.build\tex'
New-Item -ItemType Directory -Force $texBuildDir | Out-Null

Push-Location $root

try {
    $latexmkArgs = @(
        '-lualatex'
        '-outdir=.build/tex'
        'main.tex'
    )

    & latexmk @latexmkArgs

    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }
}
finally {
    Pop-Location
}