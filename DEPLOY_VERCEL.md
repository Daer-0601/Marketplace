# 🚀 Guía de Despliegue en Vercel

Esta guía te ayudará a desplegar tu aplicación Flutter Marketplace en Vercel.

## 📋 Requisitos Previos

1. **Cuenta en Vercel**: [https://vercel.com/signup](https://vercel.com/signup)
2. **GitHub/GitLab/Bitbucket**: Tu código debe estar en un repositorio
3. **Flutter instalado localmente** (para pruebas)

## 🔧 Configuración

### 1. Preparar el Proyecto

Asegúrate de que tu proyecto esté listo:

```bash
# Verificar que Flutter Web esté habilitado
flutter config --enable-web

# Probar el build localmente
flutter build web --release
```

### 2. Variables de Entorno en Vercel

Necesitas configurar las variables de entorno de Supabase:

1. Ve a tu proyecto en Vercel
2. Settings → Environment Variables
3. Agrega las siguientes variables:

```
SUPABASE_URL=https://riifvjrfcynrtbkfeoyq.supabase.co
SUPABASE_KEY=tu_clave_anon_aqui
```

**⚠️ IMPORTANTE**: No uses la clave hardcodeada en producción. Usa variables de entorno.

### 3. Modificar `supabase_config.dart` para Vercel

Para usar variables de entorno en Vercel, necesitas modificar el archivo de configuración:

```dart
// En lib/config/supabase_config.dart
static const String supabaseUrl = String.fromEnvironment(
  'SUPABASE_URL',
  defaultValue: 'https://riifvjrfcynrtbkfeoyq.supabase.co',
);

static const String supabaseAnonKey = String.fromEnvironment(
  'SUPABASE_KEY',
  defaultValue: 'sb_publishable_dZ0Bjel-A_5rGmeNwJNc-A_8Qqx7loQ',
);
```

Y modificar el build command en `vercel.json`:

```json
"buildCommand": "flutter build web --release --web-renderer html --dart-define=SUPABASE_URL=$SUPABASE_URL --dart-define=SUPABASE_KEY=$SUPABASE_KEY"
```

## 📤 Despliegue

### Opción 1: Desde GitHub (Recomendado)

1. **Conectar repositorio**:
   - Ve a [vercel.com/new](https://vercel.com/new)
   - Conecta tu repositorio de GitHub/GitLab/Bitbucket
   - Selecciona el proyecto `marketplace`

2. **Configurar proyecto**:
   - Framework Preset: **Other**
   - Build Command: `flutter build web --release --web-renderer html`
   - Output Directory: `build/web`
   - Install Command: `flutter pub get`

3. **Variables de entorno**:
   - Agrega `SUPABASE_URL` y `SUPABASE_KEY` en la sección de Environment Variables

4. **Desplegar**:
   - Click en "Deploy"
   - Vercel construirá y desplegará automáticamente

### Opción 2: Desde CLI

```bash
# Instalar Vercel CLI
npm i -g vercel

# Login en Vercel
vercel login

# Desplegar
vercel

# Para producción
vercel --prod
```

## 🔍 Verificar el Despliegue

Después del despliegue:

1. Vercel te dará una URL (ej: `marketplace.vercel.app`)
2. Visita la URL y verifica que la aplicación funcione
3. Revisa los logs en el dashboard de Vercel si hay errores

## 🐛 Solución de Problemas

### Error: Flutter no encontrado

Si Vercel muestra "flutter: command not found", el script `install-flutter.sh` se ejecutará automáticamente durante el build para instalar Flutter.

**Nota**: El primer build puede tardar más tiempo (10-15 minutos) porque necesita:
1. Descargar Flutter (~1GB)
2. Instalar dependencias
3. Compilar la aplicación

Los builds subsecuentes serán más rápidos (3-5 minutos) porque Flutter ya estará en caché.

### Error: Variables de entorno no funcionan

Asegúrate de que:
1. Las variables estén configuradas en Vercel
2. El build command use `--dart-define` correctamente
3. Reinicia el deployment después de agregar variables

### Error: Build falla

Revisa los logs en Vercel:
1. Ve a tu proyecto → Deployments
2. Click en el deployment fallido
3. Revisa los logs de build

## 📝 Notas Importantes

1. **Primera vez**: El primer build puede tardar más (5-10 minutos) porque Vercel necesita instalar Flutter
2. **Builds subsecuentes**: Serán más rápidos (2-3 minutos)
3. **Dominio personalizado**: Puedes agregar un dominio personalizado en Settings → Domains
4. **HTTPS**: Vercel proporciona HTTPS automáticamente

## 🔄 Actualizaciones

Cada vez que hagas push a tu repositorio:
- Vercel detectará los cambios automáticamente
- Creará un nuevo deployment
- Te notificará cuando esté listo

## 📚 Recursos

- [Documentación de Vercel](https://vercel.com/docs)
- [Flutter Web](https://docs.flutter.dev/platform-integration/web)
- [Supabase](https://supabase.com/docs)

