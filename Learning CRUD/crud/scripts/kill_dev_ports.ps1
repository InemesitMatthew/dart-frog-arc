# Frees TCP listen ports for Dart Frog (HTTP + VM service + transient codegen dev).
param(
    [int[]]$Ports = @(8080, 8181, 8182)
)
$ErrorActionPreference = 'SilentlyContinue'
foreach ($port in $Ports) {
    $listeners = @(Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue)
    foreach ($conn in $listeners) {
        $owningPid = $conn.OwningProcess
        if ($owningPid -and $owningPid -ne 0 -and $owningPid -ne 4) {
            Stop-Process -Id $owningPid -Force
        }
    }
}
