# Guía de exposición — Residencial: Tu hogar, en orden

**Orden:** 1) Admin completo → 2) Residente completo → 3) Cierre  
**Tiempo:** ~15 minutos

---

## Antes de exponer (checklist)

| Paso | Acción |
|------|--------|
| 1 | `docker compose up -d --build` en `cobros-residenciales` |
| 2 | Abrir **http://localhost:5174** |
| 3 | Tener lista una ventana **incógnito** para el residente |
| 4 | Si la BD está vacía: en admin usar **Crear demo** (paso A3) |

### Credenciales

| Rol | Email | Contraseña |
|-----|-------|------------|
| Admin | `admin_demo@conjunto.com` | `Admin12345!` |
| Residente | `residente_demo@conjunto.com` | `Residente123!` |

---

## Introducción (30 s) — opcional

**Decir:**

> Presento **Residencial — Tu hogar, en orden**: portal para conjuntos en Colombia.  
> Arquitectura: frontend React, backend FastAPI, servicio de pagos, worker con tareas automáticas y MongoDB, todo en Docker.  
> Primero el **administrador**; después un **residente**.

---

# PARTE 1 — ADMINISTRADOR

Sigue el **sidebar** en este orden: Facturas → Usuarios → Unidades → Amenidades → Reservas → Gimnasio → Mi perfil.

---

## A1 — Entrar como admin

| | |
|---|---|
| **Pantalla** | `/login` |
| **Hacer** | Email `admin_demo@conjunto.com` → Contraseña `Admin12345!` → Iniciar sesión |

**Decir (3 frases):**

1. Login con JWT; todo lo demás va autenticado.
2. Panel con sidebar, resumen arriba y tema claro/oscuro.
3. El admin ve y gestiona **todo el conjunto**.

---

## A2 — Facturas (núcleo del admin)

| | |
|---|---|
| **Pantalla** | Sidebar → **Facturas** |

### A2.1 — Si no hay datos

| **Hacer** | Botón **Crear demo** |
| **Decir** | Carga residentes, unidades, facturas del mes, parqueaderos y salón en un clic (solo desarrollo). |

### A2.2 — Resumen y cobros

| **Hacer** | Mostrar tarjetas: recaudado, pendientes, vencidas, pagadas |
| **Decir** | Resumen en tiempo real de la cartera del mes. |

| **Hacer** | (Opcional) **Generar cobros (mes actual)** |
| **Decir** | Crea una factura por unidad: **base mensual × coeficiente**. No duplica si ya existe el mes. |

### A2.3 — Lista de facturas

| **Hacer** | Mostrar tabla; señalar periodo `AAAA-MM` |
| **Decir** | Estados: **Pendiente** (no pagó), **Pagada**, **Vencida** (pasó fecha límite, ej. día 10). |

### A2.4 — Facturación DIAN (Factus)

| **Hacer** | Señalar columna Factus: Emitida / Error / Pendiente |
| **Decir** | Con Factus configurado y perfil fiscal del residente, se emite factura electrónica DIAN. Admin puede reintentar si hubo error. |

### A2.5 — Morosidad

| **Hacer** | Bajar a **Reporte de morosidad** |
| **Decir** | Lista unidades con deuda vencida: cuánto deben y qué residente está asociado. |

---

## A3 — Usuarios

| | |
|---|---|
| **Pantalla** | Sidebar → **Usuarios** |
| **Hacer** | Mostrar lista; abrir un residente con perfil fiscal |

**Decir (3 frases):**

1. Alta de residentes: correo, nombre, contraseña.
2. **Perfil fiscal** obligatorio para Factus (documento, municipio, etc.).
3. Restablecer contraseña o eliminar residente (desasigna unidades).

---

## A4 — Unidades

| | |
|---|---|
| **Pantalla** | Sidebar → **Unidades** |
| **Hacer** | Mostrar `APT-101` con residente y una sin asignar |

**Decir (3 frases):**

1. Cada unidad tiene **código** y **coeficiente** (0–1).
2. El monto de administración depende del coeficiente.
3. El residente solo ve facturas de unidades donde está **asignado**.

---

## A5 — Amenidades

| | |
|---|---|
| **Pantalla** | Sidebar → **Amenidades** |
| **Hacer** | Mostrar `VIS-01`…`VIS-03` y `SALON-A` |

**Decir (2 frases):**

1. Dos tipos: **parqueadero visitantes** (por hora) y **salón comunal** (por día).
2. Activar, desactivar o crear códigos; alimentan el calendario del residente.

---

## A6 — Reservas

| | |
|---|---|
| **Pantalla** | Sidebar → **Reservas** |
| **Hacer** | Mostrar listado; si hay una pagada de parqueadero, señalar **PIN** |

**Decir (3 frases):**

1. Vista global: quién reservó, fechas, monto, estado.
2. Admin puede cancelar o eliminar.
3. Reserva **Pendiente** sin pago ~30 min → el **worker** la cancela y libera el espacio.

---

## A7 — Gimnasio

