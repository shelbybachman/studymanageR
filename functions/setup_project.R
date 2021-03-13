########################################
# setup_project() initializes a project
# by creating a directory structure
# and a project-specific metadata file
# written by shelby bachman
# last updated 2021-03-13
########################################

setup_project <- function(study_name, home_dir, 
                          n_sessions = 1,
                          session_labels = NA,
                          n_groups = 1,
                          group_labels = NA,
                          n_pergroup = 1,
                          first_subject_pergroup = 1001,
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
  
  ### create subject & session subdirectories
  # according to bids specification: https://bids.neuroimaging.io/specification
  sub_dirs <- NULL
  for (ii in 1:n_groups) {
    sub_dirs <- append(sub_dirs,
                       seq(from = first_subject_pergroup[ii], 
                        to = first_subject_pergroup[ii] + (n_pergroup - 1), 
                        by = 1))
  }
  
  if (n_sessions == 1) {
    for (ii in 1:length(sub_dirs)) {
      dir.create(here::here(home_dir, study_name, 'data', 'rawdata', 
                            paste('sub-', sub_dirs[ii], sep = '')))
    }
  } else if (n_sessions > 1) {
    for (ii in 1:length(sub_dirs)) {
      dir.create(here::here(home_dir, study_name, 'data', 'rawdata', 
                            paste('sub-', sub_dirs[ii], sep = '')))
      for (jj in 1:n_sessions) {
       dir.create(here::here(home_dir, study_name, 'data', 'rawdata', 
                             paste('sub-', sub_dirs[ii], sep = ''),
                             paste('ses-', session_labels[jj], sep = ''))) 
      }
    }
  }
  
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
  
  ###### build experimentR-specific json file
  project_info <- list(
    study_name = study_name,
    home_dir = here::here(home_dir, study_name), 
    n_sessions = n_sessions,
    session_labels = session_labels,
    n_groups = n_groups,
    group_labels = group_labels,
    n_pergroup = n_pergroup,
    n_total = n_pergroup*n_groups,
    participants = paste('sub-', sub_dirs, sep = '')
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
