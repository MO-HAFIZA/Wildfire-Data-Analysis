# Library Imports
source(file = "D:/Udemy_Courses/Master DA/R/Scripts/Scripts/Libraries.R")

# Data Import
Study_Area <- read_csv("D:/Udemy_Courses/Master DA/R/Data/IntroR/Data/StudyArea.csv",
  col_names = TRUE, col_types = cols(.default = "c")
)

# Have the number of wildfires increased or decreased in the past few decades?

# More than 1000 acres
df <- Study_Area |>
  select(Year = YEAR_, Total_Alacres = TOTALACRES, Cause = CAUSE, Organization = ORGANIZATI, State = STATE) |>
  mutate(Year = as.integer(Year), Total_Alacres = as.numeric(Total_Alacres)) |>
  filter(Total_Alacres > 1000) |>
  group_by(Year, State) |>
  summarise(count = n())

# Plot
df |> ggplot(aes(x = Year, y = count, fill = State)) +
  geom_point(colour = "#EEE8D5") +
  facet_wrap(~State) +
  geom_smooth(method = lm) +
  my_theme_dark +
  labs(
    title = "Large Fire Are Becoming More Common in the West - 1980 : 2016",
    subtitle = "Comparison is Based on States - Acres more than 1000",
    y = "Number of Wildfires", x = ""
  )

# More than 5000 acres
df <- Study_Area |>
  select(Year = YEAR_, Total_Alacres = TOTALACRES, Cause = CAUSE, Organization = ORGANIZATI, State = STATE) |>
  mutate(Year = as.integer(Year), Total_Alacres = as.numeric(Total_Alacres)) |>
  filter(Total_Alacres > 5000) |>
  group_by(Year, State) |>
  summarise(count = n())

# Plot
df |> ggplot(aes(x = Year, y = count, fill = State)) +
  geom_point(colour = "#EEE8D5") +
  facet_wrap(~State) +
  geom_smooth(method = lm) +
  my_theme_dark +
  labs(
    title = "Large Fire Are Becoming More Common in the West - 1980 : 2016",
    subtitle = "Comparison is Based on States - Acres more than 5000",
    y = "Number of Wildfires", x = ""
  )

# Natural Cause ?
df <- Study_Area |>
  select(Year = YEAR_, Total_Alacres = TOTALACRES, Cause = CAUSE, Organization = ORGANIZATI, State = STATE) |>
  mutate(Year = as.integer(Year), Total_Alacres = as.numeric(Total_Alacres)) |>
  filter(Total_Alacres > 1000, Cause %in% c("Human", "Natural")) |>
  group_by(Year, State, Cause) |>
  summarise(count = n())

# Plot
df |> ggplot(aes(x = Year, y = count, colour = Cause)) +
  geom_point() +
  facet_wrap(~State) +
  geom_smooth(method = lm) +
  my_theme_dark +
  labs(
    title = "Large Fire Are Becoming More Common in the West - 1980 : 2016",
    subtitle = "Comparison is Based on States and Cause",
    y = "Number of Wildfires", x = ""
  )

# Has	the	acreage	burned increased	over time?

# Main df
df <- Study_Area |>
  select(Year = YEAR_, Total_Alacres = TOTALACRES, Cause = CAUSE, Organization = ORGANIZATI, State = STATE) |>
  mutate(Year = as.integer(Year), Total_Alacres = as.numeric(Total_Alacres)) |>
  filter(Total_Alacres >= 1000) |>
  group_by(Year, State) |>
  summarise(total = sum(Total_Alacres))

# Plot
df |> ggplot(aes(x = Year, y = log(total))) +
  geom_point(colour = "#EEE8D5") +
  facet_wrap(~State) +
  geom_smooth(method = lm, colour = "#CB4B16", fill = "#CB4B16", alpha = 0.15) +
  my_theme_dark +
  labs(
    title = "Total Acres over time", subtitle = "Based on States",
    y = "Log Total Acres", x = ""
  )

# Main df
df <- Study_Area |>
  select(Year = YEAR_, Total_Alacres = TOTALACRES, Cause = CAUSE, Organization = ORGANIZATI, State = STATE) |>
  mutate(Year = as.integer(Year), Total_Alacres = as.numeric(Total_Alacres)) |>
  filter(Total_Alacres >= 1000, Cause %in% c("Human", "Natural")) |>
  group_by(Year, Cause) |>
  summarise(total = sum(Total_Alacres))

# Plot
df |> ggplot(aes(x = Year, y = log(total), colour = Cause)) +
  geom_point() +
  geom_smooth(method = lm, alpha = 0.15) +
  my_theme_dark +
  labs(
    title = "Total Acres over time", subtitle = "Based on Cause",
    y = "Log Total Acres", x = ""
  )

