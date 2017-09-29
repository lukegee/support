function Get-CommandResult ()
{
    <#
git
    .SYNOPSIS
    Returns a specific command result.
    .DESCRIPTION
    The JSON data returned from this command stores the command output nested within the response - data - output field.
    To find the  _id of a command run the Get-CommandResults cmdlet. Note RESULT (single) vs RESULTS (mulitple).
    .PARAMETER JCAPIKey
    To find your JumpCLoud API key log into the JumpCloud admin portal. The API key is located from the drop down icon in the top right corner of the screen next to your admin email under 'API Settings'.
    .PARAMETER _id
    The command ID can be found by running thethe Get-CommandResults cmdlet. Note RESULT (single) vs RESULTS (mulitple).
    .EXAMPLE
        PS> Get-commandresult | select -expandproperty response | select -expandproperty data | select -expandproperty output
        This example retrieves the output of a Jumpcloud command
    .EXAMPLE
        PS> Get-commandresult | ConvertTo-Json
        This example shows the all the data in JSON format returned from the cmdlet

    .LINK
    https://docs.jumpcloud.com/1.0/command-results/list-an-individual-command

        #>
    [CmdletBinding()]
        param
        (
        [Parameter(Mandatory)]
        [ValidateLength(40,40)]
        [string]$JCAPIKEY,

        [Parameter(Mandatory,ValueFromPipeline)]
        [string]$_id
    )

    $hdrs = @{}
        $hdrs.Add("Content-Type","application/json")
        $hdrs.Add("Accept","application/json")
        $hdrs.Add("X-API-KEY", $JCAPIKEY)

    $URL = "https://console.jumpcloud.com/api/commandresults/$_id"

    $CommandResults = Invoke-RestMethod -Method Get -Uri $URL -Headers $hdrs

    Write-Output $CommandResults

}