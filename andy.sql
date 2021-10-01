--Highest rated by genres(app_store_apps)
--SELECT DISTINCT(primary_genre), AVG(rating) AS avg_rating_total
--FROM app_store_apps
--GROUP BY app_store_apps.primary_genre
--ORDER BY avg_rating_total DESC


--Highest rated genres(play_store_apps)
--SELECT DISTINCT(category), AVG(rating) AS avg_rating_total
--FROM play_store_apps
--WHERE rating IS NOT NULL
--GROUP BY play_store_apps.category
--ORDER BY avg_rating_total DESC

--highest rated genres in both stores
--SELECT primary_genre, rating
--FROM app_store_apps
--UNION
--SELECT genres, rating
--FROM play_store_apps
--WHERE rating IS NOT NULL
--ORDER BY rating DESC
--top5: productivity, lifestyle, utilities, trivia, racing


--(app_store)Expected lifespan, total expected marketing cost, total expected income, and total expected revenue
--SELECT name, 
	   --rating, primary_genre, 
	   --((rating*2)+1) AS expected_lifespan, 
	   --(((rating*2)+1)*1000*12) AS total_expected_marketing_cost, 
	   --(((rating*2)+1)*2500*12) AS total_expected_income, 
	   --((((rating*2)+1)*2500*12) - (((rating*2)+1)*1000*12)) AS expected_revenue
--FROM app_store_apps
--ORDER BY expected_revenue DESC
--492 with highest revenue

--(play_store)Expected lifespan, total expected marketing cost, total expected income, and total expected revenue
--SELECT name, ROUND((CEILING(rating*2)/2),1) AS rating, genres, ((rating*2)+1) AS expected_lifespan, (((rating*2)+1)*1000*12) AS total_epected_marketing_cost, (((rating*2)+1)*2500*12) AS total_expected_income, ((((rating*2)+1)*2500*12) - (((rating*2)+1)*1000*12)) AS expected_revenue
--FROM play_store_apps
--WHERE rating IS NOT NULL
--ORDER BY expected_revenue DESC
--274 with highest revenue

--WITH APPLE_APP_STORE AS
	--(SELECT *,
	 		--Case when PRICE < 1 then
	 			--10000.00
	 		--else
	 			--(PRICE::numeric * 10000)
	 		--end as PURCHASE_COST,
			--(((RATING * 2) + 1) * 1000 * 12) AS MARKETING_COST,
			--(((RATING * 2) + 1) * 2500 * 12) AS EARNINGS
		--FROM APP_STORE_APPS)
--SELECT *, (earnings-purchase_cost+marketing_cost) as PROFITS
--FROM APPLE_APP_STORE
--ORDER BY PROFITS DESC;

WITH apps_income AS (SELECT name, 
	   			 	 rating, primary_genre, 
	   			 	 ((rating*2)+1) AS apps_expected_lifespan, 
	   		 	 	 (((rating*2)+1)*1000*12) AS apps_total_expected_marketing_cost, 
	   			 	 (((rating*2)+1)*2500*12) AS apps_total_expected_income, 
	   			 	 ((((rating*2)+1)*2500*12) - (((rating*2)+1)*1000*12)) AS apps_expected_revenue
					 FROM app_store_apps
					 ORDER BY apps_expected_revenue DESC),
play_income AS		 (SELECT name, 
	   				 ROUND((CEILING(rating*2)/2),1) AS rating, 
	   				 genres, 
	   				 ((rating*2)+1) AS play_expected_lifespan, 
	   				 (((rating*2)+1)*1000*12) AS play_total_epected_marketing_cost, 
	   				 (((rating*2)+1)*2500*12) AS play_total_expected_income, 
	   				 ((((rating*2)+1)*2500*12) - (((rating*2)+1)*1000*12)) AS play_expected_revenue
					 FROM play_store_apps
					 WHERE rating IS NOT NULL
					 ORDER BY play_expected_revenue DESC)
SELECT DISTINCT(apps.name), apps.apps_expected_lifespan, play.play_expected_lifespan, apps.apps_expected_revenue, play.play_expected_revenue
FROM apps_income AS apps
	INNER JOIN play_income AS play
ON apps.name = play.name
ORDER BY apps.apps_expected_revenue DESC
LIMIT 25