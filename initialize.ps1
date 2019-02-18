function Remove-Directories {
    Param ([String[]] $Directories)
    foreach ($Directory in $Directories) {
        Remove-Item $Directory -Recurse -Force -ErrorAction SilentlyContinue
    }
}

function Clone-Repos {
    Param ([String[]] $Repos, [String] $Directory)
    New-Item $Directory -ItemType Directory -Force -ErrorAction SilentlyContinue
    Set-Location $Directory
    foreach ($Repo in $Repos) {
        Invoke-Expression "git clone --recurse-submodules -j8 git@github.com:U9H/${Repo}.git"
    }
    Set-Location "../"
}

$Repos = "blog", "front"

"Cleaning up workspace..."
Remove-Directories -Directories "sites"

"Cloning repositories"
Clone-Repos "front", "blog" -Directory "sites"