$host.UI.RawUI.WindowTitle = "Git initialization script"

function PullAllBranches() {
    $branches = git branch -r
    foreach($branch in $branches){
        $fixedBranch = $branch.Substring(2, $branch.Length - 2)
        $trackedBranch = $fixedBranch.Substring(7, $fixedBranch.Length - 7)
        if ($trackedBranch -ne "master") {
            git branch --track $trackedBranch $fixedBranch
        }
    }
}

# Init the empty git repo
Write-Output "Initializating empty git repository"
git init


# Getting the remote URL
$remoteURL = Read-Host -Prompt "Please enter the remote's URL: "
Write-Output $remoteURL

Write-Output "Setting up the remote"
git remote add origin $remoteURL
git pull origin master
git branch --set-upstream-to=origin/master master
git fetch --all
PullAllBranches


Write-Output "Everything is initilaized and works fine"

pause