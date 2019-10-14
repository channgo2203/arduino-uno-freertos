#!/bin/bash
# Copy to HEX format and download the given binary from a host machine to Arduino boards

binaryFile=""
boardName=""
serialPort=""

# Function that prints usage of this script
function printUsage() {
    echo "Usage: $0 [Options]"
    echo "  -f"
    echo "          The binary for downloading"
    echo "  -b"
    echo "          The Arduino board name"
    echo "  -p"
    echo "          The serial port"
    echo "  -h help"
    echo "Example:"
    echo "  $0 -f <binary_file_with_path> -b <board_name> -p <serial_port>"
}

# Get arguments
while getopts ":f:b:p:lh" options; do
    case $options in
        f)  binaryFile=$OPTARG;;
        b)  boardName=$OPTARG;;
        p)  serialPort=$OPTARG;;
        h)  printUsage
            exit 1;;
        *)  printUsage
            exit 1;;
    esac
done

# Check if the arguments are given
if [ -z "$binaryFile" ]; then
    printUsage
    exit 1
fi

if [ -z "$boardName" ]; then
    printUsage
    exit 1
fi

if [ -z "$serialPort" ]; then
    printUsage
    exit 1
fi

# Copy the binary into HEX format with avr-objcopy
avr-objcopy -O ihex -R .eeprom ${binaryFile} ${binaryFile}.hex

# Download the HEX file with avrdude
avrdude -F -V -c arduino -p ${boardName} -P ${serialPort} -b 115200 -U flash:w:${binaryFile}.hex
