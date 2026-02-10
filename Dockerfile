FROM dunglas/frankenphp:php8.2

WORKDIR /app

# Install system dependencies + Node.js
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Install JS dependencies & build assets
RUN npm install
RUN npm run build

# Laravel optimizations (AMAN)
RUN php artisan storage:link || true
RUN php artisan optimize || true

EXPOSE 8080

CMD ["frankenphp", "run", "--config", "Caddyfile"]
