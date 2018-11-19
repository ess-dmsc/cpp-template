# Template C++ Project

A starting point for new ESS DMSC C++ projects with boilerplate/default:
- CMake
- Conan
- github PR template
- unit tests (gtest)
- code documentation (doxygen, "docs" CMake target)
- docker configuration

Currently missing some things, see issues.

## How to use

Simply clone this repository, create a new repository on github and do:
```
git remote rename origin old-origin
git remote add origin git@gitlab.com:ess-dmsc/name-of-new-repository.git
git push -u origin --all
```
Then replace the readme with one appropriate for the new project.
