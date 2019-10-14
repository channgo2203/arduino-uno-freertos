# Cross compilation for AVR
set(CMAKE_SYSTEM_NAME AVR)

# Upstream settings
set(CMAKE_C_COMPILER avr-gcc)
set(CMAKE_C_COMPILER_TARGET ${arch})
set(CMAKE_CXX_COMPILER avr-g++)
set(CMAKE_CXX_COMPILER_TARGET ${arch})

# Set the path to the avr include and lib
