-- A FUNCTION THAT FETCHES AND AUTOMATICALLY CLAIMS THE NEXT JOB SO THAT OTHER WORKERS CANNOT CLAIM THE SAME JOB.

CREATE OR REPLACE FUNCTION claim_next_job()
RETURNS SETOF jobs
LANGUAGE sql
AS $$
    WITH next_job AS (
        SELECT id
        FROM jobs
        WHERE status = 'pending'
        ORDER BY priority DESC, id ASC
        FOR UPDATE SKIP LOCKED
        LIMIT 1
    )

    UPDATE jobs AS j
    SET
        status = 'processing',
        started_at = NOW()
    FROM next_job
    WHERE j.id = next_job.id
    RETURNING j.*;
$$;


-- A FUNCTION THAT MARKS A JOB AS COMPLETED

CREATE OR REPLACE FUNCTION complete_job(p_job_id BIGINT)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE jobs
    SET
        status = 'completed',
        completed_at = NOW()
    WHERE id = p_job_id 
        AND status = 'processing';
    RETURN FOUND;
END;
$$;