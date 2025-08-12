@echo off
echo Configurando N8N para Cloudflare...
echo.

set /p "domain=Ingresa tu dominio (ejemplo: midominio.com): "
set /p "subdomain=Ingresa el subdominio para N8N (ejemplo: n8n): "
set /p "password=Ingresa una contraseña segura para N8N: "

echo.
echo Configurando para: %subdomain%.%domain%
echo.

REM Update docker-compose.yml with the real domain
echo Actualizando docker-compose.yml...
powershell -Command "(Get-Content docker-compose.yml) -replace 'n8n.tudominio.com', '%subdomain%.%domain%' | Set-Content docker-compose.yml"
powershell -Command "(Get-Content docker-compose.yml) -replace 'tu_password_seguro', '%password%' | Set-Content docker-compose.yml"

echo.
echo Configuracion completada!
echo.
echo Ahora necesitas:
echo 1. Crear un registro A en Cloudflare apuntando a tu IP publica
echo 2. Configurar el proxy de Cloudflare (nube naranja)
echo 3. Ejecutar: setup-n8n.bat
echo.
echo Tu N8N estara disponible en: https://%subdomain%.%domain%
pause

