#include "scheduler.h"

void scheduler_init(scheduler_t *scheduler) {
  scheduler->current_task = SCHEDULER_TASK_1;
  scheduler->counter = 0;
  scheduler->quantum = 10;
}

scheduler_task_t scheduler_current_task(const scheduler_t *scheduler) {
  return scheduler->current_task;
}

void scheduler_tick(scheduler_t *scheduler) {
  scheduler->counter++;

  if (scheduler->counter >= scheduler->quantum) {
    scheduler->counter = 0;

    if (scheduler->current_task == SCHEDULER_TASK_1) {
      scheduler->current_task = SCHEDULER_TASK_2;
    } else {
      scheduler->current_task = SCHEDULER_TASK_1;
    }
  }
}