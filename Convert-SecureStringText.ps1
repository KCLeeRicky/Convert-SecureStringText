function Convert-SecureStringText {
    <#
        Objective: Convert between plaintext and SecureString text
    
        Version:
        1.0 - 2023-22-24 ricky.kc.lee@my.cityu.edu.hk
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