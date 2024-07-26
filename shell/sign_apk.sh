#!/bin/bash

# 设置环境变量
export APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
export KEYSTORE_PATH="path/to/your/keystore.jks"
export KEYSTORE_PASSWORD="your_keystore_password"
export KEY_ALIAS="your_key_alias"
export KEY_PASSWORD="your_key_password"

# 生成APK
flutter build apk --release

# 检查APK是否生成成功
if [ ! -f "$APK_PATH" ]; then
    echo "APK生成失败"
    exit 1
fi

# 签名APK
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore "$KEYSTORE_PATH" \
    -storepass "$KEYSTORE_PASSWORD" -keypass "$KEY_PASSWORD" \
    "$APK_PATH" "$KEY_ALIAS"

# 优化APK
export ALIGNED_APK_PATH="${APK_PATH%.*}-aligned.apk"
zipalign -v 4 "$APK_PATH" "$ALIGNED_APK_PATH"

# 分析APK
aapt dump badging "$ALIGNED_APK_PATH"

# 显示APK大小
du -sh "$ALIGNED_APK_PATH"

echo "APK处理完成: $ALIGNED_APK_PATH"
