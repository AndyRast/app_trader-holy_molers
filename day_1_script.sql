select name
from play_store_apps;
--10840 rows

select name 
from app_store_apps;
--7197 rows

select DISTINCT play_store_apps.name AS apps_on_both
from play_store_apps inner join app_store_apps
on play_store_apps.name = app_store_apps.name;
--553 rows total or 328 rows distinct

select DISTINCT play_store_apps.name AS apps_on_both, app_store_apps.rating AS hi_rating
from play_store_apps inner join app_store_apps
on play_store_apps.name = app_store_apps.name
group by apps_on_both, hi_rating
order by hi_rating desc;
--code for apps on both with the highest rating

SELECT distinct play_store_apps.name AS apps_on_both, app_store_apps.rating AS A_rating,
	play_store_apps.rating AS P_rating, app_store_apps.price AS A_price, play_store_apps.price 
	AS P_price, app_store_apps.primary_genre AS A_genre, play_store_apps.genres AS P_genre,
	app_store_apps.content_rating AS A_content, play_store_apps.content_rating AS P_content,
	ROUND(AVG(app_store_apps.review_count::integer), 0) AS A_re_count, 
	ROUND(AVG(play_store_apps.review_count), 0) AS P_re_count
FROM play_store_apps INNER JOIN app_store_apps
ON play_store_apps.name = app_store_apps.name
WHERE (app_store_apps.review_count::integer) > 100000 AND play_store_apps.review_count > 100000
	AND (app_store_apps.rating >=4.5) AND (play_store_apps.rating >=4.5)
GROUP BY apps_on_both, A_rating, P_rating, A_price, P_price, A_genre, P_genre, A_content, 
	P_content
ORDER BY p_re_count DESC
LIMIT 20;
--table containing apps on both platforms, star rating on both, price on both, genre on both
--content rating on both, and review count