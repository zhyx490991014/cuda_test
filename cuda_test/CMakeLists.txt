cmake_minimum_required(VERSION 3.5.0)
project(cuda_test)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(CUDA REQUIRED)

include_directories(
  ${PROJECT_SOURCE_DIR}
)

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR})

# cuda生成静态库
aux_source_directory(${PROJECT_SOURCE_DIR}/cuda_src CUDA_SRC)
cuda_add_library(cudasrc STATIC
${CUDA_SRC}
)

# 生成可执行文件，应该用的还是gcc吧？
aux_source_directory(${PROJECT_SOURCE_DIR}/src SRC)
add_executable(${PROJECT_NAME}
${SRC}
)

target_link_libraries(${PROJECT_NAME}
cudasrc
${CUDA_LIBRARIES}
)

