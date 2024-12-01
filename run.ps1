# ログファイル選択ダイアログを出す
Add-Type -assemblyName System.Windows.Forms
$FileDialog = New-Object System.Windows.Forms.OpenFileDialog
$FileDialog.Filter = "TEXT Files|*.txt|All Files|*.*"
$FileDialog.InitialDirectory = "$env:APPDATA\..\LocalLow\VRChat\VRChat"
$FileDialog.Title = "確認したいログファイルを選択してください"
if ($FileDialog.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
    Write-Output "処理をキャンセルしました"
    $FileDialog.Dispose()
    exit
}
$grepPath = $FileDialog.FileName
$grepPath
$FileDialog.Dispose()

# "OnPlayerJoined"のログにユーザーIDがあるっぽいので、抽出しておく
$userIdLogs = [regex]::Matches((Get-Content -Raw $grepPath -encoding utf8), "OnPlayerJoined\s[^\r\n]*?\s\(usr_[^\r\n]*?\)").Value
$userIdLogs

# フレンド追加時に"is no longer Muted"のログ追加されてるっぽいので、それを元に名前を含む部分を切り出す
$friendsData = [regex]::Matches((Get-Content -Raw $grepPath -encoding utf8), "\[ModerationManager\]\s[^\r\n]*?\sis\sno\slonger\sMuted") | Get-Unique
foreach($friend in $friendsData){
    Write-Host --------------------------
    $friend.Value

    # フレンド名を取得
    $friendName = $friend.Value.Substring(20, $friend.Value.length - 39)
    $friendName

    # ユーザIDを取得
    $userIdLog = $userIdLogs | Where-Object {$_ -like "*$friendName*"}
    $userId = $userIdLog.Substring($userIdLog.length - 41, 40)
    $userId

    # ユーザのURLを開く
    $userUrl = "https://vrchat.com/home/user/$userId"
    $userUrl
    Start-Process $userUrl
}
