# OpenAPI 客户端生成脚本
# 用法: .\generate_api.ps1

$API_URL = "http://localhost:8080/v3/api-docs"
$OUTPUT_FILE = "openapi.json"

Write-Host "Downloading OpenAPI spec from $API_URL..."
try {
    Invoke-WebRequest -Uri $API_URL -OutFile $OUTPUT_FILE -ContentType "application/json"
    Write-Host "Downloaded successfully to $OUTPUT_FILE"
} catch {
    Write-Host "Error: Failed to download OpenAPI spec. Make sure backend is running." -ForegroundColor Red
    exit 1
}

Write-Host "Generating API client..."
flutter pub run build_runner build --delete-conflicting-outputs

Write-Host "Done!" -ForegroundColor Green
