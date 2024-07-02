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

<h2>Lab walk-through:</h2>
<ol>
  <h3><b>PART 1 - SETUP ENVIRONMENT</b></h3><br/>
  <li><b>Install Oracle VM VirtualBox</b>
    <ol>
      <li>Go to https://www.virtualbox.org/wiki/Downloads</li>
      <li>Download most recent package (click on the appropriate platform) & install</li>
      <li>Once completed, download VirtualBox Extension Pack & install</li>
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
 
 <li><b>Setup Windows 10 VM</b>
   <ol>
     <li>Open VirtualBox application, click on “New” button</li>
     <li>Pick Windows 10 disk as the ISO image, choose a name & destination folder for the VM</li>
     <li>Write a username & password (remember for later), as well as a hostname, then pick its hardware settings</li>
     <li><b>**FIX ISSUE “Windows cannot read the product key setting from the unattended answer file”</b>
       <ol>
         <li>Go to settings -> system -> motherboard tab, unselect “floppy” in the boot order</li>
         <li>Go to settings -> general -> advanced tab, you can see your virtual machine folder path</li>
         <li>Go to file explorer where the virtual machine folder is, and remove disk file “unattended” (there will be a long string of random characters following it)</li>
         <li>Ignore “Virtual Machine ran into a fatal problem” error message & set up as normal</li>
       </ol>
     </li>
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
        <li>Identify the two networks as Internet (10.0.2.15) & internal (169.254.196.79) networks</li>
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

<li><b>Create Users from PowerShell commands in Active Directory</b>
  <ol>
    <li>Go to Server Manager Dashboard, click “Configure this local server”</li>
    <li>Go to “IE Enhanced Security Configuration” setting & turn it off for admins & users, click ok</li>
    <li>Copy over PowerShell script files from internet, or write the script yourself</li>
    <li>Click Start menu icon, click Windows PowerShell folder & right-click “Windows PowerShell ISE”</li>
    <li>Go to “more”, click “Run as Administrator” & click “Yes”</li>
    <li>Click second to left top folder icon “Open Script”, select script & click “Open”</li>
  </ol>
</li>
<br />
<br />

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
