CREATE OR REPLACE FUNCTION hourlyupdate() RETURNS void AS
$BODY$
INSERT INTO "DailyData" (data_id, name, date_time, dayn, hour, average_buy, average_sell, previous_average_buy, previous_average_sell, buy_count, sell_count)
SELECT
                MAX(prices.data_id) AS data_id,
                MAX(prices.name) AS name,
                MAX(date) as date,
                date_part('day', prices.date) AS dayn,
                date_part('hour', prices.date) AS hour,

                CAST(AVG(prices.buy_price) AS float4) AS average_Buy,
                CAST(AVG(prices.sell_price) AS float4) AS average_Sell,
                LAG(CAST(        AVG(prices.buy_price) AS float4))        OVER (ORDER BY date_part('hour', prices.date)) AS last_buy,
                LAG(CAST(        AVG(prices.sell_price) AS float4))         OVER (ORDER BY date_part('hour', prices.date)) AS last_sell,
                AVG(sell_count),
                AVG(buy_count)
                        FROM "GuildWars2_prices" AS prices
                        GROUP BY
								data_id,
                                date_part('day', prices.date),
                                date_part('hour', prices.date);
$BODY$
LANGUAGE SQL