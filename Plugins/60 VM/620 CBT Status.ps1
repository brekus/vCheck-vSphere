# Start of Settings
$ClusterDoNotInclude = "Cluster1*|Cluster2*"
$VMDoNotInclude = "VM1|VM2*"
# End of Settings

$CBTEnabled = $false

$VMsCBTStatus = @($VM | Where-object {$_.Name -notmatch $VMDoNotInclude} | Where-Object {$_.VMHost.Parent -notmatch $ClusterDoNotInclude} | Where-object {$_.ExtensionData.Config.ChangeTrackingEnabled -eq $CBTEnabled} | Select-Object Name, @{Name="Change Block Tracking";Expression={if ($_.Config.ChangeTrackingEnabled) { "enabled" } else { "disabled" }}} | Sort Name)
$VMsCBTStatus

$Title = "VM - Display all VMs with CBT not enabled"
$Header = "VM with CBT disabled : $(@($VMsCBTStatus).Count)"
$Comments = "List all VMs with CBT status disabled. It's not a good option for backup!"
$Display = "Table"
$Author = "Cyril Epiney"
$PluginVersion = 1.0
$PluginCategory = "vSphere"
