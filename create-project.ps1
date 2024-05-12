Function Create-Project {
    $build = Read-Host "Is this an existing project ? [y/n]"

    if ($build -eq 'n') {
        # enter name of project
        while ($true) {
            $name  = Read-Host "What is the name of the project?"
            # validation for name - check if empty
            if ($name) {
                break
            }

            Write-Host -BackgroundColor Red "Please enter a valid name."
        }
            
        # check if projects are work/personal
        $category = Read-Host "Is this project work or personal? [w/p]"
        if ($category -eq 'w') {
            New-Item -Path "C:\Users\User\Projects\Work\" -Name "$name" -ItemType "directory"
        } elseif ($category -eq 'p') {
            New-Item -Path "C:\Users\User\Projects\Personal\" -Name "$name" -ItemType "directory"
        } else {
            Write-Host -BackgroundColor Red "Please enter either 'w' or 'p'."
        }

        # is there a GitHub repo for this project
        $repo = Read-Host "Does it have a remote GitHub repo? [y/n]"
        if ($repo -eq 'y') {
            $is_not_repo_link = $true  # flag

            while ($true) {
                 # try to git clone
                 $repo_link = Read-Host "Remote repo link: "

                try {
                    Invoke-Utility git clone $repo_link
                    break
                } catch {
                    Write-Host "Sorry, the link appears to be wrong. Please try again."
                }

            }
           
        }
    } else {
        # is there a GitHub repo for project
        $repo = Read-Host "Does it have a remote GitHub repo? [y/n]"
        if ($repo -eq 'y') {

        }
    }
}

Function Invoke-Utility {
<#
.SYNOPSIS
Invokes an external utility, ensuring successful execution.

.DESCRIPTION
Invokes an external utility (program) and, if the utility indicates failure by 
way of a nonzero exit code, throws a script-terminating error.

* Pass the command the way you would execute the command directly.
* Do NOT use & as the first argument if the executable name is not a literal.

.EXAMPLE
Invoke-Utility git push

Executes `git push` and throws a script-terminating error if the exit code
is nonzero.
#>
  $exe, $argsForExe = $Args
  # Workaround: Prevents 2> redirections applied to calls to this function
  #             from accidentally triggering a terminating error.
  #             See bug report at https://github.com/PowerShell/PowerShell/issues/4002
  $ErrorActionPreference = 'Continue'
  try { & $exe $argsForExe } catch { Throw } # catch is triggered ONLY if $exe can't be found, never for errors reported by $exe itself
  if ($LASTEXITCODE) { Throw "$exe indicated failure (exit code $LASTEXITCODE; full command: $Args)." }
}