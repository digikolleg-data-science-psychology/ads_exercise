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

## Workflow (work in progress)
|**Material development**||
|:-|:-|
|Develop assignment materials|<ul><li>in <nbgrader_dir>/source/<assignment_name></li><li><assignment_name> in lowercase and no special characters</li><li>notebooks in jupyter not colab</li><li>prepare the assignment using the nbgrader tools</li></ul>| 
|Create student version|[nbgrader generate_assignment](#nbgrader-generate_assignment) <assignment_name> <ul><li>in <nbgrader_dir>/release/<assignment_name></li><li>add any other required material to the directory</li></ul>|

|**GitHub Classroom assignment preparation**||
|:-|:-|
|Create template repository|[abc-new-template](#abc-new-template) <assignment_name> [--github]<ul><li>in <course_dir>/template_repos/<assignment_name>-template</li><li>push the repository to GitHub</li></ul>Change GitHub repository settings<ul><li>repository to template repository</li><li>check if the repository visibility is set to public</li></ul>|
|Create GitHub Classroom assignment|<ul><li>set deadline</li><li>check the box "This is a cutoff date"</li><li>link the respective template repository</li><li>assignment name in GitHub classroom should match the one used in nbgrader_dir</li></ul>|
|Adjust notebook in Colab|<ul><li>make any changes indicated with TODO</li><li>in ``Runtime > Change runtime type`` change Runtime type from ads_exercise to Python 3 </li><li>push back to repo, check the colab link checkbox</li></ul>|
|Add html to pdf converter|<ul><li>clone template repository locally</li><li>add the .github/workflow directory (generates pdf from feedback html file on push)</li><li>change the assignment name in workflow</li></ul>|
|Adjust README|<ul><li>change title to "Applied Data Science in Medicine & Psychology - Assignment \<XX\></li><li>remove placeholders</li></ul>|
|Optional: Test Assignment prior release to students|After autograde testing: <ul><li>once an assignment is graded nbgrader will not allow to release it again</li><li>workaround: delete the assignment from the database<br />nbgrader db assignment remove <assignment-name> --force ([nbgrader db assignment](#nbgrader-db-assignment))</li><li>generate the assignment to add the assignment again to the database ([nbgrader generate_assignment](#nbgrader-generate_assignment))</li></ul>|
|Add assignment link to StudOn|Make the assignment link public to students enrolled in the course|

|**Students work phase**||
|:-|:-|
|work phase|<ul><li>students accept assignment</li><li>complete work</li><li>submit by pushing to their github repository</li></ul>|

|**Grading Feedback**||
|:-|:-|
|Student roster|<ul><li>check if the student roster changed compared to the last assignment</li></ul>[abc-clone](#abc-clone)<ul><li>clone student repositories</li><li>to <course_dir>/cloned_repos/</li><li>copy files to <nbgrader_dir>/submitted</li></ul>|  
|Grading|[nbgrader autograde](#nbgrader-autograde)<ul><li>run autograde</li></ul>Add manual grading<ul><li>launch jupyter lab from nbgrader_dir</li><li>open students’ notebooks from autograded folder, select manual grading</li></ul>|
|Feedback|[nbgrader generate_feedback](#nbgrader-generate_feedback)<ul><li>generate feedback html files</li></ul>[abc-feedback](#abc-feedback)<ul><li>push html files to students’ repositories</li></ul>|

|**Export grades**||
|:-|:-|
|Export grades|[nbgrader export](#nbgrader-export)<ul><li>from gradebook.db</ul></li>|

## abc-classroom
Use commands from <course_dir>.
|**abc-init**||
|:-|:-|
|description|creates a GitHub personal access token, locally stored in file .abc-classroom.tokens.html|

|**abc-quickstart**||
|:-|:-|
|description|sets up a new course|
|*arguments*||
|<course_name>|name of the course directory, e.g., course_directory|
|-f|overwrite existing folder structure|

|<a name=abc-new-template>**abc-new-template**</a>||
|:-|:-|
|description|creates a git repository from a directory of course materials and pushes the repo to the GitHub organization to be used as assignment template|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|
|--github|push template repository to github organization|
|--mode <br /> &emsp; delete <br /> &emsp; merge <br /> &emsp; fail|If template repo already exists <br /> delete: delete contents before proceeding <br /> merge: keep existing directory, overwrite existing files <br /> fail: add new files|
|--custom message|use a custom commit message for git (opens the default git text editor for entry)|

|<a name=abc-update-template>**abc-update-template**</a>||
|:-|:-|
|description|updates an existing template repository based on local changes to course materials|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|
|--mode <br /> &emsp; delete <br /> &emsp; merge|If template repo already exists <br /> delete: delete contents before proceeding <br /> merge: keep existing directory, overwrite existing files

|<a name=abc-clone>**abc-clone**</a>||
|:-|:-|
|description|clones each of the student repositories and copies submitted assignments into your course materials|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|
|--skip-existing|do not update existing repos|
|--no-submitted|skip moving files from cloned repo to submitted directory|

|<a name=abc-feedback>**abc-feedback**</a>||
|:-|:-|
|description|copies feedback report from your course materials directory into local student repositories and then pushes to GitHub|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|
|--github|push feedback to students’ repos|
|--scrub|clean out hidden tests from notebook when used|

**Mass clone all subdirectories** (can be helpful, when something went wrong during pushing feedback)

`find . -name ".git" -type d | sed 's/\/.git//' |  xargs -P10 -I{} git -C {} pull`

## nbgrader
Use commands from <nbgrader_dir>.
|**nbgrader quickstart**||
|:-|:-|
|description|create nbgrader directory for autograding|
|*arguments*||
|<nbgrader_name>|name of nbgrader directory|
|-f --force|overwrite existing files if they already exist|
 
|<a name=nbgrader-generate_assignment>**nbgrader generate_assignment**</a>||
|:-|:-|
|description|generate student version of the assignment in the release directory|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|
|--no-db|do not save information into the database|
|--no-metadata|do not validate or modify cell metadata|
|-f --force|overwrite an assignment if it already exists|

|<a name=nbgrader-autograde>**nbgrader autograde**</a>||
|:-|:-|
|description|autograde assignment|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|
|-f --force|overwrite if autograded assignment already exists|

|<a name=nbgrader-generate_feedback>**nbgrader generate_feedback**</a>||
|:-|:-|
|description|generate feedback to students|
|*arguments*||
|<assignment_name>|name of assignment in nbgrader directory|

|<a name=nbgrader-validate>**nbgrader validate**</a>||
|:-|:-|
|description|validate that the solution version of the notebook passes all the tests|
|*arguments*||
|<file_name>|name of the file to be validated, e.g., “problem_1.ipynb” <br /> <nbgrader_dir>/source/<assignment_name>/*.ipynb|
|--invert|validate that the students’ version doesn’t pass any tests <br /> <file_name>: <nbgrader_dir>/release/<assignment_name>/*.ipynb|

|<a name=nbgrader-export>**nbgrader export**</a>||
|:-|:-|
|description|export gradebook as csv file|
|*arguments*||
|--assignment|name of assignment in nbgrader directory|
|--to|destination to export, e.g., “grades_assignment_1.csv”|

## nbgrader database
With the following comments it is possible to manage students and assignments in the database. Usually, this is done inherently by nbgrader and abc-classroom commands. More information about the commands can be found [here](https://nbgrader.readthedocs.io/en/latest/user_guide/managing_the_database.html).

|<a name=nbgrader-db-student>**nbgrader db student**</a>||
|:-|:-|
|description|managing student in database|
|*arguments*||
|add|add student to the nbgrader database|
|import|import students into nbgrader database from a csv file|
|remove|remove student from the nbgrader database|
|list|list students in nbgrader database|

|<a name=nbgrader-db-assignment>**nbgrader db assignment**</a>||
|:-|:-|
|description|managing assignments in database|
|*arguments*||
|add|add an assignment to the nbgrader database|
|import|import assignment into nbgrader database from csv file|
|remove|remove an assignment from the nbgrader database|
|list|list assignment in the nbgrader database|
