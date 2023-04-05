# ADSExercise

## Usage
To work with the project you need to install:
- [poetry](https://python-poetry.org/docs/#installation)
- [poethepoet](https://github.com/nat-n/poethepoet) in your global python env (`pip install poethepoet`)
Afterwards run:
```
poetry install
```

### Dependency management
All dependencies are manged using `poetry`.
Poetry will automatically create a new venv for the project, when you run `poetry install`.
Check out the [documentation](https://python-poetry.org/docs/basic-usage/) on how to add and remove dependencies.

### Jupyter Notebooks
To use jupyter notebooks with the project you need to add a jupyter kernel pointing to the venv of the project.
This can be done by running:
```
poe register_ipykernel
```
Afterwards a new kernel called `ads_exercise` should be available in the jupyter lab / jupyter notebook interface.
Use that kernel for all notebooks related to this project.

## abc-classroom
|**abc-init**||
|:-|:-|
|description|creates a GitHub personal access token, locally stored in file .abc-classroom.tokens.html|

|**abc-quickstart**||
|:-|:-|
|description|sets up a new course|
|*arguments*||
|<course_name>|name of the course directory, e.g., course_directory|
|-f|overwrite existing folder structure|

|**abc-new-template**||
|:-|:-|
|description|creates a git repository from a directory of course materials and pushes the repo to the GitHub organization to be used as assignment template|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|
|--github|push template repository to github organization|
|--mode <br /> &emsp; delete <br /> &emsp; merge <br /> &emsp; fail|If template repo already exists <br /> delete: delete contents before proceeding <br /> merge: keep existing directory, overwrite existing files <br /> fail: add new files|
|--custom message|use a custom commit message for git (opens the default git text editor for entry)|

|**abc-update-template**||
|:-|:-|
|description|updates an existing template repository based on local changes to course materials|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|
|--mode <br /> &emsp; delete <br /> &emsp; merge|If template repo already exists <br /> delete: delete contents before proceeding <br /> merge: keep existing directory <br /> overwrite existing files

|**abc-clone**||
|:-|:-|
|description|clones each of the student repositories and copies submitted assignments into your course materials|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|
|--skip-existing|do not update existing repos|
|--no-submitted|skip moving files from cloned repo to submitted directory|

|**abc-feedback**||
|:-|:-|
|description|copies feedback report from your course materials directory into local student repositories and then pushes to GitHub|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|
|--github|push feedback to students’ repos|
|--scrub|clean out hidden tests from notebook when used|

## nbgrader
|**nbgrader quickstart**||
|:-|:-|
|description|create nbgrader directory for autograding|
|*arguments*||
|<nbgrader_name>|name of nbgrader directory|
|-f --force|overwrite existing files if they already exist|

|**nbgrader generate_assignment**||
|:-|:-|
|description|generate student version of the assignment in the release directory|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|
|--no-db|do not save information into the database|
|--no-metadata|do not validate or modify cell metadata|
|-f --force|overwrite an assignment if it already exists|

|**nbgrader autograde**||
|:-|:-|
|description|autograde assignment|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|
|-f --force|overwrite if autograded assignment already exists|

|**nbgrader generate_feedback**||
|:-|:-|
|description|generate feedback to students|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|

|**nbgrader validate**||
|:-|:-|
|description|validate that the solution version of the notebook passes all the tests|
|*arguments*||
|<file_name>|name of the file to be validated, e.g., “problem_1.ipynb” <br /> <nbgrader_dir>/source/<assignment_name>/*.ipynb|
|--invert|validate that the students’ version doesn’t pass any tests <br /> <file_name>: <nbgrader_dir>/release/<assignment_name>/*.ipynb|

|**nbgrader export**||
|:-|:-|
|description|export gradebook as csv file|
|*arguments*||
|--assignment|name of assignment in nbgrader directory|
|--to|destination to export, e.g., “grades_assignment_1.csv”|

## nbgrader database
With the following comments it is possible to manage students and assignments in the database. Usually, this is done inherently by nbgrader and abc-classroom commands. More information about the commands can be found [here](https://nbgrader.readthedocs.io/en/latest/user_guide/managing_the_database.html).
|**nbgrader db student**||
|:-|:-|
|description|managing student in database|
|*arguments*||
|add|add student to the nbgrader database|
|import|import students into nbgrader database from a csv file|
|remove|remove student from the nbgrader database|
|list|list students in nbgrader database|

|**nbgrader db assignment**||
|:-|:-|
|description|managing assignments in database|
|*arguments*||
|add|add an assignment to the nbgrader database|
|import|import assignment into nbgrader database from csv file|
|remove|remove an assignment from the nbgrader database|
|list|list assignment in the nbgrader database|



|****||
|:-|:-|
|description||
|*arguments*||
