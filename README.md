# Active Directory Home Lab

<h2>Description</h2>
This lab goes through the process of creating a Windows Server virtual machine on Oracle VirtualBox to simulate creating users and administrating them within a business environment.
<br />

<h2><b>Languages and Utilities</b></h2>

- <b>PowerShell</b>
- <b>Excel</b>

<h2>Environments</h2>

- <b>Oracle VM VirtualBox</b>
- <b>Windows Server 2019</b>
- <b>Windows 10 Pro</b>

<h2>Lab walk-through:</h2>
<p align="center">
  Active Directory Home Lab Model: <br/>
  <img src="https://i.imgur.com/9SV2uR0.png" height="75%" width="75%" alt="AD Home Lab Model"/>
</p>
<ol>
  <h3><b>PART 1 – Setup Environment</b></h3>
  <li><b>Install Oracle VM VirtualBox</b>
    <ol>
      <li>Go to https://www.virtualbox.org/wiki/Downloads</li>
      <li>Download most recent package (click on the appropriate platform) & install</li>
      <li>Once completed, download VirtualBox Extension Pack & install</li>
    </ol>
  </li>
  <br />
  <br />

<li><b>Install Windows Server iso file</b>
  <ol>
    <li>Go to https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2019
      <ul><li>You can change the year in the link for your preferred version (2022, 2019, 2016, etc.)</li></ul>
    </li>
    <li>Under “Get started for free”, choose the option “Download the ISO”</li>
    <li>Enter info for free trial (you don’t need to own a company to get a free trial)</li>
    <li>Download English 64-bit version under “ISO downloads”</li>
  </ol>
</li>
<br />
<br />

<li><b>Setup Windows Server 2019 VM</b>
  <ol>
    <li>Open VirtualBox application, click “New” button</li>
    <li>Enter type as “Microsoft Windows” and version as “Other Windows (64-bit)” & click continue</li>
    <li>Enter defaults & personal choices for the rest until creation is complete</li>
    <li>Edit some settings
      <ol>
        <li>Go to settings -> general -> advanced tab, change Shared Clipboard & Drag’n’Drop to Bidirectional</li>
        <li>Go to network -> adapter 2 tab, enable network adapter & change “Attached To” setting to “Internal Network”</li>
      </ol>
    </li>
    <li>Start the VM & select ISO file for Windows Server 2019, go through the installation process
      <ol>
        <li>Select Windows Server 2019 Standard Evaluation (Desktop Experience) version</li>
        <li>Select custom installation type, click next on allocation page, wait for installation</li>
        <li>Enter new admin password, log in, select “yes” on networks</li>
        <li>On VirtualBox, go to devices and click “Insert Guest Additions CD image…”</li>
        <li>In VM, go to file explorer, go to PC & double click CD Drive (D:) VirtualBox Guest Additions</li>
        <li>Double-click VBoxWindowsAdditions-amd64 & select all defaults & manually reboot later</li>
        <li>Shut down the VM completely, start it up again & log in</li>
      </ol>
    </li>
    <li>Setup IP address for internal network
      <ol>
        <li>Click network icon at bottom right tray, click network & then click “Change adapter options”</li>
        <li>Identify the two networks as Internet (10.0.2.15) & internal (169.254.196.79) networks by clicking on each network icon and then clicking "status"</li>
        <li>Right-click the internal network, click properties, double-click Internal Protocol Version 4</li>
        <li>Click “Use the following IP address:”, enter the values on the diagram for NIC (internal)</li>
        <li>Click ok, exit network settings</li>
      </ol>
    </li>
    <li>Right-click the start menu button, go to System & click “Rename this PC”, click restart</li>
  </ol>
</li>
<br />
<br />

<li><b>Create domain for the server</b>
  <ol>
    <li>Go to server manager dashboard & click “add roles and features”</li>
    <li>Click next (x2)</li>
    <li>Select server & click next, pick “active directory domain services”</li>
    <li>Click next (x3)</li>
    <li>Click install</li>
    <li>Once installation is complete, click “Promote this server to a domain controller”</li>
    <li>Select option “add a new forest” & enter anything as the root domain name (example: “mydomain.com”) & click next</li>
    <li>Enter password</li>
    <li>Click next (x4)</li>
    <li>Click install (VM will restart on its own)</li>
  </ol>
</li>
<br />
<br />

<li><b>Configure Domain Admin Account</b>
  <ol>
    <li>Log in again, click the start menu icon, go to “Windows Administrative Tools” & click “Active Directory Users and Computers”</li>
    <li>Right-click “mydomain.com”, go to “New”, click “Organizational Unit”, name the administrators folder (uncheck box for simulations) & click ok to create it</li>
    <li>Right-click administrator folder, go to “New”, click “User” & fill out info for admin account (info, then password, then click finish on confirmation page)</li>
    <li>Right-click on admin user & click on “Properties” & a new window will pop up</li>
    <li>Go to “members of” tab, click on “Add…” button & a new window will pop up</li>
    <li>Enter the administrator domain name & click “Check Names” button to confirm it, click ok</li>
    <li>Click apply & ok buttons to the previous window</li>
  </ol>
