SELECT *
FROM app_store_apps;


SELECT *
FROM play_store_apps;


---all the zero $ apps with highest reviews 
SELECT *
FROM app_store_apps
Where price=0.00
ORDER BY (review_count::decimal) desc

--PROFIT of app_store

WITH APPLE_APP_STORE AS
	(SELECT *,
	 		Case when PRICE < 1 then 
	 			10000.00
	 		else
	 			(PRICE::numeric * 10000)
	 		end as PURCHASE_COST,
			(((RATING * 2) + 1) * 1000 * 12) AS MARKETING_COST,
			(((RATING * 2) + 1) * 2500 * 12) AS EARNINGS
		FROM APP_STORE_APPS)
SELECT *, (earnings-purchase_cost+marketing_cost) as PROFITS
FROM APPLE_APP_STORE
WHERE review_count::numeric > '1000'
ORDER BY PROFITS DESC;




_______NPV of play_store

WITH PLAY_APP_STORE AS
	(SELECT *,ceiling(rating),
	 		Case when PRICE< 1 then 
	 			10000.00
	 		else
	 			(PRICE * 10000)
	 		end as PURCHASE_COST,
			(((RATING * 2) + 1) * 1000 * 12) AS MARKETING_COST,
			(((RATING * 2) + 1) * 2500 * 12) AS EARNINGS
		FROM PLAY_STORE_APPS)
SELECT *, (earnings-purchase_cost+marketing_cost) as PROFITS
FROM PLAY_APP_STORE
ORDER BY PROFITS DESC;
------

SELECT distinct price
from play_store_apps

-- Select * from Test

