---
name: New Cake Release
about: Steps to be taken when doing a new Cake Release
title: Cake x.x.x Release
labels: ''
assignees: ''
---

## Useful information

* [AppVeyor builds](https://ci.appveyor.com/project/cakebuild/cake)
* [Travis builds](https://travis-ci.org/cake-build/cake)
* [Bitrise](https://bitrise.io)
* [Azure Pipelines](https://dev.azure.com/cake-build/Cake/_build)

## Repository Pre-requisites


### Automated Approach
- [ ] Make sure you have a fork of `Homebrew/homebrew-core`.
- [ ] Run the `Prereqs.ps1` file, using the following as an example `.\Prereqs.ps1 -GithubUsername gep13` (use your own username). This will clone a new version of all required repositories.

## Let people know that things are happening...

- [ ] Go to the Gitter room for Cake and inform people that a release is away to happen.  Use a message similar to the following `@/all We will soon start preparing for the [0.35.0 release](https://github.com/cake-build/cake/milestone/60?closed=1) of Cake. So this is a friendly reminder to pin your Cake version.`
- [ ] Go to the Gitter room for Cake-Contrib and inform people that a release is away to happen.  Use a message similar to the following `@/all We will soon start preparing for the [0.35.0 release](https://github.com/cake-build/cake/milestone/60?closed=1) of Cake. So this is a friendly reminder to pin your Cake version.`
- [ ] Go to the General Channel in the Slack Team for Cake-Contrib and inform peoploe that a release is away to happen.  Use a message similar to the following `@channel We will soon start preparing for the 0.35.0 release ( https://github.com/cake-build/cake/milestone/60?closed=1 ) of Cake. So this is a friendly reminder to pin your Cake version.`
- [ ] Using the Cake Twitter account, tweet to let people know that the release is away to happen.  Use something like the following `We are starting to prepare our next release, 0.35.0 (https://github.com/cake-build/cake/milestone/60?closed=1).  This is your friendly reminder that if you haven't pinned to a specific version of Cake, you should do it now :-) https://cakebuild.net/docs/tutorials/pinning-cake-version`
- [ ] Retweet the above from the cake-contrib twitter account

## GitHub Issues Pre-requisites

- [ ] Make sure all issues within the milestone are tagged with either Bug, Feature, Improvement, Documentation, Breaking change, or Build
- [ ] Make sure all issues associated with the milestone are closed
- [ ] Make sure that all issues only have 1 label associated with them

## When doing a release

- [ ] Create branch locally to match the name of the release, for example `git checkout -b release/0.35.0 develop`
- [ ] Update `releasenotes.md` to include next version number as a placeholder and save the file
- [ ] Create release notes on GitHub using the `ReleaseNotes` task (`.\build.ps1 --target=ReleaseNotes`)
- [ ] Update `releasenotes.md` with generated content (making sure to keep the formatting the same)
- [ ] Build everything (`./build.ps1`) to make sure it works.
- [ ] Commit the changes to `releasenotes.md` and `solutioninfo.cs`. Use comment like `(build) Updated version and release notes.`
- [ ] At this point, if you want to share the work to date, and validate something, push the local release branch to GitHub
- [ ] Assuming everything is ok, switch to `main` branch (`git checkout main`)
- [ ] Merge release branch to the `main` `git merge --no-ff release/0.35.0`
- [ ] Build everything (`./build.ps1`) to make sure it works (we can never be too sure).
- [ ] Push `main` branch.
- [ ] Make sure that both the [AppVeyor](https://ci.appveyor.com/project/cakebuild/cake), [Bitrise Ubuntu](https://www.bitrise.io/app/b811c91a26b1ea80#/builds) and [Bitrise OSX](https://www.bitrise.io/app/7a9d707b00881436#/builds) builds succeed before going any further.
- [ ] Assuming that everything went ok, go to the draft release in GitHub and click Edit
- [ ] Click the Publish Release button
- [ ] This will trigger another build in AppVeyor, but this time with a tag.
- [ ] From the AppVeyor Log, take a note of the generated Hash from the `Publish-HomeBrew` task `ENTERARCHIVEHASH`
- [ ] Switch to `develop` branch `git checkout develop`
- [ ] Merge release branch into develop `git merge --no-ff release/0.35.0`
- [ ] Resolve any merge conflicts
- [ ] Bump the Cake Tool Version number in `build.config` to the latest released version, i.e. the version you just released
- [ ] Build everything (`./build.ps1`) to make sure it works.
- [ ] Commit the changes to `build.ps1` and `build.sh`  **NOTE:** There will be other changes to the *.json files as well, commit everything. Use commit message like `(build) Updated Cake tool to version 0.35.0`
- [ ] Push `develop` branch.
- [ ] Delete the local release branch that was created `git branch -d release/0.35.0` (and the remote one, if pushed to GitHub `git push origin --delete release/0.35.0`)

## After a release/hotfix

- [ ] Make sure that everything has pushed correctly to nuget
    * [Cake](https://www.nuget.org/packages/Cake/)
    * [Cake.Core](https://www.nuget.org/packages/Cake.Core/)
    * [Cake.CoreCLR](https://www.nuget.org/packages/Cake.CoreCLR/)
    * [Cake.Common](https://www.nuget.org/packages/Cake.Common/)
    * [Cake.Testing](https://www.nuget.org/packages/Cake.Testing/)
    * [Cake.NuGet](https://www.nuget.org/packages/Cake.NuGet/)
    * [Cake.Tool](https://www.nuget.org/packages/Cake.Tool/)
- [ ] Make sure that everything has pushed correctly to chocolatey
    * [cake.portable](https://chocolatey.org/packages/cake.portable) **NOTE:** This package might be subject to moderation, and might not appear immediately
- [ ] Move to homebrew repository
- [ ] Create a new branch for current release `git checkout -b cake-0.35.0`
- [ ] Open the `Formula/cake.rb`
- [ ] Update the url (line 4) to be the new download location
- [ ] Update the sha256 (line 5) to be the value that was generated earlier by the `Publish-HomeBrew` task
- [ ] Commit the changes to `cake.rb`  **NOTE:** Commit message should use the following format `cake 0.35.0`  **NOTE:** Make sure to use a lower case `C` as that is the [preferred formatting in the Homebrew repo](https://github.com/Homebrew/homebrew-core/pull/4857#issuecomment-247475453)
- [ ] Push the new branch to your fork
- [ ] Open a PR against the `master` branch of `Homebrew/homebrew-core`
- [ ] Move to example repository
- [ ] Open the `tools/packages.config` file
- [ ] Update the Cake version number to be the same as the version that you have just released
- [ ] Build everything (`./build.ps1` or `./build.sh`) to make sure it works.
- [ ] Commit changes. Use message similar to `(build) Updated Cake tool to version 0.35.0`
- [ ] Push branch
- [ ] Move to resources repository
- [ ] Switch to the develop branch `git checkout develop`
- [ ] Open the `packages.config` file
- [ ] Update the Cake version number to be the same as the version that you have just released
- [ ] Commit changes. Use message similar to `(build) Updated Cake tool to version 0.35.0`
- [ ] Push branch `git push`
- [ ] Checkout master `git checkout master`
- [ ] Merge changes from develop branch `git merge --no-ff develop`
- [ ] Push branch `git push`
- [ ] Trigger new container builds on [Azure Pipelines](https://dev.azure.com/cake-build/Cake/_build?definitionId=9).
- [ ] Move to website repository
- [ ] Create a branch for a new blog post `git checkout -b 0.35.0-Blog-Post master`
- [ ] You can get draft blog post using the console `secrets\Processes\FetchContributors`
    * dotnet restore
    * dotnet run "cake-build" "cake" "v0.34.1" "d4a0b3a07caa6a3873cb0da58766ffdb7ce22e11" "\cake0.35.0\repositories\devlead\website\input\blog" "v0.35.0"
- [ ] Bump the Cake Tool Version number in `tools\package.config` to the latest released version, i.e. the version you just released
- [ ] Commit changes to `tools\package.config` file using message similar to `(build) Updated Cake tool to version 0.35.0`
- [ ] Commit blog post using message similar to `v0.35.0 Blog Post`
- [ ] Push branch and submit pull request
- [ ] Have someone else verify the contents
- [ ] Merge the Pull Request
- [ ] Go to [develop.cakebuild.net](https://develop.cakebuild.net) once you receive the Azure notification in Slack to say that the development site is deployed.  Make sure that it works as expected.
- [ ] Go to [cakebuild.net](https://cakebuild.net/) once you receive the Azure notification in Slack to say that the development site is deployed.  Make sure that it works as expected.
- [ ] Go to the Cake-Contrib Gitter Room and let people know that it was released.  Use something like `@/all Version 0.35.0 of the Cake has just been released, https://www.nuget.org/packages/Cake.`
- [ ] Go to the Cake-Contrib Slack Team and in the General Room let people know that it was released.  Use something like `@channel Version 0.35.0 of the Cake has just been released, https://www.nuget.org/packages/Cake.`
- [ ] Go to the [On .Net Link submission form](https://weekindotnet.azurewebsites.net/) and add link to the post
- [ ] Go to reddit and submit link [reddit.com/r/dotnet](https://reddit.com/r/dotnet), 
  - [ENTER URL HERE]
- [ ] Go to [LinkedIn](https://www.linkedin.com/company/17902391/) and create a new post
  - [ ] Start a post
  - [ENTER URL HERE]
- [ ] Go to [Medium](https://medium.com/@cakebuildnet)
  - [ ] Log into Medium as the cake-build twitter user
  - [ ] Click on the Cake logo at top right of screen, then click on Stories
  - [ ] Click on Import a Store
  - [ ]  Enter url of blog post and click Import (if this errors out, just try it again)
  - [ ] ~~ Import failed this time so used medium [Create post API](https://github.com/Medium/medium-api-docs/blob/master/README.md#creating-a-post) to create draft with canonicalUrl ~~
  - [ ] Click on see your story
  - [ ] Remove the first line of the imported story
  - [ ] Click Publish and enter the tags`DevOps` `Csharp` `Release Notes` `Dotnet` `Continuous Integration`
  - [ ] Click Publish
  - [ENTER URL HERE]
- [ ] .NET Foundation Newsletter
  - [ ] Create PR to latest unpublished news letter at [github.com/dotnet-foundation/newsletter](https://github.com/dotnet-foundation/newsletter)
  - https://github.com/dotnet-foundation/newsletter/pull/
- [ ] Go to the Cake Slack Channel and share the links to Medium, LinkedIn and reddit so that other team members can share them
- [ ] Go and have a drink!
