# Answers of Eurostat as eurostat::get_eurostat() returns them, so that the tests need no internet

# unemployment of two countries, the EU-27 average, the euro area and a country outside the app
raw_unemployment <- data.frame(
  freq = "A", age = "Y15-74", unit = "PC_ACT", sex = "T",
  geo = rep(c("EL", "BG", "EU27_2020", "EA20", "US"), each = 3),
  time = rep(2022:2024, 5),
  values = c(12.4, 11.1, 10.1, 4.3, 4.3, 4.2, 6.2, 6.1, 5.9, 6.8, 6.6, 6.4, 3.6, 3.6, NA)
)

# two regions of Greece
regions <- data.frame(
  geo = c("EL30", "EL52", "EL30", "EL52"), region = c("Attiki", "Kentriki Makedonia"),
  country = "Greece", year = c(2023, 2023, 2024, 2024), value = c(101, 57, 105, 58)
)
