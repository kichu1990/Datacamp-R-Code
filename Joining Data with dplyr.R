# Complete the code to join artists to bands
bands2 <- left_join(artists, bands, by = c(first,last))

# Examine the results
bands2

# Finish the code below to recreate bands3 with a right join
bands2 <- left_join(bands, artists, by = c("first", "last"))
bands3 <- right_join(bands, artists, by = c("first", "last"))

# Check that bands3 is equal to bands2
setequal(bands2,bands3)

# Join albums to songs using inner_join()
inner_join(songs,albums,by="album")

# Join bands to artists using full_join()
full_join(artists,bands,by=c("first","last"))

# Find guitarists in bands dataset (don't change)
temp <- left_join(bands, artists, by = c("first", "last"))
temp <- filter(temp, instrument == "Guitar")
select(temp, first, last, band)

# Reproduce code above using pipes
bands %>% 
  left_join(artists,by = c("first", "last")) %>% 
  filter(instrument == "Guitar") %>%
  select(first, last, band)

# Examine the contents of the goal dataset
goal

# Create goal2 using full_join() and inner_join() 
goal2 <- artists %>% 
  full_join(bands, by = c("first", "last")) %>% 
  inner_join(songs, by = c("first", "last"))

# Check that goal and goal2 are the same
setequal(goal, goal2)

#Write a pipe that combines artists, bands, songs, and albums (in that order) into a 
#single table, such that it contains all of the information in the datasets.

# Create one table that combines all information
artists %>%
  full_join(bands,by=c("first","last")) %>%
  full_join(songs,by=c("first","last")) %>%
  full_join(albums,by=c("album","band"))

# View the output of semi_join()
artists %>% 
  semi_join(songs, by = c("first", "last"))

# Create the same result
artists %>% 
  right_join(songs, by = c("first", "last")) %>% 
  filter(!is.na(instrument)) %>% 
  select(first,last,instrument)

albums %>% 
  # Collect the albums made by a band
  semi_join(bands, by = "band") %>% 
  # Count the albums made by a band
  nrow()

# Check whether album names in labels are mis-entered
labels %>% 
  anti_join(albums, by = "album")

# Determine which key joins labels and songs
labels
songs

# Check your understanding
songs %>% 
  # Find the rows of songs that match a row in labels
  semi_join(labels, by = "album") %>% 
  # Number of matches between labels and songs
  nrow()

aerosmith %>% 
  # Create the new dataset using a set operation
  union(greatest_hits) %>%
  # Count the total number of songs
  nrow()

# Create the new dataset using a set operation
aerosmith %>% 
  intersect(greatest_hits)

# Select the song names from live
live_songs <- live %>% select(song)

# Select the song names from greatest_hits
greatest_songs <- greatest_hits%>% select(song)

# Create the new dataset using a set operation
live_songs %>% 
  setdiff(greatest_songs)

# Select songs from live and greatest_hits
live_songs <- live %>% select(song)
greatest_songs <- greatest_hits %>% select(song)

# Find songs in at least one of live_songs and greatest_songs
all_songs <- live_songs %>% union(greatest_songs)

# Find songs in both 
common_songs <- live_songs %>% intersect(greatest_songs)

# Find songs that only exist in one dataset
all_songs %>% setdiff(common_songs)

# Check if same order: definitive and complete
identical(definitive,complete)

# Check if any order: definitive and complete
setequal(definitive,complete)

# Songs in definitive but not complete
setdiff(definitive,complete)


# Songs in complete but not definitive
setdiff(complete,definitive)


# Return songs in definitive that are not in complete
definitive %>% 
  anti_join(complete)

# Return songs in complete that are not in definitive
complete %>% 
  anti_join(definitive)

# Get union of complete and soundtrack
complete_and_soundtrack <- complete %>% union(soundtrack)


# Check if same order: definitive and union of complete and soundtrack
complete_and_soundtrack %>%
  identical(definitive)


# Check if any order: definitive and union of complete and soundtrack
complete_and_soundtrack %>%
  setequal(definitive)

