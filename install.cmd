:: 同步配置文件
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0create-hardlink.ps1"

:: 安装Git钩子
pre-commit install

pause
