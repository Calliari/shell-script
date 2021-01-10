### Update Drupal/Wordpress to latest version

## Introduction

When security releases are announced for Drupal/Wordpress, they are often time-critical.
This is bash script (within jenkins-scripts) which can be called from Jenkins with parameters for:

```
/path/to/script/update-drupal.sh --site-root=/var/www/bbd-d7.bbdtest.co.uk --branch=dev --cms=d7
```

* Site Root (e.g. /var/www/bbd-d7.bbdtest.co.uk, or /var/lib/jenkins/workspace/bbd-d7.bbdtest.co.uk_git_deploy)
* Branch (dev)
* CMS version (d7, d8, or wp)


================================================================
