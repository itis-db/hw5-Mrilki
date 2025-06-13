-- Задание 1
CREATE TABLE transactions (
                              id SERIAL PRIMARY KEY,
                              date DATE NOT NULL,
                              amount NUMERIC(10,2) NOT NULL
);

SELECT
    date,
    amount,
    SUM(amount) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum
FROM transactions;

-- Задание 2
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          category VARCHAR(50) NOT NULL,
                          price NUMERIC(10,2) NOT NULL
);

SELECT
    id,
    category,
    price,
    price - AVG(price) OVER (PARTITION BY category) AS deviation_from_avg
FROM products;

-- Задание 3

CREATE TABLE temperature_logs (
                                  log_time TIMESTAMP PRIMARY KEY,
                                  temperature NUMERIC(5,2) NOT NULL
);

SELECT
    log_time,
    temperature,
    ROUND(AVG(temperature) OVER (
        ORDER BY log_time
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2) AS moving_avg_3
FROM temperature_logs;


-- Задание 4
CREATE TABLE project_tasks (
                               task_id SERIAL PRIMARY KEY,
                               project_id INTEGER NOT NULL,
                               start_date DATE NOT NULL
);

SELECT
    task_id,
    project_id,
    start_date,
    FIRST_VALUE(start_date) OVER (PARTITION BY project_id ORDER BY start_date) AS first_task_date,
    LAST_VALUE(start_date) OVER (
        PARTITION BY project_id
        ORDER BY start_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS last_task_date
FROM project_tasks;