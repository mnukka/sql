CREATE OR REPLACE FUNCTION hourlyupdate() RETURNS void AS
$BODY$
INSERT INTO "DailyData" (data_id, name, date_time, dayn, hour, average_buy, average_sell, previous_average_buy, previous_average_sell, buy_count, sell_count)
SELECT
		MAX(prices.data_id) AS data_id,
		MAX(prices.name) AS name,
		MAX(date) as date,
		dayn = date_part(DAY, date),
		hour = date_part(HOUR, date),

		CAST(AVG(prices.buy_price) AS float4) AS average_Buy,
		CAST(AVG(prices.sell_price) AS float4) AS average_Sell,
		LAG(CAST(	AVG(prices.buy_price) AS float4))	OVER w AS last_buy,
		LAG(CAST(	AVG(prices.sell_price) AS float4)) 	OVER w AS last_sell,
		AVG(sell_count),
		AVG(buy_count)
			FROM "GuildWars2_prices" AS prices
			GROUP BY
				prices.data_id,
				date_part(DAY, date),
				date_part(HOUR, date)
			WINDOW w AS (PARTITION BY prices.buy_price, prices.sell_price ORDER BY date_part(HOUR, date));
$BODY$
LANGUAGE SQL
