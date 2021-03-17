########################################
# initialize_project() sets up a project
# by creating a directory structure
# and a project-specific metadata file
# written by shelby bachman
# last updated 2021-03-17
########################################

initialize_project <- function(study_name, home_dir, 
                               rstudio_project = TRUE,
                               verbose = TRUE) {
  
  ###### create project root directory 
  if (dir.exists(file.path(home_dir, study_name))){
    stop('Project root directory already exists. Try again!')
  } else {
    dir.create(file.path(home_dir, study_name), showWarnings = TRUE)
    if (verbose == TRUE) {
      message(paste('created project root directory: ', file.path(home_dir, study_name), ' ...', sep = ''))
    }
  }
  
  ###### create R project
  usethis::create_project(file.path(home_dir, study_name),
                          rstudio = rstudio_project,
                          open = FALSE)  # don't open the project in a new session
  # tba: customize project settings
  
  ###### create project subdirectory structure
  ### /data
  # based on this standard: Wilson et al., https://doi.org/10.1371/journal.pcbi.1005510
  dir.create(file.path(home_dir, study_name, 'data'))
  if (verbose == TRUE) {
    message(paste('created data subdirectory: ', study_name, '/data', ' ...', sep = ''))
  }
  dir.create(file.path(home_dir, study_name, 'data', 'derivatives'))
  dir.create(file.path(home_dir, study_name, 'data', 'rawdata'))
  dir.create(file.path(home_dir, study_name, 'data', 'sourcedata'))
  
  ### /doc
  dir.create(file.path(home_dir, study_name, 'doc'))
  if (verbose == TRUE) {
    message(paste('created doc subdirectory: ', study_name, '/doc', ' ...', sep = ''))
  }
  
  ### /results
  dir.create(file.path(home_dir, study_name, 'results'))
  if (verbose == TRUE) {
    message(paste('created results subdirectory: ', study_name, '/results', ' ...', sep = ''))
  }
  
  ### /src
  dir.create(file.path(home_dir, study_name, 'src'))
  if (verbose == TRUE) {
    message(paste('created src subdirectory: ', study_name, '/src', ' ...', sep = ''))
  }
  
  ###### build studymanageR-specific json file
  project_info <- list(
    study_name = study_name,
    root_dir = file.path(home_dir, study_name)
  )
  project_info <- jsonlite::toJSON(project_info)
  write(project_info, file.path(home_dir, study_name, paste(study_name, '_info.json', sep = '')))
  if (verbose == TRUE) {
    message(paste('saved project metadata: ', study_name, '/', study_name, '_info.json', ' ...', sep = ''))
  }
  
  ###### initialize git repository
  usethis::use_git(message = 'initialize project')
  
  ###### final status message
  if (verbose == TRUE) {
    message('all done initializing project!')
  }
}
