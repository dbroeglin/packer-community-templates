# If the ISO is uploaded, unzip and install
if ( Test-Path "C:\Users\vagrant\VBoxGuestAdditions.iso" ) {
    # There needs to be Oracle CA (Certificate Authority) certificates installed in order
    # to prevent user intervention popups which will undermine a silent installation.
    cmd /c certutil -addstore -f "TrustedPublisher" A:\oracle-cert.cer

    # We also need to download 7zip...
    if ( -not ( Test-Path "C:\Windows\Temp\7z920-x64.msi") -and -not( get-command '7z' -ErrorAction SilentlyContinue ) ) {
        (New-Object System.Net.WebClient).DownloadFile('http://www.7-zip.org/a/7z920-x64.msi', 'C:\Windows\Temp\7z920-x64.msi')
        cmd /c msiexec /qb /i C:\Windows\Temp\7z920-x64.msi
    }
    cmd /c move /Y C:\Users\vagrant\VBoxGuestAdditions.iso C:\Windows\Temp
    & "C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\VBoxGuestAdditions.iso -oC:\Windows\Temp\virtualbox
    cmd /c C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe /S
    rm C:\Windows\Temp\VBoxGuestAdditions.iso
}
