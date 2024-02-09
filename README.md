# DongleQuery

### STATUS: 
Working.

### DESCRIPTION
A comprehensive tool designed to facilitate interactions with hardware dongles through a serial port interface. The program consists of a batch file launcher (DongleQuery.Bat) that initializes the environment, provides a user interface for selecting actions, and manages the execution of PowerShell scripts for detailed operations. The PowerShell scripts include functionalities for displaying menus, handling serial port communication, executing commands, and managing configuration settings through a PSD1 file. This setup allows for modular and flexible interactions with hardware devices, specifically focusing on sending commands and processing responses through a serial interface.

### FEATURES

Adjusting for a closer alignment with the desired average line length and maintaining concise detail:

### FEATURES
- **Device Information**: Output of, basic device information to screen and a exported commands list for the device to txt file. 
- **Custom Interface**: The interface has been stretched in order to produce optimal display on basic Info screen, and longer console sessions.
- **Psd1 Persistence**: DongleQuery makes use of my "ImpExpPsd1" script, hence, the settings for the COM port are saved to the `settings.psd1`.
- **Serial Communication**: Employs intricate dongle communications console, supporting nuanced command execution and response analysis.
- **Auto-Log Cleaning**: The most advanced batch-powershell launcher yet, auto-cleaning the ansi-codes from the "Errors-Crash.Log" upon return to menu.

### PREVIEW
- Main Menu, where we have 4 options...
```

========================( DongleQuery )========================









                     1. Set COM Port Used
                            (None)

                  2. Display Basic Device Info


                  3. Create CommandsList.Txt


                    4. AT Console Interface









---------------------------------------------------------------
Select; Options = 1-4, Exit = X:


```
- Oh such useful Basic Device Info, I could find a custom ROM from this...
```
========================( DongleQuery )========================

Port COM# Opened Successfully...

Sending command: AT
Response:
OK

Sending command: AT+CGMI
Response:
QUALCOMM INCORPORATED

OK

Sending command: AT+CGMM
Response:
0

OK

Sending command: AT+CGMR
Response:
MDM9K-CIGO-U-7.3.9-4M  1  [Jan 19 2012 21:00:00]

OK

Sending command: ATI
Response:
Manufacturer: QUALCOMM INCORPORATED
Model: 0
Revision: MDM9K-CIGO-U-7.3.9-4M  1  [Jan 19 2012 21:00:00]
SVN: 00
IMEI: ###########
+GCAP: +CGSM

OK


...Sequence Complete, Port COM# Closed.

Retrieved; Check Display, Then Press Any Key...
```
- It creates a nice `CommandsList.Txt` to use in the console...
```

QUALCOMM INCORPORATED
####-####-#-#.#.#-##  #  [### ## #### ##:00:00]

Complete Commands List:
&C
&D
&E
&F
&S
&V
&W
E
I
L
M
Q
V
X
Z
T
P
\Q
\S
\V
%V
D
A
H
O
S0
S2
S3
...(Shortened)
```
- AT Console Interface  (use the generated CommandsList.Txt)...
```
========================( DongleQuery )========================

Port COM3 Opened Successfully...

Enter AT Command (or 'X' to exit): ^WIMODE 0
Response:

Enter AT Command (or 'X' to exit): HELP THERES NO MANUAL!
Response:

Enter AT Command (or 'X' to exit):



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
- Not easy to make, had to go, offline for testing and online for programming, while testing the code, due to port status.
- This program has a theme tune, sing along now.. ["Dongle Query..."](https://www.youtube.com/watch?v=QGKiC2suCHQ)

## DISCLAIMER
This software is subject to the terms in License.Txt, covering usage, distribution, and modifications. For full details on your rights and obligations, refer to License.Txt.
