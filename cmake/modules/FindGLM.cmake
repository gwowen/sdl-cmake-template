SET(_glm_HEADER_SEARCH_DIRS
"/usr/include"
"/usr/local/include"
"${CMAKE_SOURCE_DIR}/includes"
"C:/Program Files (x86)/glm")

# check environment variables
set(_glm_ENV_ROOT_DIR "$ENV{GLM_ROOT_DIR}")
if(NOT GLM_ROOT_DIR AND _glm_ENV_ROOT_DIR)
    set(GLM_ROOT_DIR "${_glm_ENV_ROOT_DIR}")
endif(NOT GLM_ROOT_DIR AND _glm_ENV_ROOT_DIR)

# put user specified location at beginning of search
if(GLM_ROOT_DIR)
    set(_glm_HEADER_SEARCH_DIRS "${GLM_ROOT_DIR}"
    "${GLM_ROOT_DIR}/include"
    ${_glm_HEADER_SEARCH_DIRS})
endif(GLM_ROOT_DIR)

# locate header
find_path(GLM_INCLUDE_DIR "glm/glm.hpp"
PATHS ${_glm_HEADER_SEARCH_DIRS})
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(GLM DEFAULT_MSG
GLM_INCLUDE_DIR)
if(GLM_FOUND)
    set(GLM_INCLUDE_DIRS "${GLM_INCLUDE_DIR}")
    MESSAGE(STATUS "GLM_INCLUDE_DIR = ${GLM_INCLUDE_DIR}")
endif(GLM_FOUND)