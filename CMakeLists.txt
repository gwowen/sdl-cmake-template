cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
# cmake_policy(VERSION 3.10)

project(SDLTestStuff)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose build type (Debug/Release)" FORCE)
endif(NOT CMAKE_BUILD_TYPE)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules")

list(APPEND CMAKE_CXX_FLAGS "-std=c++17 -O3")

include(FindPkgConfig)
PKG_SEARCH_MODULE(SDL2 REQUIRED sdl2)
INCLUDE_DIRECTORIES(${SDL2_INCLUDE_DIRS})
set(LIBS ${SDL2_LIBRARIES})


find_package(GLM REQUIRED)
message(STATUS "Found GLM in ${GLM_INCLUDE_DIR}")
find_package(Vulkan REQUIRED)

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall")
find_package(X11 REQUIRED)
#set(LIBS ${GLFW3_LIBRARY} ${FREETYPE_LIBRARIES} X11 Xrandr Xinerama Xi Xxf86vm Xcursor dl pthread)
set(THINGS
    test
)

configure_file(configuration/root_directory.h.in configuration/root_directory.h)
include_directories(${CMAKE_BINARY_DIR}/configuration)

# add_library(STB_IMAGE "stb/stb_image.cpp")
# set(LIBS ${LIBS} STB_IMAGE)

# add_library(TINY_OBJ_LOADER "tiny_obj_loader/tiny_obj_loader.cpp")
# set(LIBS ${LIBS} TINY_OBJ_LOADER)

foreach(THING ${THINGS})

    file(GLOB SOURCE
        "src/${THING}/*.h"
        "src/${THING}/*.cpp"
    )
    set(NAME "${THING}")
    add_executable(${NAME} ${SOURCE})
    target_include_directories(${NAME} PRIVATE Vulkan::Vulkan)
    target_link_libraries(${NAME} ${LIBS} Vulkan::Vulkan)
    # copy shaders to the bin directory
    set_target_properties(${NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin/${THING}")
    file(GLOB SHADERS
            "shaders/${THING}/*.spv"
    )

        foreach(SHADER ${SHADERS})
            file(COPY ${SHADER} DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/bin/${THING}")
        endforeach(SHADER)

    # copy textures to the bin directory
    file(GLOB PICS
        "resources/textures/${THING}/*.png"
        "resources/textures/${THING}/*.jpg"
    )

        foreach(PIC ${PICS})
            file(COPY ${PIC} DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/bin/${THING}")
        endforeach(PIC)
    
    # copy models to the bin directory
    file(GLOB MODELS
    "resources/models/${THING}/*.obj"
    )

    foreach(MODEL ${MODELS})
        file(COPY ${MODEL} DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/bin/${THING}")
    endforeach(MODEL)

    # copy levels to the bin directory
    file(GLOB FONTS
        "resources/fonts/*.ttf"
    )

        foreach(FONT ${FONTS})
            file(COPY ${FONT} DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/bin/${THING})
        endforeach(FONT)
    endforeach(THING)


include_directories(${CMAKE_SOURCE_DIR}/includes)