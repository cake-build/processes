## Useful information

* [Visual Studio Gallery](https://visualstudiogallery.msdn.microsoft.com/)

This will be needed to manually upload the generated VSIX file, as there is no "easy" way to automate that process today.  You need to log into this site with the `cake-build@outlook.com` account in the LastPass folder.

## GitHub Issues Pre-requisites

1. Make sure all issues within the milestone are tagged with either Bug, Feature, Improvement, Documentation
1. Make sure all issues associated with the milestone are closed

## Build Pre-requisites

1. Ensure you have system environment variables called `CAKEVS_GITHUB_USERNAME` and `CAKEVS_GITHUB_PASSWORD` set up with credentials of someone who can create release notes on the cake-vs repository.

## When doing a release

1. Create branch locally to match the name of the release, for example `git checkout -b release/0.7.0 develop`
1. Run `.\build.ps1`
1. Assuming everything is ok, switch to `master` branch (`git checkout master`)
1. Merge release branch to the `master` `git merge --no-ff release/0.7.0`
1. Run `.\build.ps1 --target=create-release-notes` to generate a draft GitHub Release
1. Push `master` branch.
1. Click the Publish button on the GitHub release.  This will tag the repository and trigger another build on AppVeyor
1. Switch to `develop` branch `git checkout develop`
1. Merge release branch into develop `git merge --no-ff release/0.7.0`
1. Resolve any merge conflicts
1. Push `develop` branch.
1. Delete the local release branch that was created `git branch -d release/0.7.0` (and the remote one, if pushed to GitHub `git push origin --delete release/0.7.0`)

## When doing a hotfix

1. Create branch locally to match the name of the hotfix, for example `git checkout -b hotfix/0.6.4 master`
1. If there is an open Pull Request, pull this into the newly created branch `git pull https://github.com/devlead/cake-vs hotfix/0.6.4`
1. Run `.\build.ps1`
1. Assuming everything is ok, switch to `master` branch (`git checkout master`)
1. Merge hotfix branch into `master` `git merge --no-ff hotfix/0.6.4`
1. Run `.\build.ps1 --target=create-release-notes` to generate a draft GitHub Release
1. Push `master` branch.
1. Click the Publish button on the GitHub release.  This will tag the repository and trigger another build on AppVeyor
1. Switch to `develop` branch `git checkout develop`
1. Merge hotfix branch into develop `git merge --no-ff hotfix/0.6.4`
1. Resolve any merge conflicts
1. Push `develop` branch.
1. Delete the local hotfix branch that was created `git branch -d hotfix/0.6.4` (and the remote one, if pushed to GitHub `git push origin --delete hotfix/0.6.4`)

## After doing release/hotfix

1. Now we need to actually publish the extension
1. Navigate to [AppVeyor](https://ci.appveyor.com/project/cakebuild/cake-vs/history) for the completed build which was tagged with the version number that has been created
1. Download the Cake.VisualStudio.vsix file, which should be in the artifacts tab
1. Navigate ane log into the Visual Studio Gallery linked above
1. Click on `Publish Extension` on the top right corner
1. Click on `Cake for Visual Studio`
1. Click on `Edit`
1. Click on `Change` in the `Upload` section
1. Click on `OK` in the warning that pops up
1. Click on `Choose File`
1. Find the file that you just downloaded from AppVeyor Artifacts and click `OK`
1. Click `Next`
1. Ensure that the Version number matches what you expect for the release you are completing
1. Update the description if required
1. Click `Save`
