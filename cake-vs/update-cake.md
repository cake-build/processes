# Updating the Cake version used in Cake for Visual Studio

## Repository Pre-requisites

You'll need the following installed:

- Visual Studio 2017
- Visual Studio extension development workload
- Visual Studio Code

## Basic Approach

Since the extension itself never hooks into Cake, it doesn't actually use Cake. The Cake NuGet package is only used for the project templates, but is included as a `devDependency` to save having to check the package into Git. Since the templates all include a versioned reference (required for Visual Studio templates for some reason), it just becomes a matter of updating the version that is packaged, and then updating the version that the templates use when generating the project.

## Updating

### Updating the dependency entry

Cake is included as a `devDependency` of the main `Cake.VisualStudio` project so that NuGet downloads the package for us on build.

#### Update `packages.config`

1. Open `src/packages.config` and locate the entries for `Cake.Core` and `Cake.Testing`
1. Update the `version` attribute to the desired version

#### Update `Cake.VisualStudio.csproj`

Next time the project builds, this version will be downloaded, but the VSIX packaging will still attempt to use the old version. To fix this, open the `Cake.VisualStudio.csproj` file with an editor, and locate the `Content` nodes for `Cake.Core` and `Cake.Testing`. They should look like the following:

```xml
<Content Include="..\packages\cake.core.0.16.1\cake.core.0.16.1.nupkg">
    <IncludeInVSIX>true</IncludeInVSIX>
    <VSIXSubPath>Packages</VSIXSubPath>
    <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    <InProject>false</InProject>
</Content>
<Content Include="..\packages\Cake.Testing.0.16.1\cake.testing.0.16.1.nupkg">
    <IncludeInVSIX>true</IncludeInVSIX>
    <VSIXSubPath>Packages</VSIXSubPath>
    <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    <InProject>false</InProject>
</Content>
```

Simply change the *version* part of the `Include` attribute to the same version you added to `src/packages.config`.

#### Update `source.extension.vsixmanifest`

Now, NuGet will download the correct package and Visual Studio will include it in the built project output, but the VSIX won't include the updated packages. To fix this, open the `src/source.extension.vsixmanifest` file:

1. Locate the `/PackageManifest/Assets/Asset` node for `cake.core...` and `cake.testing...`
1. Update the version string in both the `Type` attribute and the `Path` attribute

Now the VSIX should include the package files when it's built.

### Updating the template references

Since there are so many templates and each includes a hard-coded version reference, the easiest way to do this is a global Find and Replace.

1. Open Visual Studio Code in the repo root
1. Search for the *current* Cake version string (i.e. `0.16.0`, or use regex and use `0\.16\.\d`)
1. You should see results from 4 files (as at 0.1.0): `AddinTemplate.vstemplate`, `AddinTestBasicTemplate.vstemplate`, `AddinTestTemplate.vstemplate` and `ModuleTemplate.vstemplate`
1. Replace, either manually or using Code's Replace function, all the references to the old version with the new one.

Finally, run `./build.ps1` to build a package and verify nothing is *totally* broken.

## Testing

First, make sure you have run `./build.ps1` and then use 7-zip to check that the Packages folder exists and contains the correct versions of `Cake.Core` and `Cake.Testing`.

To test the templates, you can dig around the VSIX and find the template files that are going to be installed, but it is much easier to simply open the solution, then Build and Debug to run the Visual Studio Experimental Instance. From there, try creating one of each kind of projects and verify that no errors are shown.
