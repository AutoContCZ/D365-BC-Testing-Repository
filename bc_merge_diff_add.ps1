$host.UI.RawUI.WindowTitle = "Script for configuring Beyond Compare as git merge and git diff tool"

$pathToBc = Read-Host -Prompt "Please enter the path to your Beyond Compare installation folder"
$pathToBc = $pathToBc+"/bcomp.exe"
$pathToBc = $pathToBc -replace '\\','/'

while (1) {

    if (Test-Path -Path $pathToBc) {
        Write-Output "Beyond Compare as diff tool"
        git config --global diff.tool bc3
        git config --global difftool.bc3.path $pathToBc
        Write-Output "Beyond Compare as merge tool"
        git config --global merge.tool bc3
        git config --global mergetool.bc3.path $pathToBc
        Get-Content $HOME\.gitconfig
        break
    }
    else {
        $pathToBc = Read-Host -Prompt "Invalid path! `n Please enter valid path to your Beyond Compare installation folder"
    }
}

Pause