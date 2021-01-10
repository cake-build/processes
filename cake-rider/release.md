## Useful information

* [JetBrains Marketplace](https://plugins.jetbrains.com/marketplace/)
* [cake-build organization on the Marketplace](https://plugins.jetbrains.com/organization/cake-build)
* Though the plugin is `grade`/`kotlin`/`java` stuff the build- and release process is done by utilizing `cake.intellij.recipe` and therefore everything is very `cake.recipe`-like.

## GitHub Issues Pre-requisites

1. Make sure all issues within the milestone are tagged with either Bug, Feature, Improvement, Documentation
1. Make sure all issues associated with the milestone are closed

## Build Pre-requisites

1. Make sure you have `java` in at least version 1.8 installed (e.g. by running `choco install openjdk`)
1. Make sure you have a GitHub `pat` with permissions to create release notes in the environment variable `GITHUB_TOKEN` (This will change to `GITHUB_PAT` in the [near future](https://github.com/cake-contrib/Cake.Recipe/issues/700).)

## When doing a release

1. Create branch locally to match the name of the release, for example `git checkout -b release/0.7.0 develop`
1. Run `.\build.ps1`
1. Assuming everything is ok, switch to `master` branch (`git checkout master`)
1. Merge release branch to the `master` `git merge --no-ff release/0.7.0`
1. Run `.\build.ps1 --target=releasenotes` to generate a draft GitHub Release
1. Push `master` branch. (Wait for the AppVeyor build to finish.)
1. Click the Publish button on the GitHub release.  This will tag the repository and trigger another build on AppVeyor
1. Switch to `develop` branch `git checkout develop`
1. Merge release branch into develop `git merge --no-ff release/0.7.0`
1. Resolve any merge conflicts
1. Push `develop` branch.
1. Delete the local release branch that was created `git branch -d release/0.7.0` (and the remote one, if pushed to GitHub `git push origin --delete release/0.7.0`)

## When doing a hotfix

1. Create branch locally to match the name of the hotfix, for example `git checkout -b hotfix/0.6.4 master`
1. If there is an open Pull Request, pull this into the newly created branch `git pull https://github.com/nils-a/cake-rider hotfix/0.6.4`
1. Run `.\build.ps1`
1. Assuming everything is ok, switch to `master` branch (`git checkout master`)
1. Merge hotfix branch into `master` `git merge --no-ff hotfix/0.6.4`
1. Run `.\build.ps1 --target=releasenotes` to generate a draft GitHub Release
1. Push `master` branch. (Wait for the AppVeyor build to finish.)
1. Click the Publish button on the GitHub release.  This will tag the repository and trigger another build on AppVeyor
1. Switch to `develop` branch `git checkout develop`
1. Merge hotfix branch into develop `git merge --no-ff hotfix/0.6.4`
1. Resolve any merge conflicts
1. Push `develop` branch.
1. Delete the local hotfix branch that was created `git branch -d hotfix/0.6.4` (and the remote one, if pushed to GitHub `git push origin --delete hotfix/0.6.4`)

## After doing release/hotfix

If the above worked as described no further steps need to be done.

A **member of the cake-build organization in the JetBrains Marketplace** (see [above](#useful-information))
could check, whether on the [versions page of *Cake for Rider*](https://plugins.jetbrains.com/plugin/15729-cake-for-rider/versions)
the new version is visible  in the "Stable" channel.

## When will the new version appear it the marketplace

After it has been manually approved by JetBrains (shouldn't take longer than two days).
The approval or any modification request is mailed to the `cakebot`.
