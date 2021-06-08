$folderReference = 'C:\Users\Bill\Desktop\Folder1'
$folderToSync = 'C:\Users\Bill\Desktop\Folder2'

$referenceFiles = Get-ChildItem -Recurse -Path $folderReference 
$FolderSyncFiles = Get-ChildItem -Recurse -Path $folderToSync

$fileDiffs = Compare-Object -ReferenceObject $referenceFiles -DifferenceObject $FolderSyncFiles 

foreach ($File in $fileDiffs){
    try {
            if ($File.SideIndicator -eq "<="){

                $FullSourceObject = $File.InputObject.Fullname
                $FullTargetObject = $File.InputObject.Fullname.Replace($folderreference, $folderToSync)

                Write-Host "copy File: " $FullSourceObject
                copy-Item -Path $FullSourceObject -Destination $FullTargetObject
            }
    }
    catch {
        Write-Error -Message "Something went wrong!" -ErrorAction Stop
    }
}