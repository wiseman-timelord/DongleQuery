# DongleQuery

### STATUS: 
Alpha...
- The theme tune is figured out (see notes)!
- Waiting for GPT to refresh, done soon.

### DESCRIPTION
In an attempt to turn off the hotspot feature on my dongle modem, while it is attached to my router, I decided to investigate the AT commands available, therein, I may have future dongles, that I wish to do this on also, hence, I made a program to do, just that and a little more.

### FEATURES
- Soon...

### PREVIEW
- Basic Info...
```

========================( DongleQuery )========================

Please enter the COM port number (e.g., 5 for COM5): 3

Configuring SerialPort object for COM3...
Serial port COM3 opened successfully.

Sending AT to the modem on COM3...
Spam prevention, waiting 2 seconds...
Response for AT:
OK

Sending AT+CGMI to the modem on COM3...
Spam prevention, waiting 2 seconds...
Response for AT+CGMI:
QUALCOMM INCORPORATED

OK

Sending AT+CGMR to the modem on COM3...
Spam prevention, waiting 2 seconds...
Response for AT+CGMR:
#####-####-#-#.#.#-##  #  [### ## #### ##:##:##]

OK

Sending ATI to the modem on COM3...
Spam prevention, waiting 2 seconds...
Response for ATI:
Manufacturer: QUALCOMM INCORPORATED
Model: 0
Revision: #####-####-#-#.#.#-##  #  [### ## #### ##:##:##]
SVN: 00
IMEI: ###############
+GCAP: +CGSM

OK

Closing the SerialPort connection...

Processes completed; Check details above, then Press any key...
```
- Commands...
```
```

### USAGE
1. Go to "Device Manager", and look at what Com Ports are being used, in my case the modem was using 2 com ports, one for active and one for inactive, I needed the one for inactive states, though you may test other ones.
2. Ensure your Dongle Modem is OFF, so as to not be connected to the internet on it.
3. Run "DongleQuery.Bat", select the relevant script you wish to test, it will run that script.
4. Enter the Com Port number you got from "Device Manager", the script will then send the relevant commands on the relevant Com Port.
5. Review the output, if there are errors, try other Com Ports you found; otherwise the commands dont work on your specific Modem; After the script runs it will pause.
6. After breaking the Pause, choose, to run the other relating number of the script or to "Exit Menu" with 'x'.

### REQUIREMENTS
- Windows Batch Support
- Pwsh/PowerShell (As are compatible with scripts)
- Usb "Mobile Broadband"/"LTE Modem" with relating com ports.

### NOTATION
- Sing along now.. ["Dongle Query..."](https://www.youtube.com/watch?v=QGKiC2suCHQ)
  
## DISCLAIMER
This software is subject to the terms in License.Txt, covering usage, distribution, and modifications. For full details on your rights and obligations, refer to License.Txt.
