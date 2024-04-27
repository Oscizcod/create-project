Function Create-Project {
    $build = Read-Host "Do you want to build a project? [y/n]"

    if ($build -eq 'y') {
        while ($true) {
            $name  = Read-Host "What is the name of the project?"

            # validation for name - check if empty
            if ($name) {
                break
            }

            Write-Host -BackgroundColor Red "Please enter a valid name."
        }
            
        $category = Read-Host "Is this project work or personal? [w/p]"

        # check if projects are work/personal
        if ($category -eq 'w') {
            New-Item -Path "C:\Users\User\Projects\Work\" -Name "$name" -ItemType "directory"

            # is it a new project
        } elseif ($category -eq 'p') {
            New-Item -Path "C:\Users\User\Projects\Personal\" -Name "$name" -ItemType "directory"
        } else {
            Write-Host -BackgroundColor Red "Please enter either 'w' or 'p'."
        }
    } else {
        Write-Host "Till the next idea!"
    }
}