</li>
<br />
<br />

<li><b>Install RAS/NAT (Remote Access Server/Network Address Translation)</b>
  <ol>
    <li>Go to Server Manager dashboard, click “Add roles and features”</li>
    <li>Click next (x2)</li>
    <li>Make sure you have selected the proper domain & click next</li>
    <li>Select “Remote Access” role</li>
    <li>Click next (x3)</li>
    <li>Select “Routing” & click “Add Features” 
      <ul><li>“DirectAccess and VPN (RAS)” gets automatically checked along by selecting “Routing”</li></ul>
    </li>
    <li>Click next (x3)</li>
    <li>Click install & click close once installation is complete</li>
    <li>At the top right of the Server Manager dashboard, click “Tools” & go to “Routing and Remote Access”</li>
    <li>Click on the server name (DC in this case), right-click & click on “Configure and Enable Routing and Remote Access”</li>
    <li>Click next, select NAT option, click next again</li>
    <li>Select “Use this public interface to connect to the Internet” option and select the “INTERNET” network interface (not the internal one)
      <ul><li>NOTE: This option might be greyed out. If it is, exit the wizard, go to step e & repeat the processes up until here</li></ul>
    </li>
    <li>Click next</li>
    <li>Click finish</li>
  </ol>
</li>
<br />
<br />

<li><b>Setup DHCP Server on Domain Controller</b>
  <ol>
    <li>Go to Server Manager dashboard, click “Add roles and features”</li>
    <li>Click next (x2)</li>
    <li>Make sure you have selected the proper domain & click next</li>
    <li>Select “DHCP Server”, click “Add Features”</li>
    <li>Click next (x3)</li>
    <li>Click install & close once installation is complete</li>
    <li>At the top right of the Server Manager dashboard, click “Tools” & go to “DHCP”</li>
    <li>We need to give our Domain Controller a scope that will give IP addresses in a certain range
      <ol>
        <li>172.16.0.100 with a subnet mask</li>
        <li>Go to DHCP server dropdown & right click IPv4 & click “New Scope…”</li>
        <li>Click next, enter name (172.16.0.100-200) & click next</li>
        <li>Enter start IP & end IP addresses (in this case, 172.16.0.100 & 172.16.0.200), click next</li>
        <li>We can enter ranges to exclude on the next page, but for the lab we don’t need to. Click next</li>
        <li>We can enter lease duration on the next page, but for the lab we don’t need to. Click next</li>
        <li>Select “Yes, I want to configure these options now” & click next</li>
        <li>Enter the IP address of the Domain Controller as the router, click “Add” & click next</li>
        <li>Make sure the domain created earlier is the Parent domain (in this case, “mydomain.com”)</li>
        <li>Click next, you can enter WINS servers but they’re old, click next</li>
        <li>Select “Yes, I want to activate this scope now”, click next & click finish (You may have to right click “dc.domain.com”, click on “Authorize”, right click “dc.domain.com” & click “Refresh”)</li>
      </ol>
    </li>
  </ol>
</li>
<br />
<br />

<h3><b>PART 2 – Setup Users & Computers on the Server</b></h3>
<li><b>Create Users from PowerShell commands in Active Directory</b>
  <ol>
    <li>Go to Server Manager Dashboard, click “Configure this local server”</li>
    <li>Go to “IE Enhanced Security Configuration” setting & turn it off for admins & users, click ok</li>
    <li>Click Start menu icon, click Windows PowerShell folder & right-click “Windows PowerShell ISE”</li>
    <li>Go to “more”, click “Run as Administrator” & click “Yes”</li>
    <li>**DON'T DO THIS OUTSIDE OF THE CONTEXT OF THE LAB**
      <ol>
        <li>On the PowerShell side (blue bottom screen), type "Set-ExecutionPolicy Unrestricted" & press enter</li>
        <li>A warning pop-up will appear, click "Yes to All"</li>
      </ol>
    </li>
    <li>Click second to left top folder icon “Open Script”, select script & click “Open”</li>
    <li>Copy over PowerShell script from <a href="https://github.com/Simon3457/ADHomeLab/blob/main/ADScript/CreateUsers.ps1">here</a>, or write the script yourself</li>
    <li>Place script in same directory as your users text file & navigate to that folder within PowerShell ISE</li>
    <li>Run the script from PowerShell ISE, users should be populating in the "_USERS" AD group</li>
    <li>Once the script is done, leave the server running & we wil go to the next step</li>
  </ol>
</li>
<br />
<br />

