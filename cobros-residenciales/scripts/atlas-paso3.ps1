# Paso 3 Atlas: arma MONGODB_URI y genera .env.produccion-vm (no subir a GitHub).
param(
    [string]$Usuario = "cobros_user",
    [string]$ClusterHost = "cluster0.c66e5fd.mongodb.net"
)

$root = Split-Path -Parent $PSScriptRoot
$out = Join-Path $root ".env.produccion-vm"

Write-Host "Paso 3 — URI de Atlas para la VM (opcion C)" -ForegroundColor Cyan
Write-Host "Usuario de Database Access (Enter = $Usuario): " -NoNewline
$in = Read-Host
if ($in.Trim()) { $Usuario = $in.Trim() }

$secure = Read-Host "Contrasena (la que copiaste con Copy en Atlas)" -AsSecureString
$bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
$plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)

Add-Type -AssemblyName System.Web
$encoded = [System.Web.HttpUtility]::UrlEncode($plain)

$uri = "mongodb+srv://${Usuario}:${encoded}@${ClusterHost}/?retryWrites=true&w=majority"

$jwt = -join ((1..32 | ForEach-Object { '{0:x2}' -f (Get-Random -Maximum 256) }))

$example = Join-Path $root ".env.production.example"
$lines = Get-Content $example -Raw
$lines = $lines -replace '(?m)^MONGODB_URI=.*', "MONGODB_URI=$uri"
$lines = $lines -replace '(?m)^JWT_SECRET=.*', "JWT_SECRET=$jwt"
$lines = $lines -replace '(?m)^APP_ENV=.*', 'APP_ENV=prod'

# Factus desde .env local si existe
$local = Join-Path $root ".env"
if (Test-Path $local) {
    foreach ($key in @(
        'FACTUS_HOST','FACTUS_CLIENT_ID','FACTUS_CLIENT_SECRET',
        'FACTUS_USERNAME','FACTUS_PASSWORD','FACTUS_NUMBERING_RANGE_ID'
    )) {
        if ($lines -match "(?m)^$key=") {
            $val = (Select-String -Path $local -Pattern "^$key=(.*)$").Matches.Groups[1].Value
            if ($val) { $lines = $lines -replace "(?m)^$key=.*", "$key=$val" }
        }
    }
}

Set-Content -Path $out -Value $lines -Encoding UTF8
Write-Host ""
Write-Host "Listo: $out" -ForegroundColor Green
Write-Host "Sube este archivo a la VM como .env (no lo subas a GitHub)." -ForegroundColor Yellow
Write-Host "MONGODB_URI usa usuario: $Usuario | cluster: $ClusterHost"
