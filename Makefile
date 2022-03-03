
build: CMakeLists.txt main.cpp
	@make ProjectBuild --no-print-directory

ProjectBuild:
	@bash .scripts/build.sh

run:
	@make ProjectRun --no-print-directory

ProjectRun:
	@bash .scripts/run.sh

clean:
	@rm -rf build
