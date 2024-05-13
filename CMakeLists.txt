cmake_minimum_required(VERSION 3.16)

project(plasma_audio_device_switcher)

set(PROJECT_VERSION "6.0.0")
set(PROJECT_VERSION_MAJOR 6)

set(KF6_MIN_VERSION "6.0.0")

find_package(ECM ${KF6_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})


find_package(KF6 ${KF6_MIN_VERSION} REQUIRED COMPONENTS)
find_package(Plasma ${KF5_MIN_VERSION} REQUIRED)

add_subdirectory(package)

