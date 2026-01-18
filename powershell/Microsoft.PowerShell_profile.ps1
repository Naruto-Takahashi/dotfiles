Invoke-Expression (&starship init powershell)

# Wrap the Starship prompt to inject WezTerm OSC 7 sequence
$oldPrompt = $function:prompt
function prompt {
    if ($env:WEZTERM_PANE) {
        $loc = $executionContext.SessionState.Path.CurrentLocation
        if ($loc.Provider.Name -eq "FileSystem") {
            $path = $loc.ProviderPath -replace '\\', '/'
            $esc = [char]27
            $bs = '\'
            # Split the string construction to strictly avoid \" sequence issues
            Write-Host -NoNewline ("{0}]7;file://localhost/{1}{0}{2}" -f $esc, $path, $bs)
        }
    }
    & $oldPrompt
}


function nvimtutor {
    # 1. Fixed path
    $vimruntime = "C:\ Program Files\Neovim\share\nvim\runtime"
    $source = Join-Path $vimruntime "tutor\ja\vim-01-beginner.tutor"

    # 2. Check if source exists
    if (!(Test-Path -LiteralPath $source)) {
        Write-Host "Error: Japanese tutor file not found." -ForegroundColor Red
        Write-Host "Location: $source"
        return
    }

    # 3. Copy to temp (reset every time)
    $temp = "$env:TEMP\vimtutor_practice.tutor"
    Copy-Item -LiteralPath $source -Destination $temp -Force

    # 4. Open copy
    Write-Host "Starting tutorial..." -ForegroundColor Green
    # Use single quotes for the nvim command argument to avoid confusion
    nvim $temp -c 'set nonumber norelativenumber'
}

# Change command input color to Green for visibility
Set-PSReadLineOption -Colors @{
    Command = 'Green'
    Parameter = 'DarkGreen'
    Operator = 'Green'
    String = 'DarkGreen'
}