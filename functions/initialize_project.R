########################################
# initialize_project() sets up a project
# by creating a directory structure
# and a project-specific metadata file
# written by shelby bachman
# last updated 2021-03-13
########################################

# tba: initialize git repository via command line

setup_project <- function(study_name, home_dir, 
                          verbose = TRUE
                          ) {
  
  ###### create project root directory 
  if (dir.exists(here::here(home_dir, study_name))){
    stop('Project root directory already exists. Try again!')
  } else {
    dir.create(here::here(home_dir, study_name), showWarnings = TRUE)
    if (verbose == TRUE) {
      message(paste('created project root directory: ', here::here(home_dir, study_name), ' ...', sep = ''))
    }
  }
  
  ###### create project subdirectory -- data
  # based on this standard: Wilson et al., https://doi.org/10.1371/journal.pcbi.1005510
  dir.create(here::here(home_dir, study_name, 'data'))
  if (verbose == TRUE) {
    message(paste('created data subdirectory: ', study_name, '/data', ' ...', sep = ''))
  }
  dir.create(here::here(home_dir, study_name, 'data', 'derivatives'))
  dir.create(here::here(home_dir, study_name, 'data', 'rawdata'))
  dir.create(here::here(home_dir, study_name, 'data', 'sourcedata'))
  
  ###### create project subdirectory - doc
  dir.create(here::here(home_dir, study_name, 'doc'))
  if (verbose == TRUE) {
    message(paste('created doc subdirectory: ', study_name, '/doc', ' ...', sep = ''))
  }
  
  ###### create project subdirectory - results
  dir.create(here::here(home_dir, study_name, 'results'))
  if (verbose == TRUE) {
    message(paste('created results subdirectory: ', study_name, '/results', ' ...', sep = ''))
  }
  
  ###### create project subdirectory - src
  dir.create(here::here(home_dir, study_name, 'src'))
  if (verbose == TRUE) {
    message(paste('created src subdirectory: ', study_name, '/src', ' ...', sep = ''))
  }
  
  ###### build studymanageR-specific json file
  project_info <- list(
    study_name = study_name,
    root_dir = here::here(home_dir, study_name)
  )
  project_info <- rjson::toJSON(project_info)
  write(project_info, here::here(home_dir, study_name, paste(study_name, '_info.json', sep = '')))
  if (verbose == TRUE) {
    message(paste('saved project metadata: ', study_name, '/', study_name, '_info.json', ' ...', sep = ''))
  }
  
  if (verbose == TRUE) {
    message('all done initializing project!')
  }
}