<li><b>Install & create installation media for Windows 10 iso file</b>
    <ol>
      <li>From link https://www.microsoft.com/en-us/software-download/windows10</li>
      <li>Under “Create Windows 10 installation media”, click on “Download tool now”</li>
      <li>Click on downloaded tool, accept terms & choose option “Create installation media”</li>
      <li>Choose default options for architecture, choose “ISO file” option for media to use</li>
    </ol>
  </li>
  <br />
  <br />
 
 <li><b>Setup Windows 10 VM for client</b>
   <ol>
     <li>Open VirtualBox Manager application, click on “New” button</li>
     <li>Pick Windows 10 disk as the ISO image, choose a name & destination folder for the VM</li>
     <li>Write a username & password we created earlier (for this example, password is "Password1" and username is "sboudreau"), as well as a hostname</li>
     <li>Pick its hardware settings</li>
     <li>Click next (x2) & click finish</li>
     <li>Right-click the new VM & click "settings"</li>
     <li>Go to "Advanced" tab, change "Shared Clipboard" and "Drag'N'Drop" settings to "Bidiretional"</li>
     <li>Go to "Network" section, change the "Attached to" setting to "Internal Network" & click ok</li>
     <li><b>**FIX ISSUE “Windows cannot read the product key setting from the unattended answer file”**</b>
       <ol>
         <li>Go to settings -> system -> motherboard tab, unselect “floppy” in the boot order</li>
         <li>Go to settings -> general -> advanced tab, you can see your virtual machine folder path</li>
         <li>Go to file explorer where the virtual machine folder is, and remove all files “unattended” (there will be a long string of random characters following it)</li>
         <li>Ignore “Virtual Machine ran into a fatal problem” error message & set up as normal (following steps)</li>
       </ol>
     </li>
     <li>Click next & click "Install Now"</li>
     <li>Click "I don't have a product key"</li>
     <li>Select "Windows 10 Pro" & click next</li>
     <li>Check "I accept the license terms" & click next</li>
     <li>Click "Custom: Install Windows only (advanced)" option, click next & wait for installation to complete</li>
     <li>Select region, click Yes</li>
     <li>Select keyboard layout, click Yes</li>
     <li>Select second keyboard, or just click Skip</li>
     <li>Select "Set up for personal use", select "Offline account" & then select "Limited experience"</li>
     <li>Enter a username for the local account (you don't need a password for it so skip that part)</li>
     <li>Click "Not Now"</li>
     <li>Uncheck all the privacy settings & click "Accept"</li>
     <li>Click "Not Now" & wait for setup to complete</li>
   </ol>
 </li>
 <br />
 <br />

<li><b>Setup Windows 10 user</b>
  <ol>
    <li>To make sure everything on the network works, click the start menu button, type "cmd", press enter
      <ol>
          <li>Type "ipconfig" & press enter. If there's no default gateway, we need to edit a few settings:
            <ol>
              <li>Go to server manager application, click "Tools" located at the top-right of the page & click "DHCP"</li>
              <li>Under "IPv4" dropdown, click "Server Options"</li>
              <li>Under "Actions" located at the right, click "More Actions" & click "Configure Options..."</li>
              <li>Check the option "003 Router"</li>
              <li>Under "IP Address:", type the IP address for the DHCP server ("172.16.0.1" in this example), click "Add" button</li>
              <li>Click ok, right-click on the domain ("dc.mydomain.com" in this example), go to "All Tasks" and click "Restart"</li>
            </ol>
          </li>
          <li>Try to ping "www.google.ca" and then try to ping the domain we created earlier ("mydomain.com" in this example)</li>
          <li>If there's a response from both, that means the network has been properly configured</li>
      </ol>
    </li>
    <li>Change hostname
      <ol>
        <li>Right-click start menu button & select "System" option</li>
        <li>Go all the way down & select "Rename this PC (advanced)"</li>
        <li>Click "Change..." button</li>
        <li>Change computer name to the name of the VM</li>
        <li>Under "Member of:", check the "Domain" option & type in the domain you created ("mydomain.com" in this example)</li>
        <li>Click ok</li>
        <li>Enter admin username & password (sometimes when creating your own user account, it will register it as the admin account)</li>
        <li>Click ok, click close & click "Restart Now"</li>
      </ol>
    </li>
    <li>While VM is restarting; 
      <ol>
        <li>Go back to DHCP settings on server machine (Server Manager app -> Tools -> DHCP)</li>
        <li>Drop down domain controller & IPv4, select "Scope" folder</li>
        <li>Select "Address Leases". When the client gets an address, it will appear in this section</li>
        <li>Go to Active Directory (start menu -> type "Active Directory" & select app)</li>
        <li>Click "Computers" folder. The client machine should show up here</li>
      </ol>
    </li>
    <li>Once VM has restarted, login with one of the users we created
      <ol>
        <li>Click on the "Other user" option located at the bottom left of the screen</li>
        <li>Enter any username we created & their respective password, press enter</li>
        <li>You can repeat these last 2 steps to login with all the other users on different VM sessions</li>
      </ol>
    </li>
  </ol>
</li>
</ol>

<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
