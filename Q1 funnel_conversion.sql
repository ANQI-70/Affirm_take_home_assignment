  -- Assumption: all fields are in the right data type, for example:
  --   action_date: date,
  --   action: string,
  --   user_id: string

WITH User_count AS (
  SELECT 
    DATE_FORMAT(action_date, '%Y-%m-%d') AS date
    ,COUNT(CASE WHEN action = 'Checkout Loaded' THEN user_id ELSE NULL END) AS num_loaded
    ,COUNT(CASE WHEN action = 'Loan Terms Run' THEN user_id ELSE NULL END) AS num_applied
    ,COUNT(CASE WHEN action = 'Loan Terms Approved' THEN user_id ELSE NULL END) AS num_approved
    ,COUNT(CASE WHEN action = 'Checkout Completed' THEN user_id ELSE NULL END) AS num_confirmed
  FROM funnel --replace with the right dataset table name
  GROUP BY DATE_FORMAT(action_date, '%Y-%m-%d')
)  
SELECT 
  date
  ,num_loaded
  ,num_applied
  ,num_approved
  ,num_confirmed
  ,ROUND(num_applied/NULLIF(num_loaded, 0),2) AS application_rate
  ,ROUND(num_approved/NULLIF(num_applied, 0),2) AS approval_rate
  ,ROUND(num_confirmed/NULLIF(num_approved, 0),2) AS confirmation_rate
FROM User_count
ORDER BY date;
