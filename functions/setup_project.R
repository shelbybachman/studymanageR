home_dir <- '/home/shelby/personal/experimentR'
study_name <- 'test_project'

setup_project <- function(study_name, home_dir, 
                          n_sessions = 1,
                          session_labels = NA,
                          n_groups = 1,
                          group_labels = NA,
                          n_pergroup = 1,
                          first_subject_pergroup = 1001,
                          ) {
  
  ### create project root directory 
  if (dir.exists(here::here(home_dir, study_name))){
    stop('Project root directory already exists. Try again!')
  } else {
    dir.create(here::here(home_dir, study_name), showWarnings = TRUE)
  }
  
  ### create project subdirectories
  # based on this standard: Wilson et al., https://doi.org/10.1371/journal.pcbi.1005510
  dir.create(here::here(home_dir, study_name, 'data'))
  dir.create(here::here(home_dir, study_name, 'data', 'derivatives'))
  dir.create(here::here(home_dir, study_name, 'data', 'rawdata'))
  dir.create(here::here(home_dir, study_name, 'data', 'sourcedata'))
  dir.create(here::here(home_dir, study_name, 'doc'))
  dir.create(here::here(home_dir, study_name, 'results'))
  dir.create(here::here(home_dir, study_name, 'src'))
  
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
  
  ### build experimentR-specific json file
  
  
  
}