# Is the size of individual wildfires increasing over time?

# Main df
df <- Study_Area |>
  select(Year = YEAR_, Total_Alacres = TOTALACRES, Cause = CAUSE, Organization = ORGANIZATI, State = STATE) |>
  mutate(Year = as.integer(Year), Total_Alacres = as.numeric(Total_Alacres)) |>
  filter(Total_Alacres >= 1000) |>
  group_by(Year, Cause) |>
  summarise(total = sum(Total_Alacres), avg = mean(Total_Alacres))

# Plot
df |> ggplot(aes(x = Year, y = avg)) +
  geom_point(colour = "#EEE8D5") +
  geom_smooth(method = lm, alpha = 0.15, colour = "#CB4B16", fill = "#CB4B16") +
  my_theme_dark +
  labs(
    title = "Average Size of Wildfires Has Increased for both Human and Natural Causes",
    y = "Average Wildfires Size", x = ""
  )

# Main df
df <- Study_Area |>
  select(Year = YEAR_, Total_Alacres = TOTALACRES, Cause = CAUSE, Organization = ORGANIZATI, State = STATE) |>
  mutate(
    Year = as.integer(Year), Total_Alacres = as.numeric(Total_Alacres),
    Decade = if_else(Year %in% 1980:1990, "1980-1990", if_else(Year %in% 1990:2000, "1990-2000", if_else(Year %in% 2000:2010, "2000-2010", if_else(Year %in% 2010:2020, "2010-2020", "Else"))))
  ) |>
  filter(Total_Alacres >= 1000) |>
  group_by(Decade) |>
  summarise(total = sum(Total_Alacres), avg = mean(Total_Alacres))

# Plot
df |> ggplot(aes(x = Decade, y = avg)) +
  geom_col(colour = "#EEE8D5", fill = "#164B56") +
  my_theme_dark +
  labs(
    title = "Average Size of Wildfires Has Increased",
    subtitle = "By Decades",
    y = "Average Wildfires Size", x = ""
  )

# Has the length of the fire season increased over time?

# Main df
df <- Study_Area |>
  select(Year = YEAR_, Total_Alacres = TOTALACRES, Cause = CAUSE, Organization = ORGANIZATI, State = STATE, Start = STARTDATED) |>
  mutate(
    Year = as.integer(Year), Total_Alacres = as.numeric(Total_Alacres),
    DOY = yday(as.Date(Start, format = "%m/%d/%y %H:%M"))
  ) |>
  filter(Total_Alacres >= 1000) |>
  group_by(Year) |>
  summarise(DtEarly = min(DOY, na.rm = T), DtLate = max(DOY, na.rm = T))

# Plot
df |> ggplot() +
  geom_line(aes(x = Year, y = DtLate), colour = "#EEE8D5") +
  geom_smooth(method = lm, alpha = 0.15, colour = "#CB4B16", fill = "#EEE8D5", aes(x = Year, y = DtLate)) +
  geom_line(aes(x = Year, y = DtEarly), colour = "#EEE8D5") +
  geom_smooth(method = lm, alpha = 0.15, colour = "#CB4B16", fill = "#EEE8D5", aes(x = Year, y = DtEarly)) +
  my_theme_dark +
  labs(
    title = "The length of the fire season over time",
    y = "Day Of Year", x = ""
  ) +
  annotate("text", x = 1995, y = 120, label = "First Fire", colour = "#EEE8D5") +
  annotate("text", x = 1995, y = 350, label = "Last Fire", colour = "#EEE8D5")

# Does the average wildfire size differ by federal organization ?

# Main df
df <- Study_Area |>
  select(Year = YEAR_, Total_Alacres = TOTALACRES, Cause = CAUSE, Organization = ORGANIZATI, State = STATE) |>
  mutate(Year = as.integer(Year), Total_Alacres = as.numeric(Total_Alacres)) |>
  filter(Total_Alacres >= 1000, !Organization %in% c("BOR")) |>
  group_by(Year, Organization) |>
  summarise(total = sum(Total_Alacres), avg = mean(Total_Alacres))

# Plot
df |> ggplot(aes(x = Year, y = log(avg))) +
  geom_point(colour = "#EEE8D5") +
  facet_wrap(~Organization) +
  geom_smooth(method = lm, alpha = 0.15, colour = "#CB4B16", fill = "#CB4B16") +
  my_theme_dark +
  labs(
    title = "Average Size of Wildfires Has Increased",
    subtitle = "By Organizations",
    y = "Log Of Average Wildfires Size", x = ""
  )
