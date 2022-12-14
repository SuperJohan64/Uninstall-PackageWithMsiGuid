$PackageNames = "Dell Command*Update*Windows 10*","Dell Command*Update for Windows Universal","Lenovo System Update"

foreach ($PackageName in $PackageNames) {
    Try {
        Write-Host "`nChecking for: $PackageName"
        $PackageProviderName = (Get-Package $PackageName -ErrorAction Stop).ProviderName
        if ($PackageProviderName -eq "msi") {
            $PackageGuid = (Get-Package $PackageName -ErrorAction Stop).fastpackagereference
            Write-Host "Package found.`nStarting msiexec."
            Try {
                Start-Process -FilePath msiexec.exe -ArgumentList "/x $PackageGuid /qn /norestart" -Wait -ErrorAction Stop
                Write-Host "Uninstall complete."
            }
            Catch {Write-Host "Msiexec failed."}
        }
        Else {Write-Host "Package is not a MSI."}
    }
    Catch {Write-Host "Could not uninstall package."}
}
