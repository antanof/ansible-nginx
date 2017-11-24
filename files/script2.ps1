#Variables
$CLI1 = "ANSIBLE_VM"
$CRAM = 852MB
$CLI1VHD = 10GB
$VMLOC = "C:\Users\Public\Documents\Hyper-V"
$NetworkSwitch1 = "PrivateSwitch1"
$ISO = "C:\Deuterium.iso"

#VM Folder & Network Switch
MD $VMLOC -ErrorAction Silentlycontinue
$TestSwitch = Get-VMSwitch -Name $NetworkSwitch1 -ErrorAction SilentlyContinue; if ($TestSwitch.Count -EQ 0){New-VMSwitch -Name $NetworkSwitch1 -SwitchType Private}

#Create Virtual Machine
New-VM -Name $CLI1 -Path $VMLOC -MemoryStartupBytes $CRAM
New-VHD -Path $VMLOC\$CLI1.vhdx -SizeBytes $CLI1VHD -Dynamic -SwitchName $NetworkSwitch1
Add-VMHardDiskDrive -VMName $CLI1 -Path $VMLOC\$CLI1.vhdx

#Configure VM
Set-VMDvdDrive -VMName $CLI1 -ControllerNumber 1 -Path $ISO
Start-VM -Name $CLI1
