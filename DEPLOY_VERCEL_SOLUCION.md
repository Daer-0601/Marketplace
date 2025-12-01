# 🔧 Solución de Problemas - Despliegue en Vercel

## Error: Script exit code 1

Si el script `install-flutter.sh` falla, aquí están las soluciones:

### Opción 1: Verificar permisos del script

Asegúrate de que el script tenga permisos de ejecución:

```bash
chmod +x install-flutter.sh
git add install-flutter.sh
git commit -m "Agregar permisos de ejecución"
git push
```

### Opción 2: Usar bash directamente

El `vercel.json` ya está configurado para usar `bash install-flutter.sh` directamente, lo cual evita problemas de permisos.

### Opción 3: Build local y subir solo archivos estáticos

Si el build en Vercel sigue fallando, puedes hacer el build localmente y subir solo los archivos estáticos:

1. **Build local**:
```bash
flutter build web --release --web-renderer html
```

2. **Crear un script de deploy simple**:
```json
{
  "buildCommand": "echo 'Usando build pre-compilado'",
  "outputDirectory": "build/web"
}
```

3. **Subir solo build/web** a un branch separado o usar otro método.

### Opción 4: Usar GitHub Actions

Crea `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Vercel

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.3'
      - run: flutter pub get
      - run: flutter build web --release
      - uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
          working-directory: ./
```

## Verificar logs en Vercel

1. Ve a tu proyecto en Vercel
2. Click en el deployment fallido
3. Revisa los logs de build para ver el error específico
4. Comparte el error completo para diagnóstico

## Variables de entorno

Asegúrate de que las variables estén configuradas en Vercel:
- Settings → Environment Variables
- `SUPABASE_URL`
- `SUPABASE_KEY`

## Alternativa: Netlify

Si Vercel sigue dando problemas, Netlify tiene mejor soporte para Flutter:

1. Crea `netlify.toml`:
```toml
[build]
  command = "bash install-flutter.sh"
  publish = "build/web"

[[plugins]]
  package = "@netlify/plugin-nextjs"
```

2. Conecta tu repo a Netlify
3. Configura las variables de entorno
4. Deploy automático

