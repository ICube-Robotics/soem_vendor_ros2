cmake_minimum_required(VERSION 3.10)
project(soem_vendor_ros2)
set(SOEM_VERSION "1.4.0")

# Default to C++17
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 17)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

find_package(ament_cmake REQUIRED)
find_package(ament_cmake_vendor_package REQUIRED)

list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules")
find_package(soem ${SOEM_VERSION} EXACT QUIET)

ament_vendor(soem_vendor_ros2
  SATISFIED ${soem_FOUND}
  VCS_URL https://github.com/OpenEtherCATsociety/SOEM.git
  VCS_VERSION v${SOEM_VERSION}
  # CMAKE_ARGS "-DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}$<$<BOOL:${MSVC}>: /wd4244 /wd4267 /wd4996>"
)
ament_export_dependencies(soem)

if(BUILD_TESTING)
  find_package(ament_cmake_test REQUIRED)
  find_package(ament_lint_auto REQUIRED)
  set(ament_cmake_copyright_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()

  # TODO(tpoignonec): more tests...
  # See https://github.com/ros2/libyaml_vendor/blob/rolling/CMakeLists.txt for an example
endif()

install(DIRECTORY cmake DESTINATION share/${PROJECT_NAME})

ament_package(CONFIG_EXTRAS soem_vendor_ros2-extras.cmake)
