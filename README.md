# TaskTracker
PowerShell TaskTracker Script

This is a script that you can set up as a scheduled task to track what you are working on throughout a working day

It currently does so via a small amount of C# code that can grab the Current Active Window and compare this to the process list and output what that process is.
It also disregards any possible system processes (I.e Non-Interactive) that can be included in the output from time to time whilst this script is running - something that I saw no reason in debugging further

# TODO
See if can get FF/Chrome URL for active window too as that would be a great way to add additional tracking metrics too!
