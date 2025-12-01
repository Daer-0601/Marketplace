# 📧 Deshabilitar Confirmación de Email en Supabase

El error 400 al iniciar sesión puede deberse a que Supabase requiere confirmación de email. Para desarrollo, puedes deshabilitarla.

## 🔧 Pasos para Deshabilitar Confirmación de Email

### 1. Ir a Configuración de Autenticación

1. Ve a tu dashboard de Supabase: https://supabase.com/dashboard
2. Selecciona tu proyecto
3. En el menú lateral, ve a **Authentication** (🔐)
4. Haz clic en **Settings** (⚙️) dentro de Authentication

### 2. Deshabilitar Confirmación de Email

1. Busca la sección **"Email Auth"** o **"Email"**
2. Busca la opción **"Enable email confirmations"** o **"Confirm email"**
3. **Desmarca** la casilla para deshabilitarla
4. Haz clic en **"Save"** o **"Update"**

### 3. Verificar

1. Intenta registrarte con un nuevo usuario
2. Deberías poder iniciar sesión inmediatamente sin confirmar email

---

## ⚠️ Alternativa: Confirmar Email Manualmente

Si prefieres mantener la confirmación habilitada:

1. Ve a **Authentication > Users** en Supabase
2. Busca el usuario que quieres confirmar
3. Haz clic en los **tres puntos** (⋯) junto al usuario
4. Selecciona **"Confirm user"** o **"Send confirmation email"**

---

## 🔍 Verificar Estado del Usuario

Para ver si un usuario está confirmado:

1. Ve a **Authentication > Users**
2. Busca el usuario
3. Verifica la columna **"Confirmed"** o **"Email Confirmed"**
4. Si dice "No", ese es el problema

---

## 💡 Solución Rápida

**Para desarrollo/testing:**
- Deshabilita la confirmación de email (recomendado para pruebas)

**Para producción:**
- Mantén la confirmación habilitada
- Configura el envío de emails correctamente

---

¡Después de deshabilitar la confirmación, el login debería funcionar! 🎉

