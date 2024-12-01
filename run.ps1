# ���O�t�@�C���I���_�C�A���O���o��
Add-Type -assemblyName System.Windows.Forms
$FileDialog = New-Object System.Windows.Forms.OpenFileDialog
$FileDialog.Filter = "TEXT Files|*.txt|All Files|*.*"
$FileDialog.InitialDirectory = "$env:APPDATA\..\LocalLow\VRChat\VRChat"
$FileDialog.Title = "�m�F���������O�t�@�C����I�����Ă�������"
if ($FileDialog.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
    Write-Output "�������L�����Z�����܂���"
    $FileDialog.Dispose()
    exit
}
$grepPath = $FileDialog.FileName
$grepPath
$FileDialog.Dispose()

# "OnPlayerJoined"�̃��O�Ƀ��[�U�[ID��������ۂ��̂ŁA���o���Ă���
$userIdLogs = [regex]::Matches((Get-Content -Raw $grepPath -encoding utf8), "OnPlayerJoined\s[^\r\n]*?\s\(usr_[^\r\n]*?\)").Value
$userIdLogs

# �t�����h�ǉ�����"is no longer Muted"�̃��O�ǉ�����Ă���ۂ��̂ŁA��������ɖ��O���܂ޕ�����؂�o��
$friendsData = [regex]::Matches((Get-Content -Raw $grepPath -encoding utf8), "\[ModerationManager\]\s[^\r\n]*?\sis\sno\slonger\sMuted") | Get-Unique
foreach($friend in $friendsData){
    Write-Host --------------------------
    $friend.Value

    # �t�����h�����擾
    $friendName = $friend.Value.Substring(20, $friend.Value.length - 39)
    $friendName

    # ���[�UID���擾
    $userIdLog = $userIdLogs | Where-Object {$_ -like "*$friendName*"}
    $userId = $userIdLog.Substring($userIdLog.length - 41, 40)
    $userId

    # ���[�U��URL���J��
    $userUrl = "https://vrchat.com/home/user/$userId"
    $userUrl
    Start-Process $userUrl
}
