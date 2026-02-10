FROM dunglas/frankenphp

WORKDIR /app

COPY . .

RUN composer install --no-dev --optimize-autoloader

RUN php artisan key:generate || true
RUN php artisan storage:link || true
RUN php artisan optimize || true

EXPOSE 8080

CMD ["frankenphp", "run", "--config", "Caddyfile"]
