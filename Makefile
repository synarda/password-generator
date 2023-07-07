json:
	flutter pub run build_runner build --delete-conflicting-outputs

splashicon:
	flutter clean
	flutter pub get
	flutter pub run flutter_native_splash:create
	flutter pub run flutter_launcher_icons:main

translate:
	python3 -Xutf8 lib/lang/xml_to_dart.py
