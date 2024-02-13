# Copyright 2022 Open Source Robotics Foundation, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include(FindPackageHandleStandardArgs)
find_package(soem CONFIG QUIET)
if(SOEM_FOUND)
  find_package_handle_standard_args(SOEM FOUND_VAR SOEM_FOUND CONFIG_MODE)
else()
  # Otherwise, rely on pkg-config
  find_package(PkgConfig QUIET)

  if(PKG_CONFIG_FOUND)
    # pkg_check_modules(SOEM_PKG_CONFIG IMPORTED_TARGET soem-0.1)
    find_package_handle_standard_args(SOEM DEFAULT_MSG SOEM_PKG_CONFIG_FOUND)

    if(SOEM_FOUND)
      if(NOT TARGET SOEM)
        add_library(SOEM INTERFACE IMPORTED)
        set_property(TARGET SOEM PROPERTY INTERFACE_LINK_LIBRARIES PkgConfig::SOEM_PKG_CONFIG)
      endif()
      set(SOEM_LIBRARIES SOEM)
      set(SOEM_VERSION ${SOEM_PKG_CONFIG_VERSION})
    endif()
  endif()
endif()
