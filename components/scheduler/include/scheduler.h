#pragma once

typedef enum { SCHEDULER_TASK_1 = 0, SCHEDULER_TASK_2 = 1 } scheduler_task_t;

typedef struct {
  scheduler_task_t current_task;
  unsigned int counter;
  unsigned int quantum;
} scheduler_t;

void scheduler_init(scheduler_t *scheduler);

scheduler_task_t scheduler_current_task(const scheduler_t *scheduler);

void scheduler_tick(scheduler_t *scheduler);