# Examine side_one and side_two
side_one
side_two

# Bind side_one and side_two into a single dataset
side_one %>% 
  bind_rows(side_two)

# Examine discography and jimi
discography
jimi

jimi %>% 
  # Bind jimi into a single data frame
  bind_rows(.id = "album") %>% 
  # Make a complete data frame
  left_join(discography)

# Examine hank_years and hank_charts
hank_years
hank_charts

hank_years %>% 
  # Reorder hank_years alphabetically by song title
  arrange(song) %>% 
  # Select just the year column
  select(year) %>% 
  # Bind the year column
  bind_cols(hank_charts)  %>% 
  # Arrange the finished dataset
  arrange(year)

# Make combined data frame using data_frame()
data_frame(year=hank_year,song=hank_song,peak=hank_peak)%>% 
  # Extract songs where peak equals 1
  filter(peak==1)

# Examine the contents of hank
hank

# Convert the hank list into a data frame
as_data_frame(hank) %>% 
  # Extract songs where peak equals 1
  filter(peak==1)

# Examine the contents of michael
michael

# as_data_frame(michael) %>% 
group_by(album) %>% 
  mutate(rank = min_rank(peak)) %>% 
  filter(rank == 1) %>% 
  select(-rank, -peak)

seventies %>% 
  # Coerce seventies$year into a useful numeric
  mutate(year = as.numeric(as.character(year))) %>% 
  # Bind the updated version of seventies to sixties
  bind_rows(sixties) %>% 
  arrange(year)

# Load the tibble package
library(tibble)

stage_songs %>% 
  # Add row names as a column named song
  rownames_to_column(var="song") %>% 
  # Left join stage_writers to stage_songs
  left_join(stage_writers,by="song")

# Examine the result of joining singers to two_songs
two_songs %>% inner_join(singers, by = "movie")

# Remove NA's from key before joining
two_songs %>% 
  filter(!is.na(movie)) %>% 
  inner_join(singers, by = "movie")


movie_years %>% 
  # Left join movie_studios to movie_years
  left_join(movie_studios, by = "movie") %>% 
  # Rename the columns: artist and studio
  rename(artist = name.x, studio = name.y)

# Identify the key column
elvis_songs
elvis_movies

elvis_movies %>% 
  # Left join elvis_songs to elvis_movies by this column
  left_join(elvis_songs, by = c("name" = "movie")) %>% 
  # Rename columns
  rename(movie = name, song = name.y)

# Identify the key columns
movie_directors
movie_years

movie_years %>% 
  # Left join movie_directors to movie_years
  left_join(movie_directors, by = c("movie" = "name")) %>% 
  # Arrange the columns using select()
  select(year, movie, artist = name, director, studio)

# Load the purrr library
library(purrr)

# Place supergroups, more_bands, and more_artists into a list
list(supergroups, more_bands, more_artists) %>%
  # Use reduce to join together the contents of the list
  reduce(left_join, by = c("first", "last"))

list(more_artists, more_bands, supergroups) %>% 
  # Return rows of more_artists in all three datasets
  reduce(semi_join, by = c("first", "last"))

install.packages("Lahman")
library(Lahman)


lahmanNames %>%  
  # Bind the data frames in lahmanNames
  bind_rows(.id = "dataframe") %>%
  # Group the result by var
  group_by(var) %>%
  # Tally the number of appearances
  tally() %>%
  # Filter the data
  filter(n > 1) %>% 
  # Arrange the results
  arrange(desc(n))

lahmanNames %>% 
  # Bind the data frames
  bind_rows(.id = "dataframe") %>%
  # Filter the results
  filter(var == "playerID") %>%
  # Extract the dataframe variable
  `$`("dataframe")

install.packages("tibble")
library(tibble)
library(Lahman)
library(dplyr)

players <- Master %>% 
  # Return one row for each distinct player
  distinct(playerID,nameFirst,nameLast)

nrow(players)

players %>% 
  # Find all players who do not appear in Salaries
  anti_join(Salaries,by="playerID") %>%
  # Count them
  count()

