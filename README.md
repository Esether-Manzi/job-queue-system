## PostgreSQL Job Queue

### Overview

This project implements a simple background job queue using PostgreSQL.

It supports:

- Job statuses: "pending", "processing", and "completed".
- Atomic job claiming using row-level locking.
- Concurrent workers using "FOR UPDATE SKIP LOCKED".
- Priority-based job selection.
- A function for marking jobs as completed.

### Requirements

- PostgreSQL
- pgAdmin or "psql"

### Setup

1. Create a database named "job_queue_db".
2. Execute "schema.sql".
3. Execute "functions.sql".
4. Execute "seed.sql".
5. Run the queries in "tests.sql".

### Claim a job

SELECT * FROM claim_next_job();

### Complete a job

Replace "1" with the ID of the job you claimed.

SELECT complete_job(1);

## Concurrency strategy

The claiming function selects one pending job using "FOR UPDATE SKIP LOCKED" and updates its status to "processing" in the same SQL statement. This allows concurrent workers to claim different available jobs without waiting on already-locked rows.

Workers should commit the claim transaction promptly and perform job execution outside that transaction.

#### Limitations

- Retry handling and failed-job states.
- Recovery of abandoned processing jobs.
- Worker ownership and claim expiration.


### Demonstration video

Video URL: https://youtu.be/jk7h19NJAxM

## Author

KOBUMANZI ESETHER