# Load necessary libraries
library(readxl)
library(dplyr)

# Set the path to your Excel file
file_path <- "Footy_tips_scores_2024.xlsx"

# Load sheet names
sheet_names <- excel_sheets(file_path)

# Initialize a list to store round losers
round_losers <- list()

# Loop through each round sheet, excluding the "final" sheet
for (sheet_name in sheet_names[!sheet_names %in% "final"]) {
  # Read the data from the current round
  round_data <- read_excel(file_path, sheet = sheet_name)
  
  # Find the column containing the tips (e.g., "RD x Tips" column)
  tips_column <- names(round_data)[grepl("Tips", names(round_data)) & grepl("RD", names(round_data))]
  
  if (length(tips_column) > 0) {
    # Get the minimum tips for this round (lowest score)
    min_tips <- min(round_data[[tips_column]], na.rm = TRUE)
    
    # Identify all losers for this round (those with the lowest score)
    losers <- round_data %>%
      filter(!!sym(tips_column) == min_tips) %>%
      pull(`Team / Tipster`)
    
    # Store the round losers, including all tippers with the lowest score
    round_losers[[sheet_name]] <- losers
  }
}

# Convert the list to a data frame with each round and each loser listed
round_losers_df <- data.frame(
  Round = rep(names(round_losers), sapply(round_losers, length)),
  Loser = unlist(round_losers)
)

# Count losses per participant
loss_counts <- round_losers_df %>%
  count(Loser) %>%
  rename(Participant = Loser, Losses = n) %>%
  arrange(desc(Losses))

# Display results
print("Round Losers:")
print(round_losers_df)

print("Participants with Most Losses:")
print(loss_counts)
