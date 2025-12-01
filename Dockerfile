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
    && rm -rf /var/lib/apt/lists/*

# Instalar Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Configurar git para evitar problemas de permisos
RUN git config --global --add safe.directory '*'

# Verificar instalación
RUN flutter doctor -v

# Configurar directorio de trabajo
WORKDIR /app

# Copiar archivos del proyecto
COPY pubspec.yaml pubspec.lock ./
COPY lib ./lib
COPY web ./web
COPY analysis_options.yaml ./

# Instalar dependencias de Flutter
RUN flutter pub get

# Build de la aplicación web
# Las variables de entorno se pasan desde Render
# Declaramos ARG para que estén disponibles durante el build
ARG SUPABASE_URL
ARG SUPABASE_KEY
ENV SUPABASE_URL=${SUPABASE_URL}
ENV SUPABASE_KEY=${SUPABASE_KEY}

RUN flutter build web --release --web-renderer html \
    --dart-define=SUPABASE_URL=${SUPABASE_URL} \
    --dart-define=SUPABASE_KEY=${SUPABASE_KEY}

# Exponer puerto
EXPOSE 8080

# Cambiar al directorio de build y servir archivos
WORKDIR /app/build/web
CMD ["python3", "-m", "http.server", "8080"]

