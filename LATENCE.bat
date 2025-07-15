powercfg -devicequery wake_from_any > devices.txt
ForEach ($device in Get-Content devices.txt) {
    powercfg -devicedisablewake "$device"
}
