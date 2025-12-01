# ⚡ Configuración Rápida de Supabase

## 🚀 Pasos Rápidos (5 minutos)

### 1️⃣ Crear Proyecto en Supabase
```
1. Ve a https://supabase.com
2. Crea cuenta (GitHub/Google/Email)
3. Click en "New Project"
4. Nombre: marketplace-artesanal
5. Elige región y crea
```

### 2️⃣ Obtener Credenciales
```
1. Settings (⚙️) > API
2. Copia "Project URL" 
3. Copia "anon public" key
```

### 3️⃣ Configurar en Flutter
Abre: `lib/config/supabase_config.dart`

Reemplaza:
```dart
static const String supabaseUrl = 'https://TU_PROYECTO.supabase.co';
static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

### 4️⃣ Crear Base de Datos
```
1. SQL Editor > New query
2. Copia TODO el contenido de supabase_schema.sql
3. Pega y ejecuta (Run)
```

### 5️⃣ Crear Storage
```
1. Storage > Create bucket
2. Nombre: product-images
3. Marca "Public bucket" ✅
4. Create
```

### 6️⃣ Probar
```bash
flutter run
```

---

## 📖 ¿Necesitas más detalles?

Consulta la guía completa: [GUIA_CONFIGURACION_SUPABASE.md](GUIA_CONFIGURACION_SUPABASE.md)

---

## ✅ Verificación Rápida

- [ ] Proyecto creado en Supabase
- [ ] Credenciales en `supabase_config.dart`
- [ ] SQL ejecutado (tablas creadas)
- [ ] Bucket `product-images` creado
- [ ] App ejecutándose sin errores

¡Listo! 🎉

