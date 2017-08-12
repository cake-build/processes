## Useful information

* [AppVeyor builds](https://ci.appveyor.com/project/cakebuild/cake)
* [Travis builds](https://travis-ci.org/cake-build/cake)

## Repository Pre-requisites

### Manual Approach

1. Add the CAKE_GITHUB_USERNAME and CAKE_GITHUB_PASSWORD environment variables into your system. These should be of a user who has access to the Cake GitHub Repository.  **NOTE:** at the current time, the cake-build-bot doesn't seem to have the necessary rights to do this work.
1. Make sure `develop` branch of `cake-build/cake` is up to date `git fetch` then `git rebase origin/develop`.
1. Make sure `main` branch of `cake-build/cake` is up to date `git fetch` then `git rebase origin/main`.
1. Make sure `develop` branch of `cake-build/website` is up to date `git fetch` then `git rebase origin/develop`.
1. Make sure `master` branch of `cake-build/website` is up to date `git fetch` then `git rebase origin/master`.
1. Make sure `master` branch of `cake-build/example` is up to date `git fetch` then `git rebase origin/master`.
1. Make sure that all issues associated with pull requests getting released in this milestone are associated with the milestone, or that the pull request is associated with the milestone, if no issue was created.
1. Make sure you have a fork of `Homebrew/homebrew-core`
1. Make sure upstream points at `Homebrew/homebrew-core`
1. Make sure `master` branch of `Homebrew/homebrew-core` is up to date; `git fetch` then `git rebase upstream/master`.

### Automated Approach
1. Make sure you have a fork of `Homebrew/homebrew-core`.
1. Run the `Prereqs.ps1` file, using the following as an example `.\Prereqs.ps1 -GithubUsername gep13` (use your own username). This will clone a new version of all required repositories.

## GitHub Issues Pre-requisites

1. Make sure all issues within the milestone are tagged with either Bug, Feature, Improvement, Documentation, Breaking change, or Build
1. Make sure all issues associated with the milestone are closed
1. Make sure that all issues only have 1 label associated with them

## When doing a release

1. Create branch locally to match the name of the release, for example `git checkout -b release/0.7.0 develop`
1. Update `releasenotes.md` to include next version number as a placeholder and save the file
1. Create release notes on GitHub using the `ReleaseNotes` task (`.\build.ps1 -Target ReleaseNotes`)
1. Update `releasenotes.md` with generated content (making sure to keep the formatting the same)
1. Build everything (`./build.ps1`) to make sure it works.
1. Commit the changes to `releasenotes.md` and `solutioninfo.cs`. Use comment like `(build) Updated version and release notes.`
1. At this point, if you want to share the work to date, and validate something, push the local release branch to GitHub
1. Assuming everything is ok, switch to `main` branch (`git checkout main`)
1. Merge release branch to the `main` `git merge --no-ff release/0.7.0`
1. Build everything (`./build.ps1`) to make sure it works (we can never be too sure).
1. Push `main` branch.
1. Make sure that both the [AppVeyor](https://ci.appveyor.com/project/cakebuild/cake), [Bitrise Ubuntu](https://www.bitrise.io/app/b811c91a26b1ea80#/builds) and [Bitrise OSX](https://www.bitrise.io/app/7a9d707b00881436#/builds) builds succeed before going any further.
1. Assuming that everything went ok, go to the draft release in GitHub and click Edit
1. Click the Publish Release button
1. This will trigger another build in AppVeyor, but this time with a tag.
1. From the AppVeyor Log, take a note of the generated Hash from the `Publish-HomeBrew` task
1. Switch to `develop` branch `git checkout develop`
1. Merge release branch into develop `git merge --no-ff release/0.7.0`
1. Resolve any merge conflicts
1. Bump the Cake Tool Version number in `build.ps1` and `build.sh` to the latest released version, i.e. the version you just released
1. Build everything (`./build.ps1`) to make sure it works.
1. Commit the changes to `build.ps1` and `build.sh`  **NOTE:** There will be other changes to the *.json files as well, commit everything. Use commit message like `(build) Updated Cake tool to version 0.13.0`
1. Push `develop` branch.
1. Delete the local release branch that was created `git branch -d release/0.7.0` (and the remote one, if pushed to GitHub `git push origin --delete release/0.7.0`)

## When doing a hotfix

1. Create branch locally to match the name of the hotfix, for example `git checkout -b hotfix/0.6.4 main`
1. If there is an open Pull Request, pull this into the newly created branch `git pull https://github.com/devlead/cake.git hotfix/0.6.4`
1. Update `releasenotes.md` to include next version number as a placeholder and save the file
1. Create release notes on GitHub using the `ReleaseNotes` task (`.\build.ps1 -Target ReleaseNotes`)
1. Update `releasenotes.md` with generated content (making sure to keep the formatting the same)
1. Build everything (`./build.ps1`) to make sure it works.
1. Commit the changes to `releasenotes.md` and `solutioninfo.cs` Use comment like `(build) Updated version and release notes`.
1. At this point, if you want to share the work to date, and validate something, push the local hotfix branch to GitHub
1. Assuming everything is ok, switch to `main` branch (`git checkout main`)
1. Merge hotfix branch into `main` `git merge --no-ff hotfix/0.6.4`
1. Build everything (`./build.ps1`) to make sure it works (we can never be too sure).
1. Push `main` branch.
1. Make sure that both the [AppVeyor](https://ci.appveyor.com/project/cakebuild/cake) and [Bitrise Ubuntu](https://www.bitrise.io/app/b811c91a26b1ea80#/builds) and [Bitrise OSX](https://www.bitrise.io/app/7a9d707b00881436#/builds) builds succeed before going any further.
1. Assuming that everything went ok, go to the draft release in GitHub and click Edit
1. Click the Publish Release button
1. This will trigger another build in AppVeyor, but this time with a tag.
1. From the AppVeyor Log, take a note of the generated Hash from the `Publish-HomeBrew` task
1. Switch to `develop` branch `git checkout develop`
1. Merge hotfix branch into develop `git merge --no-ff hotfix/0.6.4`
1. Resolve any merge conflicts
1. Bump the Cake Tool Version number in `build.ps1` and `build.sh` to the latest released version, i.e. the version you just released
1. Commit the changes to `build.ps1` and `build.sh`. Use commit message like `(build) Updated Cake tool to version 0.13.0`
1. Build everything (`./build.ps1`) to make sure it works.
1. Push `develop` branch.
1. Delete the local hotfix branch that was created `git branch -d hotfix/0.6.4` (and the remote one, if pushed to GitHub `git push origin --delete hotfix/0.6.4`)

## After a release/hotfix

1. Make sure that everything has pushed correctly to nuget
  * [Cake](https://www.nuget.org/packages/Cake/)
  * [Cake.Core](https://www.nuget.org/packages/Cake.Core/)
  * [Cake.CoreCLR](https://www.nuget.org/packages/Cake.CoreCLR/)
  * [Cake.Common](https://www.nuget.org/packages/Cake.Common/)
  * [Cake.Testing](https://www.nuget.org/packages/Cake.Testing/)
  * [Cake.NuGet](https://www.nuget.org/packages/Cake.NuGet/)
1. Make sure that everything has pushed correctly to chocolatey
  * [cake.portable](https://chocolatey.org/packages/cake.portable) **NOTE:** This package might be subject to moderation, and might not appear immediately
1. Move to homebrew repository
1. Create a new branch for current release `git checkout -b cake-0.7.0`
1. Open the `Formula/cake.rb`
1. Update the url (line 4) to be the new download location
1. Update the sha256 (line 5) to be the value that was generated earlier by the `Publish-HomeBrew` task
1. Commit the changes to `cake.rb`  **NOTE:** Commit message should use the following format `cake 0.12.0`  **NOTE:** Make sure to use a lower case `C` as that is the [preferred formatting in the Homebrew repo](https://github.com/Homebrew/homebrew-core/pull/4857#issuecomment-247475453)
1. Push the new branch to your fork
1. Open a PR against the `master` branch of `Homebrew/homebrew-core`
1. Move to example repository
1. Open the `tools/packages.config` file
1. Update the Cake version number to be the same as the version that you have just released
1. Build everything (`./build.ps1`) to make sure it works.
1. Commit changes. Use message similar to `(build) Updated Cake tool to version 0.13.0`
1. Push branch
1. Move to resources repository
1. Open the `packages.config` file
1. Update the Cake version number to be the same as the version that you have just released
1. Commit changes. Use message similar to `(build) Updated Cake tool to version 0.13.0`
1. Push branch
1. Move to website repository
1. Create a branch for a new blog post `git checkout -b 0.7.0-Blog-Post develop`
1. Create Blog Post i.e. `.\input\blog\2017-03-07-cake-v0.18.0-released.md`
1. You can get contibutors using the console `secrets\Processes\FetchContributors`
  * dotnet restore
  * dotnet run "cake-build" "cake" "v0.17.0" "v0.18.0" "authors.text"
1. Bump the Cake Tool Version number in `tools\package.config` to the latest released version, i.e. the version you just released
1. Commit changes to `tools\package.config` file using message similar to `(build) Updated Cake tool to version 0.14.0`
1. Commit blog post using message similar to `v0.14.0 Blog Post`
1. Push branch and submit pull request
1. Make sure that the [AppVeyor](https://ci.appveyor.com/project/cakebuild/website) build succeeds successfully
1. Have someone else verify the contents
1. Merge the Pull Request
1. Go to [develop.cakebuild.net](https://develop.cakebuild.net) once you receive the Azure notification in Slack to say that the development site is deployed.  Make sure that it works as expected.
1. Switch to `develop` branch `git checkout develop`
1. Update local develop branch `git fetch` then `git rebase origin/develop`
1. Delete local branch that was created `git branch -d 0.7.0-Blog-Post`
1. Switch to `master` branch `git checkout master`
1. Merge `develop` to `master`  `git merge --no-ff develop` **NOTE:** This will also update the documentation for the various Addins/Tools on the site, so if any new aliases have been added, these will be included in the build.
1. Push `master` branch `git push`
1. Go to [cakebuild.net](https://cakebuild.net/) once you receive the Azure notification in Slack to say that the development site is deployed.  Make sure that it works as expected.
1. Go to the [On .Net Link submission form](https://weekindotnet.azurewebsites.net/) and add link to the post, also add to [reddit.com/r/dotnet](https://reddit.com/r/dotnet), [LinkedIn](https://www.linkedin.com/company-beta/17902391/) and [Medium](https://medium.com/@cakebuildnet).
1. Go and have a drink!