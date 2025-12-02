# Dockerfile para Flutter Web en Render
FROM ubuntu:22.04

# Evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    python3 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Configurar git para evitar problemas de permisos
RUN git config --global --add safe.directory '*'

# Instalar Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter

# Crear wrapper para tar que ignore errores de ownership
# Debe estar en un directorio que esté antes en el PATH que /usr/bin
RUN echo '#!/bin/sh\n/usr/bin/tar --no-same-owner --no-same-permissions "$@"' > /usr/local/flutter/bin/tar-wrapper && \
    chmod +x /usr/local/flutter/bin/tar-wrapper && \
    ln -sf /usr/local/flutter/bin/tar-wrapper /usr/local/bin/tar

# Agregar Flutter al PATH (el wrapper de tar está en /usr/local/bin)
ENV PATH="/usr/local/bin:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Configurar git para el directorio de Flutter
RUN git config --global --add safe.directory '/usr/local/flutter'

# Configurar Flutter
ENV FLUTTER_STORAGE_BASE_URL=https://storage.googleapis.com
ENV PUB_HOSTED_URL=https://pub.dartlang.org

# Verificar instalación básica (solo versión, sin doctor)
RUN flutter --version

# Configurar directorio de trabajo
WORKDIR /app

# Copiar archivos del proyecto
COPY pubspec.yaml pubspec.lock ./
COPY lib ./lib
COPY web ./web
COPY analysis_options.yaml ./

# Habilitar Flutter Web
RUN flutter config --enable-web --no-analytics

# Instalar dependencias de Flutter
# El wrapper de tar ya maneja los problemas de ownership
RUN flutter pub get

# Build de la aplicación web
# Declarar ARG para recibir variables durante el build
# Render las pasa automáticamente, pero usamos valores por defecto por seguridad
ARG SUPABASE_URL=https://riifvjrfcynrtbkfeoyq.supabase.co
ARG SUPABASE_KEY=sb_publishable_dZ0Bjel-A_5rGmeNwJNc-A_8Qqx7loQ

# Build con las variables
RUN flutter build web --release --web-renderer html \
    --dart-define=SUPABASE_URL="${SUPABASE_URL}" \
    --dart-define=SUPABASE_KEY="${SUPABASE_KEY}"

# Exponer puerto
EXPOSE 8080

# Cambiar al directorio de build y servir archivos
WORKDIR /app/build/web
CMD ["python3", "-m", "http.server", "8080"]
