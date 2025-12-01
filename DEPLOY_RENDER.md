# 🚀 Guía de Despliegue en Render

Render es **mucho más fácil** que Vercel para aplicaciones Flutter Web. Esta guía te ayudará a desplegar tu Marketplace en Render.

## 📋 Requisitos Previos

1. **Cuenta en Render**: [https://render.com/signup](https://render.com/signup)
2. **Repositorio Git**: GitHub, GitLab o Bitbucket
3. **Variables de Supabase**: URL y clave anon

## 🚀 Pasos para Desplegar

### Paso 1: Conectar Repositorio

1. Ve a [dashboard.render.com](https://dashboard.render.com)
2. Click en **"New +"** → **"Web Service"**
3. Conecta tu repositorio de Git (GitHub/GitLab/Bitbucket)
4. Selecciona el repositorio `Marketplace`

### Paso 2: Configurar el Servicio

Configuración recomendada:

- **Name**: `marketplace` (o el nombre que prefieras)
- **Environment**: `Docker`
- **Region**: Elige la más cercana a tus usuarios (ej: `Oregon (US West)`)
- **Branch**: `main` (o tu branch principal)
- **Root Directory**: (dejar vacío)
- **Dockerfile Path**: `Dockerfile` (ya está configurado)

### Paso 3: Variables de Entorno

1. En la sección **"Environment"**, agrega las siguientes variables:

   ```
   SUPABASE_URL = https://riifvjrfcynrtbkfeoyq.supabase.co
   SUPABASE_KEY = sb_publishable_dZ0Bjel-A_5rGmeNwJNc-A_8Qqx7loQ
   ```

2. **Nota**: Las variables ya están configuradas en `render.yaml`, pero puedes cambiarlas en el dashboard si lo necesitas

### Paso 4: Deploy

1. Click en **"Create Web Service"**
2. Render comenzará a construir y desplegar automáticamente
3. ⏱️ **Primera vez**: 10-15 minutos (descarga Flutter y compila)
4. ⏱️ **Siguientes builds**: 3-5 minutos

## ✅ Verificar el Despliegue

Después del despliegue:

1. Render te dará una URL (ej: `marketplace.onrender.com`)
2. Visita la URL y verifica que la aplicación funcione
3. Revisa los logs en el dashboard si hay errores

## 🎯 Ventajas de Render sobre Vercel

1. ✅ **Más fácil**: No necesitas scripts complejos
2. ✅ **Más estable**: Mejor soporte para Flutter
3. ✅ **Menos errores**: Menos problemas técnicos
4. ✅ **Docker nativo**: Mejor para builds complejos
5. ✅ **Mejor documentación**: Guías específicas para Flutter

## 🐛 Solución de Problemas

### Error: Build timeout

Si el build tarda más de 45 minutos:
- Verifica los logs para ver dónde se detiene
- El Dockerfile está optimizado, pero el primer build puede tardar

### Error: Variables de entorno no funcionan

Asegúrate de:
1. Variables configuradas en Render (Settings → Environment)
2. Reiniciar el servicio después de agregar variables
3. Verificar que los nombres sean exactos: `SUPABASE_URL` y `SUPABASE_KEY`

### Error: Puerto no disponible

El Dockerfile ya está configurado para usar el puerto 8080, que Render asigna automáticamente. No necesitas cambiar nada.

### Error: Flutter no encontrado

El Dockerfile instala Flutter automáticamente. Si hay problemas:
- Revisa los logs de build
- Verifica que el Dockerfile esté en la raíz del proyecto

## 📝 Notas Importantes

### Free Tier

- ✅ **750 horas/mes gratis** (suficiente para desarrollo)
- ⚠️ **Se duerme después de 15 min de inactividad**
  - Se despierta automáticamente cuando alguien visita
  - Puede tardar 30-60 segundos en despertar
  - Para producción, considera el plan **Starter ($7/mes)** para que no se duerma

### HTTPS

- ✅ Render proporciona HTTPS automáticamente
- ✅ Certificado SSL gratuito

### Dominio Personalizado

Puedes agregar un dominio personalizado:
1. Settings → Custom Domains
2. Agrega tu dominio
3. Sigue las instrucciones para configurar DNS

### Auto-Deploy

- ✅ Cada push a tu branch principal despliega automáticamente
- ✅ Puedes desactivar auto-deploy en Settings si lo prefieres

## 🔄 Actualizaciones

Cada vez que hagas push a tu repositorio:
- Render detectará los cambios automáticamente
- Creará un nuevo deployment
- Te notificará cuando esté listo

## 📚 Recursos

- [Documentación de Render](https://render.com/docs)
- [Flutter Web](https://docs.flutter.dev/platform-integration/web)
- [Supabase](https://supabase.com/docs)

## 🎉 ¡Listo!

Una vez desplegado, tu aplicación estará disponible en:
- URL de Render: `https://marketplace.onrender.com` (o el nombre que elegiste)
- HTTPS automático
- Deploy automático en cada push

---

**¿Necesitas ayuda?** Revisa los logs en el dashboard de Render o consulta la documentación.

