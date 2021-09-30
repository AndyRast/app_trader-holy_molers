--SELECT DISTINCT(name), rating, install_count :: numeric
--FROM play_store_apps
--WHERE rating IS NOT NULL AND install_count IS NOT NULL
--ORDER BY install_count, rating DESC
--LIMIT 25;

SELECT DISTINCT(name), rating, review_count :: numeric, SUM((rating *2) + 1) AS expected_lifespan, price,
	CASE WHEN price <= 1.00 THEN 10000.00
		 WHEN price > 1.00 THEN price *10000.00 END as cost_to_purchase
FROM app_store_apps
WHERE rating IS NOT NULL AND review_count IS NOT NULL
GROUP BY name, rating, expected_lifespan, review_count, price, cost_to_purchase
ORDER BY review_count DESC, rating DESC
--LIMIT 25;
--
--Where SUM((rating *2)+1)AS 'expected_lifespan'