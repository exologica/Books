Import-Module Get-Books

BeforeAll {
    $fakeAPI = "https://nonexist"
    $testFile = "$($TestDrive)\TestData.csv"
    $rangeIn = "10000"
    $rangeOut = "12000"
}

Describe 'Get-Books' {
    It 'Not should work with an non existing API' {
            { Get-Books `
                    -remoteAPI $fakeAPI `
                    -outputFileName $testFile `
                    -pageCountGreaterThanRangeIn $rangeIn `
                    -pageCountLessThanRangeOut $rangeOut `
                    -ErrorAction Stop } `
        | Should -Throw "Can't reach API $fakeAPI or not found."
    }
}