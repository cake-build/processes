---
name: New Frosting Release
about: Steps to be taken when doing a new Frosting Release
title: Frosting x.x.x Release
labels: ''
assignees: ''
---

## Useful information

* [AppVeyor builds](https://ci.appveyor.com/project/cakebuild/frosting)

## GitHub Issues Pre-requisites

- [ ] Make sure all issues within the milestone are tagged with either Bug, Feature, Improvement, Documentation, Breaking change, or Build
- [ ] Make sure all issues associated with the milestone are closed
- [ ] Make sure that all issues only have 1 label associated with them

## When doing a release

- [ ] Create branch locally to match the name of the release, for example `git checkout -b release/0.35.0 develop`
- [ ] Create release notes on GitHub using the `ReleaseNotes` task (`.\build.ps1 --target=CreateReleaseNotes`)
- [ ] Build everything (`./build.ps1`) to make sure it works.
- [ ] At this point, if you want to share the work to date, and validate something, push the local release branch to GitHub
- [ ] Assuming everything is ok, switch to `master` branch (`git checkout master`)
- [ ] Merge release branch to the `master` `git merge --no-ff release/0.35.0`
- [ ] Build everything (`./build.ps1`) to make sure it works (we can never be too sure).
- [ ] Push `master` branch.
- [ ] Make sure that the [AppVeyor](https://ci.appveyor.com/project/cakebuild/frosting) build succeeds before going any further.
- [ ] Assuming that everything went ok, go to the draft release in GitHub and click Edit
- [ ] Click the Publish Release button
- [ ] This will trigger another build in AppVeyor, but this time with a tag.
- [ ] Switch to `develop` branch `git checkout develop`
- [ ] Merge release branch into develop `git merge --no-ff release/0.35.0`
- [ ] Resolve any merge conflicts
- [ ] Build everything (`./build.ps1`) to make sure it works.
- [ ] Push `develop` branch.
- [ ] Delete the local release branch that was created `git branch -d release/0.35.0` (and the remote one, if pushed to GitHub `git push origin --delete release/0.35.0`)

## After a release/hotfix

- [ ] Make sure that everything has pushed correctly to nuget
    * [Cake.Frosting](https://www.nuget.org/packages/Cake.Frosting/)
    * [Cake.Frosting.Template](https://www.nuget.org/packages/Cake.Frosting.Template/)
- [ ] Go and have a drink!
