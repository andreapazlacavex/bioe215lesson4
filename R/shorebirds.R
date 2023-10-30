#BIOE215 Lesson 4 - Functions
#10/24/2023

#### ASSESSMENT  - Where do birds hatch?

# Suddenly you’re a shorebird biologist, analyzing survey data of young-of-the-year Black Oystercatchers in Santa Cruz to figure out where chicks hatched. For safety reasons, the biologists weren’t able to band chicks at their nests. Instead, they caught the chicks later and gave them uniquely identifying 3-color band combinations. For example, GYB is the bird with Green-Yellow-Blue color bands.

# You know Black Oystercatcher chicks move around, but they tend to stick close to their hatch site. So you’ve decided to estimate the hatching site as the location where the bird was observed most often during weekly surveys.


# Simulate data -----------------------------------------------------------

library(tidyverse)

# Generate sample data
# Sightings of Black Oystercatcher chicks at Santa Cruz beaches
beaches <- c("Cowell's", "Steamer Lane", "Natural Bridges", "Mitchell's", "Main")
# blue, green, black, white, yellow
band_colors <- c("B", "G", "K", "W", "Y") 
# Surveys took place weekly in the summer of 2023
surveys <- seq(as.Date("2023-06-01"), as.Date("2023-08-31"), by = 7)

# Setting the "seed" forces randomized functions (like sample()) to generate
# the same output
set.seed(1538)
# 3 band colors identify a bird. We want 12 birds.
birds <- paste0(
  sample(band_colors, 25, replace = TRUE),
  sample(band_colors, 25, replace = TRUE),
  sample(band_colors, 25, replace = TRUE)
) %>% 
  unique() %>%
  head(12)
bloy_chicks <- tibble(
  # Randomly generate survey data
  beach = sample(beaches, size = 100, replace = TRUE),
  bird = sample(birds, size = 100, replace = TRUE),
  survey = sample(surveys, size = 100, replace = TRUE)
) %>% 
  # Remove duplicates (see ?distinct)
  distinct() %>% 
  # Sort by survey date and location
  arrange(survey, beach)

# Q1 We’re randomly generating data, but we’re all going to end up with the same data frames. How is that happening? set.seed generates a defined set of random numbers but the are consistent. If we changed the 1538 for something else, they it'd change but stay the same every time is run.

# Q2 Explain in plain language what this part does. Your answer should be one or two sentences: the birds function randomly selects 25 band_colors three times, pastes them together, selects the unique ones from that list and the first 12 from the remaining list.
      # birds <- paste0(
        # sample(band_colors, 25, replace = TRUE),
        # sample(band_colors, 25, replace = TRUE),
        # sample(band_colors, 25, replace = TRUE)) %>% 
        # unique() %>%
        # head(12)

# Q3 We generated 100 random survey observations. How many rows are in bloy_chicks? Why the difference? Because with "distinct()" selects only what is unique, and if we have 95 distinct observations, then it means that 5 were duplicated.


# Without a custom function -----------------------------------------------

#We want to estimate where chicks hatched using tidyverse functions. Here’s our process:
  
 # For each bird, where was it seen most often?
# If multiple sites are tied, choose the one with the earliest observation
# If still tied, randomly choose one

# The code below consists of three pipelines (sequences of commands linked by pipes). Each pipeline has been shuffled.  Q4 Sort the pipelines back into correct order.

# Find most frequent beach per bird
beach_freq <- bloy_chicks %>% 
  group_by(bird) %>% 
  count(bird, beach) %>% 
  filter(n == max(n)) %>% 
  ungroup()

# Find first date for each bird+beach
beach_early <- bloy_chicks %>%   
  group_by(bird, beach) %>% 
  summarize(earliest = min(survey),
              .groups = "drop")

  # Join the two conditions and retain most frequent beach, only earliest
hatch_beach <- beach_freq %>%  
  left_join(beach_early, by = c("bird", "beach")) %>% 
  group_by(bird) %>% 
  filter(earliest == min(earliest)) %>% 
  sample_n(1) %>% # Randomly choose 1 row. See ?sample_n = "sample_n() and sample_frac() have been superseded in favour of slice_sample()".huh!
  ungroup()


# With a custom function ------------------------------------------------------

#There are two issues with the approach above: 1) It’s kind of long and we have to make multiple intermediate data frames. So it’s not the easiest code to read. 2),The logic for estimating a hatching beach is spread out across multiple locations in the code.If we choose a different approach then we have to change everything!
 
#Here’s a different approach using a custom function: 1)Put the logic for estimating the hatching beach in a single function. 2) Group the data by bird. 3)Summarize each group using your custom function.

#This is an example of a split-apply-combine strategy. Use group_by() to split our data frame by bird. Write a custom function to estimate the hatching beach for that bird. That’s critical: this function works on just one part of the whole! Use summarize() to apply our function to each bird and combine the results.

#Below is a skeleton of the custom function with key pieces missing, followed by a split-apply-combine skeleton.

find_hatching_beach <- function(site, date) {
  # Start with a data frame (or tibble) of site and date for *one* bird
  # Use pipes and dplyr functions to find the hatching beach.  
  # Use as many pipes and dplyr functions as necessary
  bird_observations <- tibble(site, date)
  result <- bird_observations %>% 
    group_by(site) %>% 
    summarize (count = n ()) %>% 
    arrange(desc(count)) %>%
    slice(1)
  # result should end up as a data frame with one row for the hatching beach
  return(result$site) # return the hatching beach
}

# split-apply-combine
bloy_chicks %>% 
  group_by(bird) %>% 
  summarize(hatching_beach = find_hatching_beach(beach,survey)) 

# Q5 The two parameters of find_hatching_beach() are named site and date. When this function is called, what columns in bloy_chicks will you use as arguments for these parameters? beach and survey.

# Q6 What will be the value of site when find_hatching_beach() is called on the group for bird YWG? Main. How about WYB? Cowell's.


