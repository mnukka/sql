
-- =============================================
-- Author:		Miko Nukka
-- Create date: 2013 detsember
-- Description:	Võrdleb mitme protsendivõrra kasvas B võrreldes A'ga
-- =============================================
CREATE FUNCTION HourlyUpdate() RETURNS VOID AS $$
BEGIN
INSERT INTO DailyData (data_id, name, Date_Time, Day, DayN, Hour, Average_buy, Average_sell, Previous_average_buy, Previous_average_sell, Sell_count, Buy_count)
SELECT
		MAX(prices.data_id) AS data_id,
		MAX(items.name) AS name,
		MAX(date) as date,
		DayN = date_part(DAY, date),
		Hour = date_part(HOUR, date),

		CAST(AVG(prices.buy_price) AS float4) AS Average_Buy,
		CAST(AVG(prices.sell_price) AS float4) AS Average_Sell,
		LAG(CAST(	AVG(prices.buy_price) AS float4))	OVER w AS Last_buy,
		LAG(CAST(	AVG(prices.sell_price) AS float4)) 	OVER w AS Last_sell,
		AVG(Sell_count),
		AVG(Buy_count)
			FROM GuildWars2_prices AS prices --INNER JOIN GuildWars2_items  AS items ON prices.data_id = items.data_id
			GROUP BY
				prices.data_id,
				date_part(DAY, date),
				date_part(HOUR, date)
			WINDOW w AS (PARTITION BY prices.buy_price, prices.sell_price ORDER BY date_part(HOUR, date));
END;
$$ language plpgsql;
