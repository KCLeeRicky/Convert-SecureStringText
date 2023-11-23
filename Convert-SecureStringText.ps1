function Convert-SecureStringText {
<#
    Objective: Convert between plaintext and SecureString text
#>    
    [cmdletbinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("to","from")]
        [string]$action,
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$MyInput
    )

    Try {
        If ($action -eq "to") {
            $result = $MyInput.Trim() | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString -ErrorAction SilentlyContinue
        }
        else {
            $result = [Net.NetworkCredential]::new('', (($MyInput.Trim()) |ConvertTo-SecureString)).password
        }
        return $result
    }
    catch {
            Write-Warning "Unable to convert.....`n`n$($_.Exception)"
    }
}