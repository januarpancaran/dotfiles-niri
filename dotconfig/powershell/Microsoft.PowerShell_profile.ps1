# History
if (Get-Module -ListAvailable PSReadLine) {
    Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
    Set-PSReadLineOption -MaximumHistoryCount 10000
    Set-PSReadLineOption -HistoryNoDuplicates:$true
    Set-PSReadLineOption -HistorySavePath "$env:HOME/.ps_history"
}

# Keybinding
Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord "Ctrl+n" -Function HistorySearchForward

if ($PSVersionTable.PSEdition -eq "Core") {
    try {
        Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function AcceptSuggestion
    }
    catch {
        Write-Verbose "AcceptSuggestion not available in this PSReadLine version"
    }
}

# Aliases
Set-Alias vi "nvim"
Set-Alias vim "nvim"
function nfzf { nvim (fzf -m --preview 'bat --color=always {}') }
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }

# Autostarts
if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
    fastfetch
}

if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { zoxide init powershell | Out-String })
}
