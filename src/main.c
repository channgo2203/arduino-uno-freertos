/*
 * FreeRTOS port for ATmega328P
 * https://yalneb.blogspot.com
 */ 

// LIBRARIES
#include "FreeRTOS.h"
#include "task.h"
#include <avr/io.h>


// EXAMPLE BLINKER TASK
void blinkLED(void* parameter)
{
	DDRB |= (1 << PB5);		// PB.5 as output
	for (;;)
	{
		PORTB &= ~(1 << PB5);	// Turn LED on
		vTaskDelay(250);	// Wait
		PORTB |= (1 << PB5);	// Turn LED off
		vTaskDelay(250);	// Wait
	}
}

// MAIN PROGRAM
int main(void)
{
	// CREATE BLINKER TASK
	xTaskCreate(blinkLED, "blink", configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY, NULL);

	// START SCHELUDER
	vTaskStartScheduler();
 
	return 0;
}

// IDLE TASK
void vApplicationIdleHook(void)
{
	// THIS RUNS WHILE NO OTHER TASK RUNS
}
