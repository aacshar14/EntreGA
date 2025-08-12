@echo off
echo Cleaning up old N8N installation...

REM Stop and remove containers
echo Stopping N8N containers...
docker-compose down

REM Remove volumes
echo Removing N8N volumes...
docker volume rm compose_n8n_data 2>nul
docker volume rm n8n_data 2>nul

REM Remove any dangling volumes
echo Cleaning up dangling volumes...
docker volume prune -f

REM Remove any old n8n images
echo Removing old N8N images...
docker rmi n8nio/n8n:latest 2>nul

echo Cleanup complete!
echo You can now start fresh with: start-n8n.bat
pause

