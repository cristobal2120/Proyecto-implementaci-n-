# Comprueba que Docker usa Atlas y cuántos documentos hay.
# Ejecutar: .\scripts\verificar-atlas.ps1

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

Write-Host "=== .env en tu PC ===" -ForegroundColor Cyan
Select-String -Path ".env" -Pattern "^MONGODB_URI=|^MONGODB_DB=" | ForEach-Object { $_.Line }

Write-Host "`n=== Variables DENTRO del contenedor backend ===" -ForegroundColor Cyan
docker exec cobros-residenciales-backend-1 printenv MONGODB_URI MONGODB_DB 2>&1

Write-Host "`n=== Conteo en Mongo (desde el backend) ===" -ForegroundColor Cyan
docker exec cobros-residenciales-backend-1 python -c @"
from pymongo import MongoClient
import os
uri = os.environ['MONGODB_URI']
dbn = os.environ.get('MONGODB_DB', 'cobros_residenciales')
c = MongoClient(uri, serverSelectionTimeoutMS=20000)
c.admin.command('ping')
print('Conexion: OK')
print('Bases de datos en el cluster:', c.list_database_names())
db = c[dbn]
print('Base usada por la app:', dbn)
print('Colecciones:', db.list_collection_names())
for col in ['users','units','invoices']:
    if col in db.list_collection_names():
        print(f'  {col}:', db[col].count_documents({}))
"@

Write-Host "`n=== Seed (si todo es 0) ===" -ForegroundColor Yellow
Write-Host 'curl.exe -X POST http://localhost:8000/admin/seed-demo'
