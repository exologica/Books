function Get-Books
{
    <#
    .SYNOPSIS
        Get books from an external API with an exact criteria.

    .DESCRIPTION
        The Get-Books function get a response from an external API REST endpoint and filter it by a determinated scope.

    .PARAMETER remoteAPI
        This is the URI of the external API REST endpoint.

    .PARAMETER outputFileName
        This is the output CSV filename and it will be created in the execution directory.

    .PARAMETER pageCountGreaterThanRangeIn
        This is the countPage range In number.

    .PARAMETER pageCountLessThanRangeOut
        This is the countPage range Out number.

    .EXAMPLE
        PS C:\> Get-Books `
                -remoteAPI 'https://fakerestapi.azurewebsites.net/api/Books' `
                -outputFileName 'output.csv' `
                -pageCountGreaterThanRangeIn '10000' `
                -pageCountLessThanRangeOut '15000' 
        
        Invoke Get-Books.
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [System.String]
        $remoteAPI,
        [Parameter(Mandatory=$true)]
        [System.String]
        $outputFileName,
        [Parameter(Mandatory=$true)]
        [System.Int32]
        $pageCountGreaterThanRangeIn,
        [Parameter(Mandatory=$true)]
        [System.Int32]
        $pageCountLessThanRangeOut
    )
    Process
    {
        try {
        (Invoke-RestMethod -method GET -uri $remoteAPI) `
        | Where-Object { ($_.PageCount -Gt $pageCountGreaterThanRangeIn -and $_.PageCount -Lt $pageCountLessThanRangeOut) } `
        | Select-Object ID, title, pagecount `
        | ConvertTo-Csv -NoTypeInformation `
        | Set-Content $outputFileName
        Write-Host 'Successful exported:'$outputFileName -ForegroundColor green
    }
    catch {
        # Write-Verbose "Something is wrong!"
        # Write-Debug "$($_.Exception)"
        # Write-Host "Error: [$($_.Exception.Message)"] -ForegroundColor red
        Write-Error "Can't reach API $remoteAPI or not found."
        }
    }
}