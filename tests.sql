-------------TESTS------
-- 1. VIEW JOBS or inspect the queue

SELECT id, job_name, status, priority
FROM jobs
ORDER BY id;


-- 2. TEST THE CLAIM_NEXT_JOB FUNCTION (claim the next job)

SELECT * FROM claim_next_job();


-- 3. TEST THE COMPLETED FUNCTION

SELECT complete_job(2);  -- Functiion returns true if it updated the job and false if no eligible job was updated.


-- 4. Inspect the queue to confirm the changes in status

SELECT id, job_name, status
FROM jobs
ORDER BY id;