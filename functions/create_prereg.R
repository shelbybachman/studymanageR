########################################
# create_prereg()
# creates a pre-registration draft
# based on the user's format of interest

# written by shelby bachman
# last updated 2021-03-24
########################################

create_prereg <- function(study_abbrev,
                          prereg_type = 'osf') {
  
  # read study metadata
  here::here(paste(study_abbrev, '_info.json', sep = ''))
  
  # copy template of pre-registration draft
  if (prereg_type == 'osf') {
    file.copy(from = 'studymanageR/test_project/templates_prereg/prereg_template_osf.Rmd',  # tba 
              to = here::here('doc', 'preregistration', paste(study_abbrev, '_preregistration.Rmd', sep = '')))
  } else if (prereg_type == 'aspredicted') {
    file.copy(from = 'studymanageR/test_project/templates_prereg/prereg_template_AsPredicted.Rmd',  # tba 
              to = here::here('doc', 'preregistration', paste(study_abbrev, '_preregistration.Rmd', sep = '')))
  } else if (prereg_type == 'replication') {
    file.copy(from = 'studymanageR/test_project/templates_prereg/prereg_template_replication.Rmd',  # tba 
              to = here::here('doc', 'preregistration', paste(study_abbrev, '_preregistration.Rmd', sep = '')))
  }

  # tba: update .Rmd with study title
  
}
