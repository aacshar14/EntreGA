@echo off
echo Setting up fresh N8N installation...

REM Generate a random encryption key (32 characters)
echo Generating encryption key...
set /a "rand=%random%"
set "encryption_key="
for /l %%i in (1,1,32) do (
    set /a "char=%random% %% 62"
    if !char! lss 26 (
        set "encryption_key=!encryption_key!!char!"
    ) else if !char! lss 52 (
        set /a "char=!char! + 65"
        cmd /c exit !char!
        set "encryption_key=!encryption_key!!exitcodeascii!"
    ) else (
        set /a "char=!char! - 52 + 48"
        set "encryption_key=!encryption_key!!char!"
    )
)

echo Generated encryption key: !encryption_key!

REM Update docker-compose.yml with the generated key
echo Updating docker-compose.yml with encryption key...
powershell -Command "(Get-Content docker-compose.yml) -replace 'your-32-character-encryption-key-here', '!encryption_key!' | Set-Content docker-compose.yml"

echo Starting N8N...
docker-compose up -d

echo.
echo N8N is now starting up!
echo Access it at: http://localhost:5678
echo.
echo To check status: docker-compose ps
echo To view logs: docker-compose logs -f n8n
pause

