# Books
An example of some best powershell best practices to get some records with a specific scope from an API.

This repository demonstrates how to organize a module and accomplish a few common tasks like public vs private functions, unit tests, and a simple Azure DevOps pipeline integration.

## Features
* Public function.
* Linter.
* Unit testing with the Pester framework.
* Simple Azure DevOps Pipeline integration.

## Setup
1. Clone the repository.
2. Open PowerShell (as an administrator).
3. Install the [Pester](https://github.com/pester/Pester) framework:
``` powershell
Install-Module -Name Pester -MinimumVersion 4.10.1 -Scope AllUsers -Force -SkipPublisherCheck
```
4. Add this Get-Books module to the PSModule path.
***Note: This assumes you have cloned the repository to C:\Source. Update the path if this isn't correct.***
``` powershell
$repoDirectory = 'C:\Source\Books'
$existingPaths = $ENV:PSModulePath
$newPaths = "$repoDirectory;$existingPaths"
$scope = [System.EnvironmentVariableTarget]::Machine
[System.Environment]::SetEnvironmentVariable('PSModulePath',$newPaths,$scope)
```

## Load the module
``` powershell
Import-Module -Name .\Get-Books\Get-Books
```

## Run the unit tests
***Note: This assumes you have cloned the repository to C:\Source. Update the path if this isn't correct.***
``` powershell
cd 'C:\Source\Books\'
Invoke-Pester
```