# DongleQuery

### STATUS: 
Working.

### DESCRIPTION
A comprehensive tool designed to facilitate interactions with hardware dongles through a serial port interface. The program consists of a batch file launcher (DongleQuery.Bat) that initializes the environment, provides a user interface for selecting actions, and manages the execution of PowerShell scripts for detailed operations. The PowerShell scripts include functionalities for displaying menus, handling serial port communication, executing commands, and managing configuration settings through a PSD1 file. This setup allows for users to better determine strings of custom AT commands, for example, for use with configuring their routers.

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
- AT Console Interface  (these are not the droids we are looking for)...
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
1. Open "Device Manager" on your computer to find the COM Port number used by your dongle modem. Pay attention to the COM Port it uses for inactive states.
2. Ensure your dongle modem is not connected to the internet, while for any relating applications to be closed, to prevent any interference during the execution process.
3. Execute the "DongleQuery.Bat", and then select option 1, this action launches the powershell script.
5. When the menu appears, then select 1 to enter the COM Port number you identified from the "Device Manager".
6. Select the option 2 if you want some basic info about your device, and if you want a commands list for you device, then select option 3, and if you want to mess around on the console select option 4, but ensure to know what you are doing.
7. Upon completion of your tasks in DongleQuery, then close the program from the menu by entering 'X', and you may so choose to do this again on the Launcher Menu.

### REQUIREMENTS
- Windows Batch Support
- Pwsh/PowerShell (As are compatible with scripts)
- Usb "Mobile Broadband"/"LTE Modem" with relating com ports.

### NOTATION
- If you wish to create a custom AT command for your router, you would use something like this `AT+CGDCONT=1,"IP","**YourAPN**";ATD**YourNumberDialed**`, supposedly you can add to that somehow with some of the commands you found in your command list.
- Not easy to make, had to go, offline for testing and online for programming, while testing the code, due to port status.
- This program has a theme tune, sing along now.. ["Dongle Query..."](https://www.youtube.com/watch?v=QGKiC2suCHQ)

## DISCLAIMER
This software is subject to the terms in License.Txt, covering usage, distribution, and modifications. For full details on your rights and obligations, refer to License.Txt.
