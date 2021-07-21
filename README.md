Mickey-VehicleWhiteList for GTA5
Depends on: QBCore
NOTE: In this code, Change QBCore if you are using a whitelabelled version to the appropriate names.
Depends on:
QBCre

What this does:
This very simply kicks people out of specific vehicles if they do not have the appropriate job.
This does this in a blanket fashion, as it is intended for use by Emergency services.
As such, by default, those with the following jobs can access the vehicles listed in whiltelistedVehicles:
'police', 'LSPD', 'doctor', 'ambulance', 'EMS', 'PBMedical', 'mechanic'
You can add additional jobs in the check line in client.lua 

How to Add Vehicles to whitelisting:
Simply add the vehicle name to the table in client.lua 
Example: whitelistedVehicles = {"carname1 , 'carname2'}
(if you are unsure, its the name used to spawn the vehicle, often found in the vehicles carvariations.meta file.
