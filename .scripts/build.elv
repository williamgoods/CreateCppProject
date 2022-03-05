
mkdir -p build

cd build
#cmake -G Ninja -DCMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake ..
# cmake -P ../.scripts/install_xrepo.cmake
cmake -G Ninja -DBoost_USE_STATIC_LIBS=ON .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1
#ninja clean
ninja -j 32
