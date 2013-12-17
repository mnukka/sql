
-- =============================================
-- Author:		Miko Nukka
-- Create date: 2013 detsember
-- Description:	Võrdleb mitme protsendivõrra kasvas B võrreldes A'ga
-- =============================================
CREATE FUNCTION PercentageIncrease(Nimetaja decimal, Lugeja decimal) RETURNS decimal AS $$
DECLARE 
	output decimal;
BEGIN
	IF Nimetaja = 0 OR Lugeja = 0 
		THEN output := 0; 
	ELSE
		output := ROUND((Nimetaja - Lugeja) / Lugeja * 100, 2);
	END
	RETURN output;
END;
$$ language SQL;
