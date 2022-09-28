FVM := $(shell which fvm)
FLUTTER := $(FVM) flutter

### Flutter Commands

.PHONY: get-dependencies
get-dependencies:
	$(FLUTTER) pub get

.PHONY: clean
clean:
	$(FLUTTER) clean

.PHONY: build-runner
build-runner:
	$(FLUTTER) packages pub run build_runner build --delete-conflicting-outputs

### Test Commands

.PHONY: test-en
test-en:
	sh bin/flutter_test

.PHONY: test-ja
test-ja:
	sh bin/flutter_test ja

.PHONY: update-goldens
update-goldens:
	$(FLUTTER) test --update-goldens --tags=golden
	$(FLUTTER) test --update-goldens --tags=golden --dart-define=locale=ja

.PHONY: riverpod-graph
riverpod-graph:
	$(FVM) dart bin/src/riverpod_graph.dart

.PHONY: dartdoc
dartdoc:
	rm -rf doc/api
	dartdoc
	open doc/api/index.html

### Package Commands

.PHONY: flutter-native-splash
flutter-native-splash:
	$(FLUTTER) pub run flutter_native_splash:create

.PHONY: flutter-launcher-icons
flutter-launcher-icons:
	$(FLUTTER) pub run flutter_launcher_icons:main
