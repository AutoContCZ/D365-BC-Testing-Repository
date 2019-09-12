$host.UI.RawUI.WindowTitle = "Git initialization script"

function PullAllBranches() {
    $branches = git branch -r
    foreach($branch in $branches){
        $fixedBranch = $branch.Substring(2, $branch.Length - 2)
        $trackedBranch = $fixedBranch.Substring(7, $fixedBranch.Length - 7)
        if ($trackedBranch -ne "master") {
            git branch --track $trackedBranch $fixedBranch
        }
        else {
            git branch --set-upstream-to=origin/master master
        }
    }
}
# Promting the type of init
# Getting the remote URL
Write-Output "Do you wish to init new bare repository or to clone an existing one?"
$option = Read-Host -Prompt "Write I for initialization of a new repository or C for cloning existing one: "

# Getting the remote URL
$remoteURL = Read-Host -Prompt "Please enter the remote's URL: "
Write-Output $remoteURL


if ($option -eq "I" -Or $option -eq "i") {
    $pathToRepo = Read-Host -Prompt "Please provide path to the directory, where you want to init the repository"
    $repoName = Read-Host -Prompt "Please provide a name for the repositry: "

    Write-Output "Changing to given path and creating a folder to for the repository."

    Set-Location $pathToRepo
    mkdir $repoName
    Set-Location $pathToRepo/$repoName

    # Init the empty git repo
    Write-Output "Initializating empty git repository"
    git init

    Write-Output "Setting up the remote"
    git remote add origin $remoteURL
    git pull origin master
    git fetch --all
    PullAllBranches

    Write-Output "Everything is initilaized and works fine"
}
elseif ($option -eq "C" -Or $option -eq "c") {
    $split = $remoteURL.split("/")
    $text = $split[1].split(".")
    $repo = $text[0]
    $pathToRepo = Read-Host -Prompt "Please provide path to the directory, to where you want to clone the repository"
    Set-Location $pathToRepo
    Write-Output "Cloning git repository"
    git clone $remoteURL
    Set-Location $pathToRepo/$repo
    git fetch --all
    PullAllBranches
}
else {
    Write-Output "Unknown command!"
}


pause