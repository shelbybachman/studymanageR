# studymanageR

## description

`studymanageR` is a package for experimental research project management. The goals of `studymanageR` are (a) to facilitate the use of standard file & directory naming conventions and (b) to facilitate open & reproducible research practices.

## workflow & main functions

### project setup

- `initialize_project()`: creates directory structure for project, project-specific metadata file, and initializes git repository

- RStudio project setup: t this stage, user should create R project manually, ideally with [these](https://www.tidyverse.org/blog/2017/12/workflow-vs-script/) specifications

### literature search

- `lit_search_titles()`: performs literature search with specified keywords on specified databases, and returns a tab-delimited list of articles

- review of titles: user reviews selected titles and chooses those for next stage of review (abstracts)

- `lit_search_abstracts()`: returns tab-delimited list of abstracts for articles identified in title review

- review of abstracts: user reviews selected abstracts and chooses those for next stage of review (full-text)

- `lit_search_fulltext()`: returns available full-text articles identified in abstract review

- review of full texts: user reviews full-text articles and chooses those to be included in bibliography

- `create_bib()`: creates a .bib file from selected full-text articles for import into reference manager of choice

- `create_prereg()`: creates pre-registration draft for project

  - user can choose between standard, AsPredicted, or replication pre-registration templates
  - user can specify citation style and whether pre-registration is knitted to `.docx` or `pdf`
  - instructions should specify how to push pre-registration draft to Google Drive for collaborator input

- `upload_prereg()`: creates OSF project & uploads preregistration draft to OSF

- `create_data_dirs()`: creates specification-compliant data directories for public sharing

- `create_manuscript()`: creates manuscript draft for project

- `prepare_for_sharing()`: creates standardized dataset descriptor files for public sharing

- `upload_project()`: uploads manuscript, data & scripts to OSF

## dependencies

- `here`
- `rjson`
- `osfr`
