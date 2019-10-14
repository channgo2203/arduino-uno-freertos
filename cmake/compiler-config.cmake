# Generate compile_commands.json to be consumed by code completion tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# -fPIC
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set_property(GLOBAL PROPERTY GLOBAL_DEPENDS_NO_CYCLES 1)

# Add options from Ottomatika build
add_compile_options(-Wall
                    -Wextra
                    -g
                    -Os
                    -pie)