| | |
|---|---|
| **Pantalla** | Sidebar → **Gimnasio** |
| **Hacer** | Mostrar suscripciones del mes |

**Decir (2 frases):**

1. Admin ve quién tiene gym **Pendiente** o **Pagada**.
2. El día 1 de cada mes el worker renueva suscripción si pagó el mes anterior.

---

## A8 — Cerrar sesión admin

| | |
|---|---|
| **Hacer** | Sidebar → **Mi perfil** (opcional, 10 s) → **Cerrar sesión** |
| **Decir** | Cerramos la parte de administración; ahora entra un residente en otra ventana. |

---

# PARTE 2 — RESIDENTE

Sigue el **sidebar**: Mi perfil → Mis facturas → Parqueadero → Salón comunal → Gimnasio.

**Usar ventana incógnito** para no mezclar sesiones.

---

## R1 — Entrar como residente

| | |
|---|---|
| **Pantalla** | `/login` (incógnito) |
| **Hacer** | `residente_demo@conjunto.com` / `Residente123!` |

**Decir (2 frases):**

1. Mismo login, pero el sistema **solo muestra lo suyo**.
2. Asignado a **APT-101** en la demo.

---

## R2 — Mi perfil

| | |
|---|---|
| **Pantalla** | Sidebar → **Mi perfil** |
| **Hacer** | Mostrar unidades asignadas y perfil fiscal |

**Decir (2 frases):**

1. Completar **perfil fiscal** para que Factus pueda emitir.
2. Aquí también aparecen sus documentos de cobro unificados.

---

## R3 — Mis facturas (pago de administración)

| | |
|---|---|
| **Pantalla** | Sidebar → **Mis facturas** |
| **Hacer** | En factura **Pendiente** → **Pagar** → confirmar pago (mock) |
| **Hacer** | Ver que pasa a **Pagada**; opcional: descargar PDF |

**Decir (4 frases, en orden):**

1. Solo ve cuotas de **sus** unidades.
2. **Pagar** llama al servicio **Payments** (`invoice`); valida que sea su unidad.
3. Al confirmar pago → factura **Pagada**; se encola Factus si aplica.
4. Frase clave: *cada mes, cuota por coeficiente; vence un día fijo; si no paga, vencida; solo ve lo suyo.*

---

## R4 — Parqueadero de visitantes

| | |
|---|---|
| **Pantalla** | Sidebar → **Parqueadero** |
| **Hacer** | Clic en celda **libre** del calendario → **Reservar y pagar** → confirmar pago |
| **Hacer** | Mostrar **PIN** en la tabla |

**Decir (3 frases):**

1. Calendario: verde = libre; ocupado = ya reservado.
2. Cobro por **horas**; reserva queda **Pagada** y muestra **PIN** para portería.
3. Sin pago a tiempo, el worker cancela y libera el cupo.

---

## R5 — Salón comunal

| | |
|---|---|
| **Pantalla** | Sidebar → **Salón comunal** |
| **Hacer** | Elegir día en calendario → reservar → pagar (o solo mostrar flujo) |

**Decir (2 frases):**

1. Misma idea que parqueadero, pero cobro por **día**.
2. El sistema **no permite solapar** dos reservas en el mismo salón.

---

## R6 — Gimnasio

| | |
|---|---|
| **Pantalla** | Sidebar → **Gimnasio** |
| **Hacer** | Crear suscripción del mes (si no existe) → **Pagar** |

**Decir (2 frases):**

1. Una suscripción por mes; no se duplica.
2. Mismo flujo de pago (`gym_subscription`); el worker puede renovarla el mes siguiente si pagó.

---

## R7 — Cerrar sesión residente

| | |
|---|---|
| **Hacer** | **Cerrar sesión** |

---

# CIERRE (30 s)

**Decir:**

> **Residencial** une administración, reservas, gimnasio y pagos en una sola app.  
> El admin configura y supervisa; el residente paga y reserva con datos filtrados.  
> Detrás: MongoDB, backend, payments, worker automático y Factus para la DIAN.  
> ¿Preguntas?

---

# Hoja de apoyo (si preguntan)

| Pregunta | Respuesta en una línea |
|----------|------------------------|
| ¿Por qué dos APIs? | Backend = negocio; Payments = pagos (como una pasarela). |
| ¿Qué es Factus? | Proveedor de facturación electrónica DIAN. |
| ¿Base de datos? | MongoDB (local dev / Atlas prod). |
| ¿Tests? | E2E: login admin, login residente, login inválido. |
| ¿Puerto web? | **5174** con Docker. |

---

# Orden visual (resumen de un vistazo)

```
ADMIN
  A1 Login
  A2 Facturas (+ demo si vacío + morosidad + Factus)
  A3 Usuarios
  A4 Unidades
  A5 Amenidades
  A6 Reservas
  A7 Gimnasio
  A8 Logout

RESIDENTE (incógnito)
  R1 Login
  R2 Perfil
  R3 Mis facturas → Pagar
  R4 Parqueadero → PIN
  R5 Salón
  R6 Gimnasio → Pagar
  R7 Logout

CIERRE
```
