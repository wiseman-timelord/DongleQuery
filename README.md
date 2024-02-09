# DongleQuery

### STATUS: 
Alpha. 3 scripts and launcher are done, re-making it into an actual program, finish tomorrow...
- Basic info should be printed to screen, the console commands list should be saved to a txt, and the console is obviously interactive, so as for user to open commands list in notepad, and use them in the console to test them, or the likes.
- use info regarding name of dongle, to name, the file and page title for commands list output.
- re-clone batch from other recent project, then update.
- testing & bugfix.


### DESCRIPTION
In an attempt to turn off the hotspot feature on my dongle modem, to, reduce power usage and optimize performance, I decided to investigate the AT commands available, thereabouts, this resulted in 2 scripts, then I added a console script, and then it became a program. This program assists people in identifying the hardware/software on their USB Internet Dongle, for, updating or getting a custom ROM, but also like myself in configuring their routers custom AT command. 

### FEATURES
- **Auto-Log Cleaning**: The most advanced batch-powershell launcher yet, auto-cleaning the ansi-codes from the "Errors-Crash.Log" upon return to menu.
- **Custom Interface**: The interface has been stretched in order to produce optimal display on basic Info screen, and longer console sessions.
- **Psd1 Persistence**: DongleQuery makes use of my "ImpExpPsd1" script, hence, the settings for the COM port are saved to the `settings.psd1`. 

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
S4
S5
S6
S7
S8
S9
S10
S11
S30
S103
S104
...(Shortened)
```
- AT Console Mode  (from when it was an individual script)...
```

========================( Console Mode )========================

Please enter the COM port number (e.g., 5 for COM5): 3

Configuring SerialPort object for COM3...
Serial port COM3 opened successfully.

Enter an AT Command, or X to Exit: +NETMODE
Command sent: +NETMODE. Waiting for response...
Response:

Enter an AT Command, or X to Exit: +NETMODE 0
Command sent: +NETMODE 0. Waiting for response...
Response:

Enter an AT Command, or X to Exit: +NETMODE 1
Command sent: +NETMODE 1. Waiting for response...
Response:

Enter an AT Command, or X to Exit: +NETMODE ON
Command sent: +NETMODE ON. Waiting for response...
Response:

Enter an AT Command, or X to Exit: +NETMODE ENABLE
Command sent: +NETMODE ENABLE. Waiting for response...
Response:

Enter an AT Command, or X to Exit: NO MANUAL HELP
Command sent: NO MANUAL HELP. Waiting for response...
Response:

Enter an AT Command, or X to Exit:
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
