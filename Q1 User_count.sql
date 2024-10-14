---Assumption: All fields are in right data type, for example:
----Checkout_date: date
--- user_dob_year: integer

SELECT 
   Count(user_id) AS Count_users_with_loans
FROM loans --replace with the right dataset table name
WHERE 
  DATE_FORMAT(checkout_date, '%Y-%m-%d') BETWEEN '2016-03-01' AND '2016-03-31'
  AND (user_dob_year >= 1980 AND user_dob_year <1990) ; 
