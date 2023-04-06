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

## Directories
<course_dir>: ads_exercise/course_directory<br />
<nbgrader_dir>: ads_exercise/course_directory/ads_exercise

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
|--mode <br /> &emsp; delete <br /> &emsp; merge|If template repo already exists <br /> delete: delete contents before proceeding <br /> merge: keep existing directory, overwrite existing files

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

## Workflow (work in progress)
|**Material development**||
|:-|:-|
|Develop assignment materials|<ul><li>in<nbgrader_dir>/source/<assignment_name></li><li><assignment_name> in lowercase and no special characters</li><li>notebooks in jupyter not colab</li><li>prepare the assignment using the nbgrader tools</li></ul>| 
|Create student version|<ul><li>in <nbgrader_dir>/release/<assignment_name></li><li>remove the kernel in release version (students otherwise will get a warning when opening the notebook in colab)</li><li>add any other required material to the directory</li></ul>|

|**GitHub Classroom assignment preparation**||
|:-|:-|
|Create template repository|<ul><li>in <course_dir>/template_repos/<assignment_name>-template</li><li>push the repository to GitHub</li><li>change the repository settings in GitHub</li><ul><li>repository to template repository</li><li>repository visibility to private</li></ul></ul>|
|Create GitHub Classroom assignment|<ul><li>set deadline</li><li>link the respective template repository</li><li>assignment name in GitHub classroom should match the one used in nbgrader_dir</li></ul>|
|Adjust notebook in Colab|<ul><li>add GitHub Classroom assignment link</li><li>make the changes indicated with TODO</li><li>push back to repo, check the colab link checkbox</li></ul>|
|Add html to pdf converter|<ul><li>clone template repository locally</li><li>add the .github/workflow directory (generates pdf from feedback html file on push)</li><li>change the assignment name in workflow</li></ul>|
|Adjust README|<ul><li>remove placeholders</li></ul>|
|Optional: Test Assignment prior release to students|<ul><li>once an assignment is graded nbgrader will not allow to release it again</li><li>workaround: delete the assignment from the database<br />nbgrader db assignment remove <assignment-name> --force</li></ul>|

|**Students work phase**||
|:-|:-|
|work phase|<ul><li>give students assignment link</li><li>students accept assignment</li><li>complete work</li><li>submit by pushing to their github repository</li></ul>|

|**Grading Feedback**||
|:-|:-|
|Student roster|<ul><li>check if the student roster changed compared to the last assignment</li><li>Clone student repositories</li><li>to <course_dir>/cloned_repos/</li><li>copy files to <nbgrader_dir>/submitted</li></ul>|  
|Grading|<ul><li>run autograde</li><li>add manual grading</li><ul><li>launch jupyter lab from nbgrader_dir</li><li>open students’ notebooks from autograded folder, select manual grading</li></ul></ul>|
|Feedback|<ul><li>Generate feedback html files and push them to students’ repositories</li></ul>|

|**Export grades**||
|:-|:-|
|Export grades|from gradebook.db|
  
  

<li></li>
</li><li>


|****||
|:-|:-|
|description||
|*arguments*||
