
build: CMakeLists.txt src/main.cpp
	@make ProjectBuild --no-print-directory

ProjectBuild:
	@elvish .scripts/build.elv

run:
	@make ProjectRun --no-print-directory

ProjectRun:
	@cmake -P .scripts/run.cmake

clean:
	@rm -rf build
