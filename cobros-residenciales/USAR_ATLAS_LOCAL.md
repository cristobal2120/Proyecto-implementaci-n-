# Usar MongoDB Atlas desde tu PC (Docker local)

## 1. `.env` (ya configurado)

```env
MONGODB_URI=mongodb+srv://cristobal:...@cluster0.c66e5fd.mongodb.net/?retryWrites=true&w=majority
MONGODB_DB=cobros_residenciales
```

Mantén `APP_ENV=dev` si quieres el botón **Crear demo** y `POST /admin/seed-demo`.

## 2. Atlas — red

**Network Access** → debe existir `0.0.0.0/0` o tu IP actual.

## 3. Reiniciar servicios que hablan con Mongo

```powershell
cd "c:\Users\ferna\OneDrive\Escritorio\tarea de diana\cobros-residenciales"
docker compose restart backend worker payments
```

Si no estaban levantados:

```powershell
docker compose up -d
```

## 4. Poblar Atlas la primera vez (BD vacía)

```powershell
curl.exe -X POST http://localhost:8000/admin/seed-demo
```

Luego entra en http://localhost:5174 con `admin_demo@conjunto.com` / `Admin12345!`.

## 5. Comprobar

- Crea o genera una factura en el panel admin.
- Atlas → **Browse Collections** → `cobros_residenciales` → `invoices`.

## No veo nada en Atlas (pantalla en blanco)

La página **Project 0** arriba **no** muestra tablas. Ruta exacta:

1. Menú izquierdo → **Database** (icono de cilindros).
2. En la tarjeta **Cluster0** → botón verde **Browse Collections**.
3. Panel izquierdo: base **`cobros_residenciales`** (no `admin`, no `local`).
4. Clic en **`invoices`** o **`users`** → deben salir filas a la derecha.

Si **Cluster0** no aparece: el cluster no está creado o está en **otra organización/proyecto** (arriba cambia "Project 0").

Si las colecciones existen pero vacías, en PowerShell:

```powershell
cd "c:\Users\ferna\OneDrive\Escritorio\tarea de diana\cobros-residenciales"
docker compose up -d --force-recreate backend worker payments
.\scripts\verificar-atlas.ps1
curl.exe -X POST http://localhost:8000/admin/seed-demo
```

El script debe mostrar `users: 10`, `invoices: 8`, etc. Si ahí hay números y Atlas sigue vacío, estás en **otro proyecto** de Atlas o mirando otra base.

URI del cluster debe coincidir con Atlas → Connect → Drivers: `cluster0.c66e5fd.mongodb.net`.

## Volver al Mongo local

En `.env`:

```env
MONGODB_URI=mongodb://mongo:27017
```

Y `docker compose restart backend worker payments`.
