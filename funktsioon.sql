
-- =============================================
-- Author:		Miko Nukka
-- Create date: 2013 detsember
-- Description:	Võrdleb mitme protsendivõrra kasvas B võrreldes A'ga
-- =============================================
CREATE FUNCTION PercentageIncrease(Lugeja decimal, Nimetaja decimal) RETURNS DECIMAL AS $$
BEGIN
	IF Nimetaja = NULL or Nimetaja = 0 
		THEN RETURN 0;
	ELSE
		RETURN ROUND((Lugeja - Nimetaja) / Nimetaja * 100, 2);
	END IF;
END;
$$ language SQL;
