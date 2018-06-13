# Extract-All-Bitlocker-Keys-From-AD-Domain
Extract all bitlocker keys from an Microsoft Active Directory Domain<br>
<br>
The function of this script is perform a recursive lookup through an Active Directory (without the reliance on the Bitlocker Tools needing
to be installed. To that end it can be executed from any workstation that has the appropriate rights to perform the query against the
domain and saves the hassle of needing to find each recovery key manually.<br>
<br>
Typically the data is not easily searchable from a query since the actualy recovery key value msFVE-RecoveryPassword is embedded within
msFVE-RecoveryInformation, itself an attribute of the computer object and the string being searched for is visible in Active Directory
via the Bitlocker Tools but NOT via ADSIEdit.<br>
<br>
USE<br>
Enter the distinguisedName of the root OU (or to cast a wider net, the root of the domain) as the constant $strOU and execute the script.
Output will be saved in a CSV file named results.csv in the same directory by default, though this can be changed by modifying the $strLog
constant.
