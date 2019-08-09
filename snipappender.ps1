$file_w = "C:\Users\yt\Documents\Twitch Assets\Snip\Snip.txt"
$file_r = "C:\Users\yt\Documents\Twitch Assets\d2d about.txt"
$file_c = "C:\Users\yt\Documents\Twitch Assets\d2d crawl.txt"

Function Register-Watcher {
    param ($folder)
    $filter = "*.*" #all files
    $watcher = New-Object IO.FileSystemWatcher $folder, $filter -Property @{ 
        IncludeSubdirectories = $false
        EnableRaisingEvents = $true
    }

    $changeAction = [scriptblock]::Create('
        # This is the code which will be executed every time a file change is detected
        $path = $Event.SourceEventArgs.FullPath
        $name = $Event.SourceEventArgs.Name
        $changeType = $Event.SourceEventArgs.ChangeType
        $timeStamp = $Event.TimeGenerated
        $text = (Get-Content $file_r) + "Current Music: " + (Get-Content $file_w) + " - "
        Set-Content -Path $file_c -Value $text
        Write-Host "The file $name was $changeType at $timeStamp"
        Write-Host $text
    ')

    Register-ObjectEvent $Watcher "Changed" -Action $changeAction
}

 Register-Watcher "C:\Users\yt\Documents\Twitch Assets\Snip"