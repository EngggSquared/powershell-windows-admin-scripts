function Get-DiskUtilization{
    $disks = Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} 
    
    $disks | ForEach-Object {
        [PSCustomObject]@{
            DriveLetter = $_.DeviceID
            DriveVolumeName = $_.VolumeName
            CapacityGB = [math]::round($_.Size/1GB, 2)
            FreeSpaceGB = [math]::round($_.FreeSpace/1GB, 2)
            'FreeSpace%' = [math]::round(($_.FreeSpace/$_.Size)*100, 2)
        }
    }
}