function gb {
    [CmdletBinding()] 
    param(
    # Name you wish to use
    [Parameter(Mandatory=$true)][string]$name,
    # Name you wish to use
    [Parameter()][switch]$p,
    # Use if it should generate 
    [Parameter()][switch]$NoCss 

)


# Setup parameters
$curDir = Get-Location
$folder = Split-Path $curDir -Leaf
$parrent = Split-Path (Split-Path $curDir -Parent) -Leaf
$namespace = $parrent+"."+$folder

$razor = @"
@namespace $namespace
<h3>$name</h3>
"@

if ($p) {$razor = @"
@page "/$name"
@namespace $namespace
<h3>$name</h3>
"@ }
    

$cs = @"
using Microsoft.AspNetCore.Components;

namespace $($namespace);

public partial class $($name) : ComponentBase
{
    
}
"@

#Create files
New-Item $name".razor"
New-Item $name".razor.cs"

if (-Not $NoCss) {
    New-Item $name".razor.css"
}


#Add content to files
Set-Content $name".razor" $razor
Set-Content $name".razor.cs" $cs
    
}



