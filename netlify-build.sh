#!/bin/bash
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PWD/flutter/bin:$PATH"
flutter config --enable-web
flutter pub get
flutter build web
