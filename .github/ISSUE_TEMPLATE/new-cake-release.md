---
name: New Cake Release
about: Steps to be taken when doing a new Cake Release
title: Cake x.x.x Release
labels: ''
assignees: ''
---

## Useful information

* [AppVeyor builds](https://ci.appveyor.com/project/cakebuild/cake)
* [GitHub Actions](https://github.com/cake-build/cake/actions)
* [Bitrise MacOS](https://app.bitrise.io/app/42eaef77e8db4a5c) / [Bitrise Debian](https://app.bitrise.io/app/ea0c6b3c61eb1e79)
* [Azure Pipelines](https://dev.azure.com/cake-build/Cake/_build)

## Repository Pre-requisites

### Automated Approach
- [ ] Run the [`Prereqs.ps1`](https://github.com/cake-build/processes/blob/master/cake/Prereqs.ps1) file, using the following as an example `.\Prereqs.ps1 -GithubUsername devlead` (use your own username). This will clone a new version of all required repositories.

## Let people know that things are happening...

- [ ] Please go to the General Channel in the Slack Team for Cake-Contrib and let people know that a release is away. Use a message similar to the following `@channel We will soon start preparing for the [x.x.x release](https://github.com/cake-build/cake/milestone/xx?closed=1) of Cake. So this is a friendly reminder to pin your Cake version! :pushpin: :cake:`
- [ ] Using the Cake Twitter account, tweet to let people know that the release is away to happen. Use something like the following `We are starting to prepare our next release, x.x.x (https://github.com/cake-build/cake/milestone/xx?closed=1).  This is your friendly reminder that if you haven't pinned to a specific version of Cake, you should do it now :-) 📌 🍰 https://cakebuild.net/docs/writing-builds/reproducible-builds/`
- [ ] Retweet the above from the cake-contrib Twitter account

## GitHub Issues Pre-requisites

- [ ] Make sure all issues within the milestone are tagged with either Bug, Feature, Improvement, Documentation, Breaking change, or Build
- [ ] Make sure all issues associated with the milestone are closed
- [ ] Make sure that all issues only have 1 label associated with them
- [ ] Raise an issue in the Cake.AddinDiscoverer repo **if there are any breaking changes** so the discoverer can be modified to generate a new markdown report and also an Excel report to track which addins are compatible with this new release of Cake.

## When doing a release

- [ ] Create a branch locally to match the name of the release, for example, `git checkout -b release/x.x.x develop`
- [ ] Update `ReleaseNotes.md` to include the next version number as a placeholder and save the file
- [ ] Create release notes on GitHub using the `ReleaseNotes` task (`.\build.ps1 --target=ReleaseNotes`)
- [ ] Update `ReleaseNotes.md` with generated content (making sure to keep the formatting the same)
- [ ] Build everything (`./build.ps1`) to make sure it works.
- [ ] Commit the changes to `ReleaseNotes.md` and `SolutionInfo.cs`. Use comment like `(build) Updated version and release notes`
- [ ] At this point, if you want to share the work to date, and validate something, push the local release branch to GitHub
- [ ] Assuming everything is ok, switch to `main` branch (`git checkout main`)
- [ ] Merge release branch to the `main` `git merge --no-ff release/x.x.x`
- [ ] Build everything (`./build.ps1`) to make sure it works (we can never be too sure).
- [ ] Push `main` branch.
- [ ] Make sure that all builds succeed before going any further.
    - [ ] [AppVeyor](https://ci.appveyor.com/project/cakebuild/cake)
    - [ ] [Bitrise Ubuntu](https://app.bitrise.io/app/ea0c6b3c61eb1e79#/builds)
    - [ ] [Bitrise OSX](https://app.bitrise.io/app/42eaef77e8db4a5c#/builds)
- [ ] Assuming that everything went ok, go to the draft release in GitHub and click Edit
- [ ] Click the Publish Release button
- [ ] This will trigger another build in AppVeyor, but this time with a tag.
- [ ] Switch to `develop` branch `git checkout develop`
- [ ] Merge release branch into develop `git merge --no-ff release/x.x.x`
- [ ] Resolve any merge conflicts
- [ ] Bump the Cake Tool Version number in `.config\dotnet-tools.json` to the latest released version, i.e. the version you just released
- [ ] Build everything (`./build.ps1`) to make sure it works.
- [ ] Commit the changes to `.config\dotnet-tools.json`. Use commit message like `(build) Updated Cake Tool to version x.x.x`
- [ ] Push `develop` branch.
- [ ] Delete the local release branch that was created `git branch -d release/x.x.x` (and the remote one, if pushed to GitHub `git push origin --delete release/x.x.x`)

## After a release/hotfix

- [ ] Make sure that everything has been pushed correctly to NuGet
  - `N/A` [Cake](https://www.nuget.org/packages/Cake/) (_deprecated with v2.0.0_)
  - [ ] [Cake.Tool](https://www.nuget.org/packages/Cake.Tool/)
  - [ ] [Cake.Frosting](https://www.nuget.org/packages/Cake.Frosting/)
  - `N/A` [Cake.CoreCLR](https://www.nuget.org/packages/Cake.CoreCLR/) (_deprecated with v2.0.0_)
  - [ ] [Cake.Core](https://www.nuget.org/packages/Cake.Core/)
  - [ ] [Cake.Common](https://www.nuget.org/packages/Cake.Common/)
  - [ ] [Cake.NuGet](https://www.nuget.org/packages/Cake.NuGet/)
  - [ ] [Cake.Cli](https://www.nuget.org/packages/Cake.Cli/)
  - [ ] [Cake.DotNetTool.Module](https://www.nuget.org/packages/Cake.DotNetTool.Module/)
  - [ ] [Cake.Testing](https://www.nuget.org/packages/Cake.Testing/)
  - [ ] [Cake.Testing.Xunit](https://www.nuget.org/packages/Cake.Testing.Xunit/)
- [ ] Move to [example](https://github.com/cake-build/example) repository
  - [ ] Bump the Cake Tool Version number in `.config\dotnet-tools.json` to the latest released version, i.e. the version you just released
  - [ ] Build everything (`./build.ps1` or `./build.sh`) to make sure it works.
  - [ ] Commit changes. Use message similar to `(build) Updated Cake tool to version x.x.x`
  - [ ] Push branch
- [ ] Move to [resources](https://github.com/cake-build/resources) repository
  - [ ] Open the `dotnet-tool/.config/dotnet-tools.json` file
  - [ ] Update the Cake version number to be the same as the version that you have just released
  - [ ] Commit changes. Use message similar to `(build) Updated Cake tool to version x.x.x`
  - [ ] Push branch `git push`
- [ ] Trigger new container builds on [GitHub Actions](https://github.com/cake-build/docker/actions).
- [ ] Move to [bakery](https://github.com/cake-build/bakery) repository
  - [ ] Create an issue `Update Cake to version x.x.x`
  - [ ] Create a branch for example `git checkout -b feature/gh-xxx develop`
  - [ ] Update Cake.Core to x.x.x in src\Cake.Bakery\Cake.Bakery.csproj
  - [ ] Update Cake.Core to x.x.x in src\Cake.Scripting\Cake.Scripting.csproj
  - [ ] Update Cake.Core to x.x.x in src\Cake.Scripting.Tests\Cake.Scripting.Tests.csproj
  - [ ] Update Cake.NuGet to x.x.x in src\Cake.Bakery\Cake.Bakery.csproj
  - [ ] Update Cake.Common to x.x.x in src\Cake.Scripting\Cake.Scripting.csproj
  - [ ] Update Cake.Testing to x.x.x in src\Cake.Scripting.Tests\Cake.Scripting.Tests.csproj
  - [ ] Build everything (`./build.ps1` or `./build.sh`) to make sure it works.
  - [ ] Commit changes. Use message similar to `(GH-xxx) Updated Cake tool to version x.x.x`
  - [ ] Push the branch and submit a pull request
  - [ ] Have someone else verify the contents
- [ ] Move to [website](https://github.com/cake-build/website) repository
  - [ ] Create a branch for a new blog post `git checkout -b x.x.x-Blog-Post master`
  - [ ] You can get a draft blog post using the console `secrets\Processes\FetchContributors`
    - dotnet restore
    - `dotnet run -- "cake-build" "cake" "v2.1.0" "8861b463a4eb651f9e5149ee7f7ada47d03ae1ad" "../../../../cake-build/website/input/blog/" vx.x.x`
  - [ ] Bump the Cake Tool Version number in `.config\dotnet-tools.json` to the latest released version, i.e. the version you just released
  - [ ] Commit changes to `.config\dotnet-tools.json` file using message similar to `(build) Updated Cake tool to version x.x.x`
- [ ] Commit blog post using a message similar to `vx.x.x Blog Post`
- [ ] Push the branch and submit a pull request
- [ ] Have someone else verify the contents
- [ ] Merge the Pull Request
- [ ] Go to [develop.cakebuild.net](https://develop.cakebuild.net) once you receive the Azure notification in Slack to say that the development site is deployed.  Make sure that it works as expected.
- [ ] Go to [cakebuild.net](https://cakebuild.net) once you receive the Azure notification in Slack to say that the development site is deployed.  Make sure that it works as expected.
- [ ] Go to the [Cake-Contrib Slack Team](https://cake-contrib.slack.com) and in the General Room let people know that it was released.  Use something like `@channel Version x.x.x of the Cake has just been released, https://www.nuget.org/packages/Cake.Tool :cake: :rocket: `
- [ ] Go to reddit and submit link [reddit.com/r/cakebuild](https://www.reddit.com/r/cakebuild),
  - [ ] reddit/cakebuild - https://www.reddit.com/r/cakebuild/...
  - [ ] cross-post to reddit/dotnet - https://www.reddit.com/r/dotnet/...
  - [ ] cross-post to reddit/csharp - https://www.reddit.com/r/csharp/...
  - [ ] post to reddit/devops - https://www.reddit.com/r/devops/...
- [ ] Go to [LinkedIn](https://www.linkedin.com/company/17902391/) and create a new post
  - https://www.linkedin.com/...
- [ ] Go to [Medium](https://medium.com/@cakebuildnet)
  - [ ] Log into Medium as the cake-build twitter user
  - [ ] Click on the Cake logo at top right of screen, then click on Stories
  - [ ] Click on Import a Story
  - [ ] Enter url of blog post and click Import (if this errors out, just try it again)
  - [ ] Click on see your story
  - [ ] Click Publish and enter the tags`DevOps` `Csharp` `Release Notes` `Dotnet` `Continuous Integration`
  - [ ] Click on `Publish Now`
  - https://cakebuildnet.medium.com/...
- [ ] .NET Foundation Newsletter
- [ ] Submit news to form [forms.office.com/r/8hAv7S659s](https://forms.office.com/r/8hAv7S659s)
- [ ] Submit a request for [content amplification](https://github.com/dotnet-foundation/content) by the .NET Foundation
  - [ ] https://github.com/dotnet-foundation/content/issues/...
- [ ] Go to the Cake Slack Channel and share the links to Medium, LinkedIn, and Reddit so that other team members can share them
- [ ] Go and have a drink!
