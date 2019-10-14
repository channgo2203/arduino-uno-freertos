# Processor specification, possible values:...
set(CMAKE_SYSTEM_PROCESSOR atmega328p)
# Specify arch to be aarch64le
set(arch avr-gcc)
set(ARCH_NAME atmega328p)

set(CMAKE_C_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -DF_CPU=16000000UL -mmcu=atmega328p")
set(CMAKE_CXX_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -DF_CPU=16000000UL -mmcu=atmega328p")

# Command settings for QNX
include(${CMAKE_CURRENT_LIST_DIR}/avr.cmake)
