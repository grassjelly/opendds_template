cmake_minimum_required(VERSION 2.8)
project( opendds_template )

set(TEMP_CXX_FLAGS  ${CMAKE_CXX_FLAGS} )
set(CMAKE_CXX_FLAGS "-std=c++11 -O3 ${TEMP_CXX_FLAGS}")  # TODO: Up the optimization level
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -DDEBUG -Wall")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Wall")

include_directories( ${CMAKE_SOURCE_DIR}/lib )
include_directories( ${CMAKE_SOURCE_DIR}/src )
include_directories( ${CMAKE_SOURCE_DIR}/gen )

set( DDS_ROOT "/root/OpenDDS" )
set( ACE_ROOT "/root/OpenDDS/ACE_wrappers" )
set( MPC_ROOT "/root/OpenDDS/ACE_wrappers/MPC" )
set( TAO_ROOT "/root/OpenDDS/ACE_wrappers/TAO" )

include_directories( ${DDS_ROOT} )
include_directories( ${DDS_ROOT}/dds )
include_directories( ${ACE_ROOT} )
include_directories( ${ACE_ROOT}/ace )
include_directories( ${MPC_ROOT} )
include_directories( ${TAO_ROOT} )
include_directories( ${TAO_ROOT}/orbsvcs )

file( GLOB OPENDDS_LIBS
						${DDS_ROOT}/dds/libOpenDDS_Dcps.so
						${ACE_ROOT}/lib/libTAO_AnyTypeCode.so
						${ACE_ROOT}/lib/libTAO.so
						${ACE_ROOT}/lib/libACE.so
)

add_library(source
					src/DataReaderListenerImpl.cpp
					gen/MessengerC.cpp
					gen/MessengerS.cpp
					gen/MessengerTypeSupportC.cpp
					gen/MessengerTypeSupportImpl.cpp
					gen/MessengerTypeSupportS.cpp
)

add_executable(template_app src/Publisher.cpp)
target_link_libraries(template_app ${OPENDDS_LIBS} source)
