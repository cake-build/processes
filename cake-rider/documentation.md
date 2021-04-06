## General information

- official documentation for the released version is at https://cakebuild.net/docs/integrations/editors/rider/
- changes to the plugin are documented in-place in the `docs` folder of *Cake for Rider*

## Preparation for a release

Before doing a release (see [release.md](./release.md)) the current state of the documentation should be
copied to `cake-build/website`. The folder-structure in `docs/input` is the same as in the `input` folder of 
`cake-build/website` so it's content can simply be copied to the `input` folder of `cake-build/website`.

With those changes in place, create a PR into `cake-build/website` but do not merge before the new version
has been approved by JetBrains.
