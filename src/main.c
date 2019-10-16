/*
 * FreeRTOS port for ATmega328P
 * https://yalneb.blogspot.com
 */ 

// LIBRARIES
#include "FreeRTOS.h"
#include "task.h"
#include <avr/io.h>

void taskLedON(void* arguments)
{
   // ENTER TASK'S LOOP
   while(1)
   {
      PORTB |= (1 << PB5);    // Turn LED on
      vTaskDelay(500);        // Wait 500ms
	}
}


void taskLedOFF(void* arguments)
{
   // ENTER TASK'S LOOP
   while(1)
   {
      PORTB &= ~(1 << PB5);    // Turn LED off
      vTaskDelay(250);        // Wait 250ms
   }
}

// MAIN PROGRAM
int main(void)
{
	// CONFIGURE PORT B, PIN 5 AS OUTPUT (my LED is here)
   DDRB |= (1 << PB5);
	
	// CREATE ON TASK
   xTaskCreate(taskLedON,
               "ON",
               configMINIMAL_STACK_SIZE, 
               NULL, 
               tskIDLE_PRIORITY,
               NULL);

   // CREATE OFF TASK   
   xTaskCreate(taskLedOFF, 
               "OFF", 
               configMINIMAL_STACK_SIZE, 
               NULL,  
               tskIDLE_PRIORITY+1, 
               NULL);
	
	// START SCHELUDER
	vTaskStartScheduler();
 
	return 0;
}

// IDLE TASK
void vApplicationIdleHook(void)
{
	// THIS RUNS WHILE NO OTHER TASK RUNS
}
