########################################
# initialize_project() sets up a project
# by creating a directory structure
# and a project-specific metadata file
# written by shelby bachman
# last updated 2021-03-22
########################################

initialize_project <- function(project_name, 
                               project_descrip, 
                               project_abbrev, 
                               home_dir, 
                               rstudio_project = TRUE,
                               git_repo = TRUE,
                               osf_project = TRUE,
                               verbose = TRUE) {
  
  ###### create project root directory 
  if (dir.exists(file.path(home_dir, project_abbrev))){
    stop('project root directory already exists. Try again!')
  } else {
    dir.create(file.path(home_dir, project_abbrev), showWarnings = TRUE)
    if (verbose == TRUE) {
      message(paste('created project root directory: ', file.path(home_dir, project_abbrev), ' ...', sep = ''))
    }
  }
  
  ###### create R project
  usethis::create_project(file.path(home_dir, project_abbrev),
                          rstudio = rstudio_project,
                          open = FALSE)  # don't open the project in a new session
  # tba: customize project settings
  
  ###### create project subdirectory structure
  ### /data
  # based on this standard: Wilson et al., https://doi.org/10.1371/journal.pcbi.1005510
  dir.create(file.path(home_dir, project_abbrev, 'data'))
  if (verbose == TRUE) {
    message(paste('created data subdirectory: ', project_abbrev, '/data', ' ...', sep = ''))
  }
  dir.create(file.path(home_dir, project_abbrev, 'data', 'derivatives'))  # directory for derivatives
  dir.create(file.path(home_dir, project_abbrev, 'data', 'rawdata'))  # directory for shareable data
  dir.create(file.path(home_dir, project_abbrev, 'data', 'sourcedata'))  # directory for very raw data
  
  ### /doc
  dir.create(file.path(home_dir, project_abbrev, 'doc'))
  if (verbose == TRUE) {
    message(paste('created doc subdirectory: ', project_abbrev, '/doc', ' ...', sep = ''))
  }
  dir.create(file.path(home_dir, project_abbrev, 'doc', 'literature_search'))  # directory for literature search results
  dir.create(file.path(home_dir, project_abbrev, 'doc', 'preregistration'))  # directory for pre-registration
  dir.create(file.path(home_dir, project_abbrev, 'doc', 'manuscript'))  # directory for manuscript
  dir.create(file.path(home_dir, project_abbrev, 'doc', 'slides'))  # directory for slides
  
  ### /results
  dir.create(file.path(home_dir, project_abbrev, 'results'))
  if (verbose == TRUE) {
    message(paste('created results subdirectory: ', project_abbrev, '/results', ' ...', sep = ''))
  }
  
  ### /src
  dir.create(file.path(home_dir, project_abbrev, 'src'))
  if (verbose == TRUE) {
    message(paste('created src subdirectory: ', project_abbrev, '/src', ' ...', sep = ''))
  }
  
  ###### initialize git repository
  if (git_repo == TRUE) {
    usethis::use_git(message = 'initialize project')    
  }
  
  ###### initialize (private) OSF project
  if (osf_project == TRUE) {
    osf_proj <- osf_create_project(
      title = project_name,
      description = project_descrip
    )
    message(paste('created (private) OSF project! project link: https://www.osf.io/', osf_proj$id, sep = ''))
  }
  
  ###### build studymanageR-specific json file
  project_info <- list(
    project_name = project_name, 
    project_descrip = project_descrip,
    project_abbrev = project_abbrev, 
    home_dir = home_dir, 
    root_dir = file.path(home_dir, project_abbrev),
    rstudio_project = rstudio_project,
    git_repo = git_repo,
    osf_project = osf_project,
    osf_guid = ifelse(osf_project == TRUE, osf_proj$id, NA),
    osf_url = ifelse(osf_project == TRUE, paste('http://www.osf.io/', osf_proj$id, sep = ''))
  )
  project_info <- jsonlite::toJSON(project_info)
  write(project_info, file.path(home_dir, project_abbrev, paste(project_abbrev, '_info.json', sep = '')))
  if (verbose == TRUE) {
    message(paste('saved project metadata: ', project_abbrev, '/', project_abbrev, '_info.json', ' ...', sep = ''))
  }
    
  ###### final status message
  if (verbose == TRUE) {
    message('all done initializing project!')
  }
}
