# 🔐 Configuración con Variables de Entorno

Tu proyecto está configurado para usar variables de entorno, lo cual es más seguro.

## 🚀 Opción 1: Usar --dart-define (Recomendado)

### Para ejecutar la app:

**Windows (PowerShell):**
```powershell
flutter run --dart-define=SUPABASE_KEY=tu_clave_anon_aqui
```

**Windows (CMD):**
```cmd
flutter run --dart-define=SUPABASE_KEY=tu_clave_anon_aqui
```

**Linux/Mac:**
```bash
flutter run --dart-define=SUPABASE_KEY=tu_clave_anon_aqui
```

### Ejemplo completo:
```bash
flutter run --dart-define=SUPABASE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJpaWZ2anJmY3lucnRia2Zlb3lxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAwMDAwMDAsImV4cCI6MjAxNTU3NjAwMH0.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

## 📝 Opción 2: Configurar directamente en el código

Si prefieres no usar variables de entorno (solo para desarrollo):

1. Abre `lib/config/supabase_config.dart`
2. Reemplaza `'TU_SUPABASE_ANON_KEY_AQUI'` con tu clave anon
3. Ejecuta normalmente: `flutter run`

---

## 🎯 Crear Scripts para Facilitar

### Windows - Crear `run.bat`:

Crea un archivo `run.bat` en la raíz del proyecto:

```batch
@echo off
flutter run --dart-define=SUPABASE_KEY=TU_CLAVE_ANON_AQUI
```

Luego ejecuta: `run.bat`

### Linux/Mac - Crear `run.sh`:

Crea un archivo `run.sh` en la raíz del proyecto:

```bash
#!/bin/bash
flutter run --dart-define=SUPABASE_KEY=TU_CLAVE_ANON_AQUI
```

Hazlo ejecutable:
```bash
chmod +x run.sh
```

Luego ejecuta: `./run.sh`

---

## 🔒 Para Producción (Build)

### Android:
```bash
flutter build apk --dart-define=SUPABASE_KEY=tu_clave_aqui
```

### iOS:
```bash
flutter build ios --dart-define=SUPABASE_KEY=tu_clave_aqui
```

### Web:
```bash
flutter build web --dart-define=SUPABASE_KEY=tu_clave_aqui
```

---

## ⚠️ Importante - Seguridad

### ✅ HACER:
- Usar `--dart-define` para builds de producción
- Mantener la clave fuera del código fuente
- Usar CI/CD para inyectar la clave en builds

### ❌ NO HACER:
- Subir la clave anon a repositorios públicos
- Hardcodear la clave en el código si vas a compartirlo
- Usar la clave `service_role` en el cliente

---

## 🛠️ Configuración en VS Code

Puedes configurar VS Code para ejecutar con la variable automáticamente:

1. Crea `.vscode/launch.json`:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define=SUPABASE_KEY=TU_CLAVE_ANON_AQUI"
      ]
    }
  ]
}
```

2. Reemplaza `TU_CLAVE_ANON_AQUI` con tu clave real

---

## 📋 Checklist

- [ ] Obtuviste tu clave anon de Supabase
- [ ] Configuraste la variable de entorno o el valor por defecto
- [ ] La app se ejecuta sin errores
- [ ] Puedes iniciar sesión y crear productos

---

## 🆘 Solución de Problemas

### Error: "Debes configurar SUPABASE_KEY"
- **Causa**: No configuraste la clave
- **Solución**: Usa `--dart-define` o reemplaza el valor por defecto

### Error: "Invalid API key"
- **Causa**: La clave está incorrecta
- **Solución**: Verifica que copiaste la clave completa sin espacios

### La clave no se aplica
- **Causa**: Sintaxis incorrecta en --dart-define
- **Solución**: Asegúrate de usar `--dart-define=SUPABASE_KEY=valor` (sin espacios alrededor del `=`)

---

¡Listo! Ahora puedes ejecutar tu app de forma segura. 🚀

