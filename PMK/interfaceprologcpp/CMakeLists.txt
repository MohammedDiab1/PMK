cmake_minimum_required(VERSION 2.8.3)
project(interfaceprologcpp)

find_package(catkin REQUIRED COMPONENTS roscpp
  roslib
  std_msgs
  genmsg
  geometry_msgs
  )



###set (INTERFACEPROLOGCPP 0.0)
###set(CMAKE_BUILD_TYPE Release)


###include_directories(include)
###include_directories(${CMAKE_SOURCE_DIR}/src)


 include(FindPkgConfig)
 pkg_check_modules(SWIPL REQUIRED swipl)
 include_directories(${SWIPL_INCLUDE_DIRS} ${catkin_INCLUDE_DIRS} include)
 
 #generate_messages(DEPENDENCIES roscpp std_msgs geometry_msgs)
 
 catkin_package(
        INCLUDE_DIRS  include
	DEPENDS roscpp roslib geometry_msgs std_msgs)
 
 add_definitions( "--std=gnu++11" )
 
 
 ###link_directories(${SWIPL_LIBRARY_DIRS} ${catkin_INCLUDE_DIRS})
 ###include_directories(${SWIPL_INCLUDE_DIRS} ${catkin_INCLUDE_DIRS})
 ###set(EXTRA_LIBS ${EXTRA_LIBS} ${SWIPL_LIBRARIES} ${catkin_INCLUDE_DIRS})
 ###link_directories(${SWIPL_LIBRARY_DIRS} ${catkin_INCLUDE_DIRS})


#However, the file(GLOB...) allows for wildcard additions:
###file(GLOB SOURCES include/*.h)

#However, the file(GLOB...) allows for wildcard additions:
###file(GLOB SOURCES src/*.cpp)


add_library(sensing_client SHARED src/sensingClient.cpp)
target_link_libraries(sensing_client ${SWIPL_LIBRARIES} ${catkin_LIBRARIES})
add_dependencies(sensing_client
 # ${${PROJECT_NAME}_EXPORTED_TARGETS} 
  ${catkin_EXPORTED_TARGETS})
 
set_target_properties(sensing_client PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/libs)

add_executable(prolog_cpp_interface ${SOURCES} src/mainfunction.cpp)
   target_link_libraries(prolog_cpp_interface ${HEADER} ${PROJECT_LINK_LIBS} ${INCLUDE_DIRECTORIES} ${SWIPL_LIBRARIES} )
   
install(TARGETS sensing_client
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
  
  install(DIRECTORY include/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  FILES_MATCHING PATTERN "*.h*"
  PATTERN ".svn" EXCLUDE)
    
###  install(DIRECTORY include/
###  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION})
  
  install(DIRECTORY owl/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/owl)

  install(DIRECTORY prolog/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/prolog)

