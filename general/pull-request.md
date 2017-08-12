The following is a set of standard guidelines to follow when reviewing a Pull Request on GitHub:

* Has the Pull Request been done on a feature branch?
  * If not, suggest that the author re-create the PR on a feature branch
* Has an issue been created for the Pull Request
  * If not, suggest that the author create an issue and link through to the PR
* Is the PR trying to do too much within a single PR?  Is the scope of the PR limited to the single issue that was originally raised?
  * If not, suggest that the author reduce the amount of changes within the PR, and create a new issue and PR for the remaining work.
* Is the PR up to date with the latest in the target branch?
  * If not, point the author to the contributing document where they can get information about updating their branch to the latest
* Does the PR contain lots of commits?  Ideally, the PR would be a single commit, however, multiple logical commits are ok, i.e. a commit for the logic, and a commit for say the tests.
  *  If not, point the author at the contributing document again, and ask them to squash
* Do all the CI builds for the PR pass?
  * If not, I wouldn't spend too long looking into the problem, but rather pass what information you can back to the author and request that they get the builds working again.
* Does the code in the PR work?  i.e. pull the code locally and test it out.
  * If not, provide some details to the author and request changes
* Are there any breaking changes in the PR?  i.e. has a public facing method been changed, or properties names changed, etc.
  * If so, check to see whether this is definitely required, and if so, remember to label the issue associated with this PR with the `Breaking change` label.
* Once the PR is merged, make sure to close the associated issue.
  * Assign the issue to the correct upcoming milestone
  * Assign the issue with the correct label.  **NOTE:** only 1 label should be assigned to the issue