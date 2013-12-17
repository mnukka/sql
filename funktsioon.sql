
-- =============================================
-- Author:		Miko Nukka
-- Create date: 2013 detsember
-- Description:	Võrdleb mitme protsendivõrra kasvas B võrreldes A'ga
-- =============================================
CREATE FUNCTION PercentageIncrease(Lugeja decimal, Nimetaja decimal) RETURNS decimal AS $$
DECLARE 
	output decimal; --Error sellel real? why...
BEGIN
	IF Lugeja = 0 
		THEN RETURN 0;
	ELSE
		output := ROUND((Lugeja - Nimetaja) / Nimetaja * 100, 2);
	END IF;
	RETURN output;
END;
$$ language SQL;
