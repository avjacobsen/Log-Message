function Log-Message {
    # Source: https://github.com/avjacobsen/Log-Message
    [CmdletBinding()]
        param (
            [Parameter(Mandatory=$true, ValueFromPipeline)]
            [String]
            $Message,
            [Parameter(Mandatory=$false)]
            [String]
            $MessageType = "INFO",
            [Parameter(Mandatory=$false)]
            [String]
            $Path = ""
        )
        Write-Debug "`$Path Type: $($Path.GetType())"
        Write-Debug "`$PSCommandPath Type: $($PSCommandPath.GetType())"
        if ($Path -eq "" -and $PSCommandPath -ne "") {
            Write-Debug "No path supplied but running from script. Setting path to script name."
            $Path = "$(Get-Date -Format "yyyy")$(Get-Date -Format "MM")$(Get-Date -Format "dd")_$((Get-ChildItem $PSCommandPath).BaseName).log"
            Write-Debug "`$Path: $Path"
        }
        if ($Path -eq "" -and $PSCommandPath -eq "") {
            Write-Debug "No path supplied and not running from script. Logging to file skipped."
        }
        $MessagePrefix = "$(Get-Date -Format "yyyy").$(Get-Date -Format "MM").$(Get-Date -Format "dd") $(Get-Date -Format "HH"):$(Get-Date -Format "mm"):$(Get-Date -Format "ss") "
        if ($Path -ne "") {
            Add-Content -Path $Path -Value "$($MessagePrefix)[$($MessageType)] $($Message)"
        }
        if ($VerbosePreference) {
            "$($MessagePrefix)[$($MessageType)] $($Message)"
        }
    }
    
