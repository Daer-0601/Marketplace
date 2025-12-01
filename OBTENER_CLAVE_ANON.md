# 🔑 Cómo Obtener tu Clave Anon de Supabase

Ya tienes tu URL de proyecto: `https://riifvjrfcynrtbkfeoyq.supabase.co`

Ahora necesitas obtener la **clave anon** (también llamada "public key").

## 📍 Pasos para Obtener la Clave Anon

### 1. Accede a tu Dashboard de Supabase
- Ve a: https://supabase.com/dashboard
- Inicia sesión si es necesario

### 2. Selecciona tu Proyecto
- Si tienes varios proyectos, selecciona el que corresponde a:
  - ID: `riifvjrfcynrtbkfeoyq`
  - O busca el proyecto que acabas de crear

### 3. Ve a la Configuración de API
1. En el menú lateral izquierdo, busca el ícono de **Settings** (⚙️)
2. Haz clic en **Settings**
3. En el submenú, haz clic en **API**

### 4. Encuentra la Clave Anon
En la página de API verás una sección llamada **"Project API keys"** con varias claves:

- **anon** `public` ← **ESTA ES LA QUE NECESITAS** ✅
- service_role `secret` ← ⚠️ NO uses esta en Flutter

### 5. Copia la Clave Anon
1. Busca la clave que dice **"anon"** o **"public"**
2. Haz clic en el ícono de **copiar** (📋) al lado de la clave
3. Es una cadena larga que comienza con `eyJ...`

**Ejemplo de cómo se ve:**
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJpaWZ2anJmY3lucnRia2Zlb3lxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAwMDAwMDAsImV4cCI6MjAxNTU3NjAwMH0.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 6. Pega la Clave en el Código
1. Abre el archivo: `lib/config/supabase_config.dart`
2. Reemplaza `'TU_SUPABASE_ANON_KEY'` con la clave que copiaste
3. Guarda el archivo

**Resultado final debería verse así:**
```dart
static const String supabaseUrl = 'https://riifvjrfcynrtbkfeoyq.supabase.co';
static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

---

## ✅ Verificación Rápida

Una vez que hayas configurado la clave, verifica:

1. ✅ La URL está correcta: `https://riifvjrfcynrtbkfeoyq.supabase.co`
2. ✅ La clave anon comienza con `eyJ...`
3. ✅ La clave anon es larga (más de 100 caracteres)
4. ✅ No hay espacios extra en ninguna de las dos

---

## 🎯 Ubicación Visual en el Dashboard

```
Dashboard de Supabase
├── [Tu Proyecto]
    └── Settings (⚙️) ← Haz clic aquí
        └── API ← Luego aquí
            └── Project API keys
                └── anon public ← Copia esta clave
```

---

## ⚠️ Importante

- ✅ **SÍ usa** la clave **anon/public** en Flutter (es segura para el cliente)
- ❌ **NO uses** la clave **service_role** en Flutter (solo para servidor)

---

## 🆘 ¿No encuentras la clave?

Si no ves la sección de API keys:
1. Asegúrate de estar en el proyecto correcto
2. Verifica que tengas permisos de administrador
3. Intenta refrescar la página (F5)

---

¡Una vez que tengas la clave, tu app estará lista para funcionar! 🚀

