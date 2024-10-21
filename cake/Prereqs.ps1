[CmdletBinding(SupportsShouldProcess=$True)]
Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("patriksvensson", "devlead", "gep13", "agc93", "mholo65", "daveaglick", "pascalberger", "augustoproiete", "nils-a")]
    [string]$GithubUsername,
    [string]$RootName = "repositories"
)

###############################################################################

Function CleanDirectory
{
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param([string]$Path)
    # Clean the repositories path.
    if ($PSCmdlet.ShouldProcess($Path, "Clean")) {
        Write-Host "Cleaning $Path..." -f yellow
        if(Test-Path $Path) {
            Remove-Item -Recurse -Force $Path | Out-Null
        }
        New-Item -Path $Path -Type Directory | Out-Null
    }
}


Function Clone
{
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param(
        [string]$Organization,
        [string]$Repository,
        [string[]]$Branches)

    # Clone repository.
    if ($PSCmdlet.ShouldProcess("$Organization/$Repository", "Clone")) {
        Write-Host "Cloning https://github.com/$Organization/$Repository.git..." -f yellow
        &"git" "clone" "https://github.com/$Organization/$Repository.git"
        Push-Directory (Join-Path (Get-Location) $Repository)
        # Check out branches.
        foreach($Branch in $Branches) {
            Write-Host "    Checking out $Branch..." -f green
            &"git" "checkout" "$Branch"
        }
        Pop-Directory
    }
}

Function AddUpstreamAndRebase
{
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param(
        [string]$Organization,
        [string]$Repository,
        [string]$Owner,
        [string]$Branch)

    if ($PSCmdlet.ShouldProcess("$Organization/$Repository [upstream/$Branch]", "Rebasing against upstream")) {
        Write-Host "Adding remote and rebasing $Owner/$Repository..." -f yellow
        Push-Directory (Join-Path (Get-Location) $Repository)
        Write-Host "    Adding remote https://github.com/$Owner/$Repository.git..." -f green
        &"git" "remote" "add" "upstream" "https://github.com/$Owner/$Repository.git"
        Write-Host "    Checking out $Branch..." -f green
        &"git" "checkout" "$Branch"
        Write-Host "    Fetching upstream..." -f green
        &"git" "fetch" "upstream"
        Write-Host "    Rebasing against upstream/$Branch..." -f green
        &"git" "rebase" "upstream/$Branch"
        Pop-Directory
    }
}

Function Push-Directory
{
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param([string]$Path)

    if ($PSCmdlet.ShouldProcess("$Path", "Pushing directory")) {
        Push-Location
        Set-Location $Path
    }
}

Function Pop-Directory
{
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param()

    if ($PSCmdlet.ShouldProcess("Popping directory", "", "")) {
        Pop-Location
    }
}

###############################################################################

# Define paths.
$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepositoryRoot = Join-Path $PSScriptRoot $RootName
$CakePath = Join-Path $RepositoryRoot "cake-build"
$UserPath = Join-Path $RepositoryRoot "$GithubUsername"

# Make sure the environment variables have been set up.
if ($PSCmdlet.ShouldProcess("Verifying GitHub username", "", "")) {
    if([string]::IsNullOrWhiteSpace($env:CAKE_GITHUB_USERNAME)) {
        throw "The env variable CAKE_GITHUB_USERNAME has not been set"
    }
}
if ($PSCmdlet.ShouldProcess("Verifying GitHub password", "", "")) {
    if([string]::IsNullOrWhiteSpace($env:CAKE_GITHUB_PASSWORD)) {
        throw "The env variable CAKE_GITHUB_PASSWORD has not been set"
    }
}

# Make sure that the repositories path doesn't already exist.
if ($PSCmdlet.ShouldProcess("Making sure the root doesn't already exist", "", "")) {
    if(Test-Path $RepositoryRoot) {
        $Message = "The path '$RepositoryRoot' already exist."
        throw $Message
    }
}

# Clean the repository path.
CleanDirectory -Path $RepositoryRoot
Push-Directory -Path $RepositoryRoot

# Clone Cake stuff
CleanDirectory -Path $CakePath
Push-Directory -Path $CakePath
Clone -Organization "cake-build" -Repository "cake" -Branches @("main", "develop")
Clone -Organization "cake-build" -Repository "website" -Branches @("master", "develop")
Clone -Organization "cake-build" -Repository "example" -Branches @("master")
Clone -Organization "cake-build" -Repository "resources" -Branches @("master", "develop")
Pop-Directory

# Go back to where we started.
Pop-Directory

# Output some information.
Write-Host ""
Write-Host "-----------------------------------------------"
Write-Host "All repositories have been cloned to"
Write-Host $RepositoryRoot -f Yellow
Write-Host "-----------------------------------------------"
Write-Host ""
