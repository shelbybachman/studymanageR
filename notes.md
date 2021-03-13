# studymanageR

## description

`studymanageR` is a package for experimental research project management. The goals of `studymanageR` are (a) to facilitate the use of standard file & directory naming conventions and (b) to facilitate open & reproducible research practices.

## main functioms

- `create_prereg.R`: creates pre-registration draft for project

  - user can choose between standard, AsPredicted, or replication pre-registration templates
  - user can specify citation style and whether pre-registration is knitted to `.docx` or `pdf`
  - instructions should specify how to push pre-registration draft to Google Drive for collaborator input

- `upload_prereg.R`: creates OSF project & uploads preregistration draft to OSF

- `setup_project.R`: creates directory structure for project and project-specific metadata file

  - user probably has to create R project manually, based on [this](https://www.tidyverse.org/blog/2017/12/workflow-vs-script/) standard

- `format_results.R`: takes results files & converts to bids format

- `create_manuscript.R`: creates manuscript draft for project

- `prepare_for_sharing.R`: creates standardized dataset descriptor files for public sharing

- `upload_project.R`: uploads manuscript, data & scripts to OSF

## dependencies

- `here`
- `rjson`
- `osfr`
