#!/bin/bash
# OpenAPI 客户端生成脚本
# 用法: ./generate_api.sh

API_URL="http://localhost:8080/v3/api-docs"
OUTPUT_FILE="openapi.json"

echo "Downloading OpenAPI spec from $API_URL..."
if curl -fsSL "$API_URL" -o "$OUTPUT_FILE"; then
    echo "Downloaded successfully to $OUTPUT_FILE"
else
    echo "\033[0;31mError: Failed to download OpenAPI spec. Make sure backend is running.\033[0m"
    exit 1
fi

echo "Clearing generator cache..."
rm -f .dart_tool/openapi-generator-cache.json

echo "Updating dependencies..."
flutter pub get

echo "Generating API client..."
dart run build_runner build --delete-conflicting-outputs

echo "Fixing generated package SDK version..."
# 更新生成包的 SDK 版本与主项目一致
sed -i '' "s/sdk: '>=2.15.0 <4.0.0'/sdk: ^3.10.1/" lib/api/generated/pubspec.yaml

echo "Deleting old .g.dart files..."
find lib/api/generated -name "*.g.dart" -delete

echo "Regenerating .g.dart files with correct SDK version..."
cd lib/api/generated && dart pub get && dart run build_runner build --delete-conflicting-outputs
cd ../../..

echo "Final dependency update..."
flutter pub get

echo "\033[0;32mDone!\033[0m"
