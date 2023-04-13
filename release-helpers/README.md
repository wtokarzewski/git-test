# Scripts

**release-helpers** - scripts for version bumping on develop, rc-cutting and deploying master branch

**How to use release-helpers:**

1. Copy into a directory being on the same level as your projects, e.g.:
- /path/target_directory/
- **/path/target_directory/**

2. Run **sh check-dependencies.sh** to install all necessary libraries.

3. Go to repository you're working on.

4. Run scripts from release-helpers directory by typing (e.g.): **sh ../path/target_directory/release-helpers/bump-app-version.sh**

5. Release Steps 
    1. bump-app-version
    2. rc-cut
    3. pre-deploy-master
    4. deploy-master