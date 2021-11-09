function Write-LogMessage {
    # Source: https://github.com/avjacobsen/Write-LogMessage
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline)]
        [String]
        $Message,
        [Parameter(Mandatory = $false)]
        [String]
        $MessageType = "INFO",
        [Parameter(Mandatory = $false)]
        [String]
        $Path = ""
    )
    if ($Path -eq "" -and $PSCommandPath -ne "") {
        # No path supplied but running from script. Setting path to script name.
        $Path = "$(Get-Date -Format "yyyy")$(Get-Date -Format "MM")$(Get-Date -Format "dd")_$((Get-Item $PSCommandPath).BaseName).log"
    }
    $MessagePrefix = "$(Get-Date -Format "yyyy").$(Get-Date -Format "MM").$(Get-Date -Format "dd") $(Get-Date -Format "HH"):$(Get-Date -Format "mm"):$(Get-Date -Format "ss") "
    if ($Path -ne "") {
        Add-Content -Path $Path -Value "$($MessagePrefix)[$($MessageType)] $($Message)"
    }
    if ($VerbosePreference) {
        Write-Verbose "$($MessagePrefix)[$($MessageType)] $($Message)"
    }
    if ($DebugPreference) {
        Write-Debug "$($MessagePrefix)[$($MessageType)] $($Message)"
    }
}