players %>% 
  anti_join(Salaries, by = "playerID") %>% 
  # How many unsalaried players appear in Appearances?
  semi_join(Appearances,by = "playerID") %>% 
  count()

players %>% 
  # Find all players who do not appear in Salaries
  anti_join(Salaries,by="playerID") %>% 
  # Join them to Appearances
  left_join(Appearances,by="playerID") %>% 
  # Calculate total_games for each player
  group_by(playerID) %>%
  summarize(total_games=sum(G_all,na.rm=TRUE))%>%
  # Arrange in descending order by total_games
  arrange(desc(total_games))

players %>%
  # Find unsalaried players
  anti_join(Salaries,by="playerID") %>% 
  # Join Batting to the unsalaried players
  left_join(Batting,by="playerID") %>% 
  # Group by player
  group_by(playerID) %>% 
  # Sum at-bats for each player
  summarize(total_at_bat=sum(AB,na.rm=TRUE))%>% 
  # Arrange in descending order
  arrange(desc(total_at_bat))

# Find the distinct players that appear in HallOfFame
nominated <- HallOfFame %>% 
  distinct(playerID)

nominated %>% 
  # Count the number of players in nominated
  count()

nominated_full <- nominated %>% 
  # Join to Master
  left_join(Master,by="playerID") %>% 
  # Return playerID, nameFirst, nameLast
  select(playerID,nameFirst,nameLast)


# Find distinct players in HallOfFame with inducted == "Y"
inducted <- HallOfFame %>% 
  filter(inducted == "Y") %>% 
  distinct(playerID)

inducted %>% 
  # Count the number of players in inducted
  count()

inducted_full <- inducted %>% 
  # Join to Master
  left_join(Master,by="playerID") %>% 
  # Return playerID, nameFirst, nameLast
  select(playerID, nameFirst, nameLast)

# Tally the number of awards in AwardsPlayers by playerID
nAwards <- AwardsPlayers %>% 
  group_by(playerID) %>% 
  tally()

nAwards %>% 
  # Filter to just the players in inducted 
  semi_join(inducted, by = "playerID") %>% 
  # Calculate the mean number of awards per player
  summarize(avg_n = mean(n, na.rm = TRUE))

nAwards %>% 
  # Filter to just the players in nominated 
  semi_join(nominated, by = "playerID") %>%
  # Filter to players NOT in inducted 
  anti_join(inducted, by = "playerID") %>%
  # Calculate the mean number of awards per player
  summarize(avg_n = mean(n, na.rm = TRUE))

# Find the players who are in nominated, but not inducted
notInducted <- nominated %>% 
  setdiff(inducted)

Salaries %>% 
  # Find the players who are in notInducted
  semi_join(notInducted, by = "playerID") %>%
  # Calculate the max salary by player
  group_by(playerID) %>% 
  summarize(max_salary = max(salary, na.rm = TRUE)) %>% 
  # Calculate the average of the max salaries
  summarize(avg_salary = mean(max_salary, na.rm = TRUE))

# Repeat for players who were inducted
Salaries %>% 
  semi_join(inducted, by = "playerID") %>% 
  group_by(playerID) %>% 
  summarize(max_salary = max(salary, na.rm = TRUE)) %>% 
  summarize(avg_salary = mean(max_salary, na.rm = TRUE))

Appearances %>% 
  # Filter Appearances against nominated
  semi_join(nominated, by = "playerID") %>% 
  # Find last year played by player
  group_by(playerID) %>% 
  summarize(last_year = max(yearID)) %>% 
  # Join to full HallOfFame
  left_join(HallOfFame, by = "playerID") %>% 
  # Filter for unusual observations
  filter(last_year >= yearID)
  
  $df1
  x y
1 6 A
2 7 B
3 8 C

$df2
   x y
1  9 D
2 10 E
3 11 F
bind_rows (lst, .id = "source")
Output: 
  source  x y
1    df1  6 A
2    df1  7 B
3    df1  8 C
4    df2  9 D
5    df2 10 E
6    df2 11 F
