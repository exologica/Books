# Books
An example of some powershell best practices to get some records with a specific scope from an API.

This repository demonstrates how to organize a module and accomplish a few common tasks like public vs private functions, unit tests, and a simple Azure DevOps pipeline integration.

## Features
* Public function.
* Linter.
* Unit testing with the Pester framework and CodeCoverage.
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
Import-Module -Name Get-Books
```

## Example usage
***Note: This assumes you have cloned the repository to C:\Source. Update the path if this isn't correct.***
``` powershell
Get-Books `
                -remoteAPI 'https://fakerestapi.azurewebsites.net/api/Books' `
                -outputFileName 'output.csv' `
                -pageCountGreaterThanRangeIn '10000' `
                -pageCountLessThanRangeOut '15000'
```

# Expected output

![Get-books output example](https://user-images.githubusercontent.com/22803900/90779131-d9e71b80-e2d3-11ea-9236-03719bd4c6c8.PNG)

## Run the unit tests and export as JaCoco code coverage report
***Note: This assumes you have cloned the repository to C:\Source. Update the path if this isn't correct.***
``` powershell
cd 'C:\Source\Books\'
Invoke-Pester -Script .\Get-Books\Tests\Functions\Public\Get-Books.tests.ps1 -CodeCoverage .\Get-Books\Functions\Public\Get-Books.ps1 -CodeCoverageOutputFile 'Pester-Coverage.xml' -CodeCoverageOutputFileFormat JaCoCo
```
# Expected test output

![Get-books test output example](https://user-images.githubusercontent.com/22803900/90783570-a8238400-e2d6-11ea-8348-7d1c11b9e8c5.png)
