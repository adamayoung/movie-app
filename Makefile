TARGET = movie-api

SWIFT_CONTAINER_IMAGE = swift:5.9.2-jammy

.PHONY: clean
clean:
	swift package clean
	rm -rf docs

.PHONY: format
format:
	swiftlint --fix
	swiftformat .

.PHONY: lint
lint:
	swiftlint --strict
	swiftformat --lint .

.PHONY: lint-markdown
lint-markdown:
	markdownlint "README.md"

.PHONY: build
build:
	swift build

.PHONY: build-linux
build-linux:
	docker run --rm -v "$${PWD}:/workspace" -w /workspace $(SWIFT_CONTAINER_IMAGE) /bin/bash -cl "swift build -Xswiftc -warnings-as-errors"

.PHONY: build-release
build-release:
	swift build -c release -Xswiftc -warnings-as-errors

.PHONY: build-linux-release
build-linux-release:
	docker run --rm -v "$${PWD}:/workspace" -w /workspace $(SWIFT_CONTAINER_IMAGE) /bin/bash -cl "swift build -c release -Xswiftc -warnings-as-errors"

.PHONY: test
test:
	swift build -Xswiftc -warnings-as-errors --build-tests
	swift test --skip-build

.PHONY: test-linux
test-linux:
	docker run --rm -v "$${PWD}:/workspace" -w /workspace $(SWIFT_CONTAINER_IMAGE) /bin/bash -cl "swift build -Xswiftc -warnings-as-errors --build-tests && swift test --skip-build"

.PHONY: ci
ci: lint lint-markdown test-linux build-linux-release

