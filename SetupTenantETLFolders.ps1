Import-Module SQLPS -DisableNameChecking


$templateFolderLocation = "E:\ETLContainer\TenantID\*";
$destinationFolderRoot = "E:\ETLContainer";

$Results = Invoke-SQLCmd  -Serverinstance localhost -database Analytics -query "SELECT DISTINCT TenantID FROM Tenant";

Foreach($result in $results) {
    
    $destinationFolder = $destinationFolderRoot + "\" + $result.TenantID;

    Copy-Item $templateFolderLocation $destinationFolder -recurse -ErrorAction SilentlyContinue 
}