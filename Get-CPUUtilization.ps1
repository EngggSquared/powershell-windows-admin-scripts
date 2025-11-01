function Get-CPUUtilization {
  param (
    [ValidateRange(5, 20)]
    [int] $Samples = 5
  )

  # The loop directly outputs objects to the pipeline, which is more memory-efficient.
  1..$Samples | ForEach-Object {
    # Get the current CPU utilization.
    $cpuUtilizationSample = (Get-CimInstance -ClassName win32_processor).LoadPercentage

    # Create and output a custom object with the desired properties.
    [PSCustomObject]@{
      Timestamp           = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
      'CPU_Utilization_%' = [math]::round($cpuUtilizationSample,2)
    }

    # Pause between samples.
    Start-Sleep -Seconds 0.5
  }
}