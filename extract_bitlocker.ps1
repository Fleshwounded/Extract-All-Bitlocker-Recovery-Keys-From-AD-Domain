#Extract all bitlocker recovery keys from domain - tinfoilcipher 2015

#Constants
$strOU = <OU_DISTINGUISHED_NAME>
$strHeader = ("hostName,bitLockerStatus,operatingSystem")
$strLog = "results.csv"
$strHeader | Out-File $strLog -Append -Encoding ASCII

#Modules
Import-Module ActiveDirectory

#Base Array. Recurse the defined OU for all computers
[array]$arrComputers = Get-ADComputer -SearchBase $strOU -Filter * | Select-Object -ExpandProperty samAccountName

#Query - Load FVE Recovery Data in to an object then collapse it for the recovery keys. If a NULL value is returned, no key exists
ForEach ($arrComputer In $arrComputers){
	[string]$strComp = $arrComputer
	$strComputer = Get-ADComputer -Identity $strComp -Properties *
	$strOS = $strComputer.operatingSystem
	$objBit = Get-ADObject -SearchBase $strComputer.distinguishedName -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -Properties 'msFVE-RecoveryPassword'
	$strKey = $objBit.'msFVE-RecoveryPassword'
	If ($strKey){
		$strKeyValue = $strKey
	}
	ElseIf(!$strKey){
	  $strKeyValue = "NO_BITLOCKER"
	}

	#Output results to log
	$strOutputString = ($strComp + "," + $strKeyValue + "," + $strOS)
	$strOutputString | Out-File $strLog -Append -Encoding ASCII

	#Flush values for next run
	$strComp = $NULL
	$strHost = $NULL
	$objBit = $NULL
	$strKeyValue = $NULL
	$strKey = $NULL
	$strOutputString = $NULL
}

#END.
