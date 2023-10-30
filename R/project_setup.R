#BIOE215 Lesson 4 - Functions
#10/23/2023

#### ASSESSMENT  - Automating project setup

# Create a function called project_setup() that doesn’t take any parameters. In the function body, do the following:

  # Create the directories for a new project.
  # Add a README.md file to each directory that explains the purpose of that directory.
  # Return the character “SUCCESS!”... or "Éxito en la misión"

project_setup <- function () {
  dir.create("data")
  dir.create("docs")
  dir.create("figs")
  dir.create("outputs")
  dir.create("paper")
  dir.create("R")
  dir.create("reports")
  dir.create("scratch")
  
  file.create("data/README.md")
  file.create("docs/README.md")
  file.create("figs/README.md")
  file.create("outputs/README.md")
  file.create("paper/README.md")
  file.create("R/README.md")
  file.create("reports/README.md")
  file.create("scratch/README.md")
  
  writeLines("This folder contains data", 
             "data/README.md")
  writeLines("This folder contains documents", 
             "docs/README.md")
  writeLines("This folder contains figures", 
             "figs/README.md")
  writeLines("This folder contains outputs", 
             "outputs/README.md")
  writeLines("This folder contains documents/figures/tables/etc for the paper", 
             "paper/README.md")
  writeLines("This contains R related files", 
             "R/README.md")
  writeLines("This folder contains the generated reports", 
             "reports/README.md")
  writeLines("This folder contains irrelevant files", 
             "scratch/README.md")
  return("¡Éxito en la misión!")
  }
project_setup()



