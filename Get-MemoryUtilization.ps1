function Get-MemoryUtilization {
  $os =  Get-WmiObject -Class WIN32_OperatingSystem

  $memoryUtilization = (($os.TotalVisibleMemorySize - $os.FreePhysicalMemory)/$os.TotalVisibleMemorySize) * 100

  [PSCustomObject]@{
    Timestamp = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
    'Memory_Utilization_%' = [math]::round($memoryUtilization, 2)
  }
}