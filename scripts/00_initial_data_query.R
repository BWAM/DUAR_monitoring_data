
# query parquet file ------------------------------------------------------
library(arrow)
library(dplyr)

#Keleigh Reynolds
#1/6/2026

# Directories
obt_result_dir <- file.path(
  "L:",
  "DOW",
  "BWAM Share",
  "data",
  "parquet",
  "analytical_table_store",
  "obt_result_including_rejects.parquet" #this is the parquet that has ALL of the data to get the rejects for the DUAR review as well
)

event_dir<-file.path(
  "L:",
  "DOW",
  "BWAM Share",
  "data",
  "parquet",
  "build_tables",
  "EVENT.parquet"
)

dir <- file.path("L:", "DOW", "BWAM Share", "data", "parquet", "qc")

# Extract -----------------------------------------------------------------

all_df <- open_dataset(obt_result_dir) |> 
  filter(between(EVENT_DATETIME,
                 left = lubridate::ymd(params$date_start), # can adjust the date range based on the specific project
                 right = lubridate::ymd(params$date_end))) |> 
  collect()

events<-open_dataset(event_dir) |> 
  filter(between(EVENT_DATETIME,
                 left = lubridate::ymd(params$date_start), # can adjust the date range based on the specific project
                 right = lubridate::ymd(params$date_end))) |> 
  collect()
