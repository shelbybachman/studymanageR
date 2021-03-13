########################################
# create_data_dirs_bids()
# creates standardized data subdirectories
# according to the brain imaging data structure specification
# https://bids-specification.readthedocs.io/

# written by shelby bachman
# last updated 2021-03-13
########################################

# tba: initialize git repository via command line

create_data_dirs_bids <- function(study_name,
                             n_sessions = 1,
                             session_labels = NA,
                             n_groups = 1,
                             group_labels = NA,
                             n_pergroup = 1,
                             first_subject_pergroup = 1001,
                             verbose = TRUE
) {
  

  
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
  
  
  ###### build studymanageR-specific json file
  ###### read studymanageR-specific json file
  file_json <- json <- here::here(paste(study_name, '_info.json', sep = ''))
  project_info <- jsonlite::read_json(file_json)
  project_info <- c(project_info,
                    list(
                        n_sessions = n_sessions,
                        session_labels = session_labels,
                        n_groups = n_groups,
                        group_labels = group_labels,
                        n_pergroup = n_pergroup,
                        n_total = n_pergroup*n_groups,
                        participants = paste('sub-', sub_dirs, sep = '')
                        )
  )
  project_info <- jsonlite::toJSON(project_info)
  write(project_info, file_json)
  if (verbose == TRUE) {
    message(paste('updated project metadata: ', study_name, '/', study_name, '_info.json', ' ...', sep = ''))
  }
  
  if (verbose == TRUE) {
    message('all done creating data subdirectories!')
  }
}