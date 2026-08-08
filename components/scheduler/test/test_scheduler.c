#include "scheduler.h"
#include "unity.h"

TEST_CASE("scheduler starts with task 1", "[scheduler]") {
  scheduler_t scheduler;

  scheduler_init(&scheduler);

  TEST_ASSERT_EQUAL(SCHEDULER_TASK_1, scheduler_current_task(&scheduler));
}

TEST_CASE("scheduler stays on task 1 for ten ticks", "[scheduler]") {
  scheduler_t scheduler;

  scheduler_init(&scheduler);

  for (int i = 0; i < 9; i++) {
    scheduler_tick(&scheduler);

    TEST_ASSERT_EQUAL(SCHEDULER_TASK_1, scheduler_current_task(&scheduler));
  }
}

TEST_CASE("scheduler switches to task 2 after ten ticks", "[scheduler]") {
  scheduler_t scheduler;

  scheduler_init(&scheduler);

  for (int i = 0; i < 10; i++) {
    scheduler_tick(&scheduler);
  }

  TEST_ASSERT_EQUAL(SCHEDULER_TASK_2, scheduler_current_task(&scheduler));
}

TEST_CASE("scheduler switches back to task 1", "[scheduler]") {
  scheduler_t scheduler;

  scheduler_init(&scheduler);

  for (int i = 0; i < 20; i++) {
    scheduler_tick(&scheduler);
  }

  TEST_ASSERT_EQUAL(SCHEDULER_TASK_1, scheduler_current_task(&scheduler));
}