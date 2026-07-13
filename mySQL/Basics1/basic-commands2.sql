-- Setup a fresh database environment

create DATABASE if not EXISTS basic_commands;

use basic_commands;



-- 1. CREATE
CREATE TABLE data_pipeline_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    step_name VARCHAR(50),
    rows_processed INT,
    status VARCHAR(20)
);

-- 2. INSERT
INSERT INTO data_pipeline_logs (step_name, rows_processed, status) VALUES 
('ETL_Extract', 50000, 'Success'),
('Transformation_Step', 49800, 'Running'),
('Model_Prediction', 0, 'Pending');


alter table data_pipeline_logs add column duration_seconds float(10,2);

alter table data_pipeline_logs modify column duration_seconds  float(10,2) DEFAULT 0.3;

update data_pipeline_logs 
set status = "Success", duration_seconds = 23.4
where step_name = "ETL_Extract";


select * from data_pipeline_logs;


-- 3. ALTER
ALTER TABLE data_pipeline_logs ADD COLUMN duration_seconds FLOAT DEFAULT 0.0;

-- 4. UPDATE
UPDATE data_pipeline_logs 
SET status = 'Success', duration_seconds = 142.5 
WHERE step_name = 'Transformation_Step';

-- 5. SELECT
SELECT step_name, rows_processed, status 
FROM data_pipeline_logs 
WHERE status = 'Success';

-- 6. DELETE
DELETE FROM data_pipeline_logs WHERE status = 'Pending';

-- Check final state
SELECT * FROM data_pipeline_logs;