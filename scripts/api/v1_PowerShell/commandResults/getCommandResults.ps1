function Get-CommandResults ()
{
	<#
    .SYNOPSIS
    Returns up to 1000 command results.

	.DESCRIPTION
    Commands are run from the JumpCloud admin portal. NOTE that the output of the command is not displayed in the command results. To find this you must run Get-Commandresult which returns the output for a single command using the _id. Use Get-commandresults to find the _id of commands.

    .PARAMETER JCAPIKey
    To find your JumpCLoud API key log into the JumpCloud admin portal. The API key is located from the drop down icon in the top right corner of the screen next to your admin email under 'API Settings'.

	.EXAMPLE
	PS> Get-CommandResults | Sort-Object -property requestTime -Descending | select -last 5
    This example retrieves the last five commands run sorted by requestTime

    .EXAMPLE
	PS> Get-commandresults | Select _ID, Name
    This example retrieves the _ID and Name for up to 1000 command results

	.LINK
    https://docs.jumpcloud.com/1.0/command-results/list-all-command-results

    #>

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateLength(40,40)]
        [string]$JCAPIKEY
    )

    $hdrs = @{}
        $hdrs.Add("Content-Type","application/json")
        $hdrs.Add("Accept","application/json")
        $hdrs.Add("X-API-KEY", $JCAPIKEY)


    $URL = "https://console.jumpcloud.com/api/commandresults?limit=1000"

    $CommandResults = Invoke-RestMethod -Method GET -Uri $URL -Headers $hdrs

    Write-Output $CommandResults.results

}

