INSERT INTO jobs(job_name, payload, priority)
VALUES 
(
    'send welcome email', '{"email": "user1@example.com"}', 1
),
(
    'Generate invoice', '{"invoice_id": 101}', 5
),
(
    'Export report', '{"report_id": 202}', 3
),
(
    'Send payment receipt', '{"payment_id": 300}', 5
);