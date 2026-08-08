#include <stdio.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "scheduler.h"

static scheduler_t scheduler;

static volatile int counter_1 = 0;
static volatile int counter_2 = 0;

static void task_1(void *arg) {
  while (1) {

    if (scheduler_current_task(&scheduler) == SCHEDULER_TASK_1) {

      counter_1++;

      printf("TASK 1: counter = %d\n", counter_1);

      scheduler_tick(&scheduler);
    }

    vTaskDelay(pdMS_TO_TICKS(100));
  }
}

static void task_2(void *arg) {
  while (1) {

    if (scheduler_current_task(&scheduler) == SCHEDULER_TASK_2) {

      counter_2++;

      printf("TASK 2: counter = %d\n", counter_2);

      scheduler_tick(&scheduler);
    }

    vTaskDelay(pdMS_TO_TICKS(100));
  }
}

void app_main(void) {
  scheduler_init(&scheduler);

  xTaskCreate(task_1, "task_1", 4096, NULL, 5, NULL);

  xTaskCreate(task_2, "task_2", 4096, NULL, 5, NULL);
}