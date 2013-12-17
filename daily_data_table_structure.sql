-- Table: "DailyData"

-- DROP TABLE "DailyData";

CREATE TABLE "DailyData"
(
  data_id bigint,
  name text,
  date_time timestamp without time zone,
  dayn integer,
  hour integer,
  average_buy numeric(20,4),
  average_sell numeric(20,4),
  previous_average_buy numeric(20,4),
  previous_average_sell numeric(20,4),
  buy_count integer,
  sell_count integer,
  "ID" serial NOT NULL,
  CONSTRAINT "DailyData_pkey" PRIMARY KEY ("ID")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "DailyData"
  OWNER TO "ServerUser";
COMMENT ON TABLE "DailyData"
  IS 'Igapäevased andmed tundide lõikes';

-- Index: "DailyData_data_id_idx"

-- DROP INDEX "DailyData_data_id_idx";

CREATE INDEX "DailyData_data_id_idx"
  ON "DailyData"
  USING btree
  (data_id);

