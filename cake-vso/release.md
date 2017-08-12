## Useful information

* [VSTS Publisher](https://marketplace.visualstudio.com/manage/publishers/cake-build)

## Repository Pre-requisites

1. Install the tfx-cli
  `npm install -g tfx-cli`

## GitHub Issues Pre-requisites

1. Make sure all issues within the milestone are tagged with either Bug, Feature, Improvement, Documentation
1. Make sure all issues associated with the milestone are closed

## When doing a release

1. Create branch locally to match the name of the release, for example `git checkout -b release/0.7.0 develop`
1. Run `.\build.ps1 -target releasenotes` to generate a draft GitHub Release
1. Assuming everything is ok, switch to `master` branch (`git checkout master`)
1. Merge release branch to the `master` `git merge --no-ff release/0.7.0`
1. Push `master` branch.
1. Click the Publish button on the GitHub release.  This will tag the repository and trigger another build on AppVeyor
1. Switch to `develop` branch `git checkout develop`
1. Merge release branch into develop `git merge --no-ff release/0.7.0`
1. Resolve any merge conflicts
1. Push `develop` branch.
1. Delete the local release branch that was created `git branch -d release/0.7.0` (and the remote one, if pushed to GitHub `git push origin --delete release/0.7.0`)

## When doing a hotfix

1. Create branch locally to match the name of the hotfix, for example `git checkout -b hotfix/0.6.4 master`
1. If there is an open Pull Request, pull this into the newly created branch `git pull https://github.com/devlead/cake.git hotfix/0.6.4`
1. Run `.\build.ps1 -target releasenotes` to generate a draft GitHub Release
1. Assuming everything is ok, switch to `master` branch (`git checkout master`)
1. Merge hotfix branch into `master` `git merge --no-ff hotfix/0.6.4`
1. Push `master` branch.
1. Click the Publish button on the GitHub release.  This will tag the repository and trigger another build on AppVeyor
1. Switch to `develop` branch `git checkout develop`
1. Merge hotfix branch into develop `git merge --no-ff hotfix/0.6.4`
1. Resolve any merge conflicts
1. Push `develop` branch.
1. Delete the local hotfix branch that was created `git branch -d hotfix/0.6.4` (and the remote one, if pushed to GitHub `git push origin --delete hotfix/0.6.4`)

## After a release/hotfix

1. Log into the VSTS Marketplace
1. Make sure that the extension was published successfully
1. If this hasn't happened, download the VSIX file from the GitHub Release
1. Hover over the Cake VSTS extension in the marketplace website and select Update
1. Select the VSIX file and Click Upload
1. Make sure that everything has pushed correctly to VSTS Marketplace
  * [cake-build.cake](https://marketplace.visualstudio.com/items?itemName=cake-build.cake)
1. Go to the Gitter Room for Cake, and let people know there that a new release is ready
1. Go to Twitter and make sure that people know that a new release is ready
1. Go and have a drink!