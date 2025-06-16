CREATE TABLE email_signup (
    id INT,
    email_id NVARCHAR(100),
    signup_date DATE
);

INSERT INTO email_signup (id, email_id, signup_date) VALUES
(1, 'Rajesh@Gmail.com', '2022-02-01'),
(2, 'Rakesh_gmail@rediffmail.com', '2023-01-22'),
(3, 'Hitest@Gmail.com', '2020-09-08'),
(4, 'Salil@Gmmail.com', '2019-07-05'),
(5, 'Himanshu@Yahoo.com', '2023-05-09'),
(6, 'Hitesh@Twitter.com', '2015-01-01'),
(7, 'Rakesh@facebook.com', NULL);



SELECT 
    COUNT(*) AS count_gmail_account,
    MAX(COALESCE(signup_date, '1970-01-01')) AS latest_signup_date,
    MIN(COALESCE(signup_date, '1970-01-01')) AS first_signup_date,
    DATEDIFF(DAY, MIN(COALESCE(signup_date, '1970-01-01')), MAX(COALESCE(signup_date, '1970-01-01'))) AS diff_in_days
FROM 
    email_signup
WHERE 
    email_id LIKE '%@gmail.com%' OR email_id LIKE '%@Gmail.com%';