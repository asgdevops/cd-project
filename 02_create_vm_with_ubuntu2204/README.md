# :book: Create a new Ubuntu 22.04 Virtual Machine in VirtualBox
By [Antonio Salazar](mailto:antonio.salazar@ymail.com) - September 2022

**Document log**
|Date|Description|
|:--:|--|
|2022-09|Inicial creation. Steps with screen-shots only.|
|2023-01| Added sections: Document log, Work Sumary, Requisites, and References|

# Work summary
- Set up a new Virtual Machine with Ubuntu 22.04 Server Installed.

# Requisites
- Install [Oracle VM VirtualBox Manager](https://www.virtualbox.org/manual/UserManual.html#intro-installing) on your laptop, personal computer, or workstation.

# :paw_prints: Steps

1. Download the Ubuntu 22.04 Server ISO image from the [Ubuntu 22.04 Releases](https://releases.ubuntu.com/22.04/) page.
2. Open Oracle VM VirtualBox manager.
3. Select the **New** *(Ctrl+N) Machine* menu option.
    
    ![ubuntu2204](images/ubuntu2204.png)
    
4. Set the Virtual Machine Name, Files Location, OS Type and Version.
    
    ![ubuntu2204](images/ubuntu2204_1.png)
    
5. **Hard Disk**: Create a virtual hard disk now.
    
    ![ubuntu2204](images/ubuntu2204_2.png)
    
6. **Hard disk file type**: VDI (VirtualBox Disk Image)
    
    ![ubuntu2204](images/ubuntu2204_3.png)
    
7. **Storage on physical hard disk**: Dynamically allocated.
    
    ![ubuntu2204](images/ubuntu2204_4.png)
    
8. **File location and size**: location of your best choice, recommended size 20 GB at least.
    
    ![ubuntu2204](images/ubuntu2204_5.png)
    
9. Click on **Properties**.
    
    ![ubuntu2204](images/ubuntu2204_6.png)
    
10. Go to **Storage, Optical Drive** and pick the **ubuntu-20.04.4-live-server-amd64.iso** file.
    
    ![ubuntu2204](images/ubuntu2204_7.png)
    
11. Go to **Network** and set the parameter below:
    1. **Enable Network Adapter**: check. 
    2. **Attached to**: Bridged Adapter.
    3. **Name**: Your available network device name.
    4. **Advanced**: expand.
    5. **Cable connected**: check.
    
    ![ubuntu2204](images/ubuntu2204_8.png)
    
12. Click on **Start.**

    ![ubuntu2204](images/ubuntu2204_8a.png)
    
13. Select your preferred language for the installation process.
    
    ![ubuntu2204](images/ubuntu2204_9.png)
    
14. Choose **Install Ubuntu Server**.
    
    ![ubuntu2204](images/ubuntu2204_10.png)
    
15. Select the preferred language one more time.
    
    ![ubuntu2204](images/ubuntu2204_11.png)
    
16. **Continue without updating**.
    
    ![ubuntu2204](images/ubuntu2204_12.png)
    
17. **Done**: once the keyboard layout satisfied your needs.
    
    ![ubuntu2204](images/ubuntu2204_13.png)
    
18. **Done**: leave the DHCP and default network device as is.
    
    ![ubuntu2204](images/ubuntu2204_14.png)
    
19. **Done**: leave proxy access defaults.
    
    ![ubuntu2204](images/ubuntu2204_15.png)
    
20. **Done**: leave Mirror address defaults.
    
    ![ubuntu2204](images/ubuntu2204_16.png)
    
21. **Done**: Leave default partitions defaults.
    
    ![ubuntu2204](images/ubuntu2204_17.png)
    
22. **Continue**: to confirm the partition is correct.
    
    ![ubuntu2204](images/ubuntu2204_18.png)
    
23. Set the system administrator name, server’s name, username and password.
    
    ![ubuntu2204](images/ubuntu2204_19.png)
    
24. Done: leave Ubuntu’s token defaults.
    
    ![ubuntu2204](images/ubuntu2204_20.png)
    
25. **Install OpenSSH Server**: check this option and select Done.
    
    ![ubuntu2204](images/ubuntu2204_21.png)
    
26. **Done**: leave the packages installation for later.
    
    ![ubuntu2204](images/ubuntu2204_22.png)
    
27. The installation process starts, so wait until it gets completed.
    
    ![ubuntu2204](images/ubuntu2204_23.png)
    
28. You may check the logs (View full log) for details about the installation process.
    
    ![ubuntu2204](images/ubuntu2204_24.png)
    
29. **Close**: when completed.
    
    ![ubuntu2204](images/ubuntu2204_25.png)
    
30. **Reboot now**.
    
    ![ubuntu2204](images/ubuntu2204_26.png)
    
31. Login in with your administrator’s account to verify everything is working fine.
    
    ![ubuntu2204](images/ubuntu2204_27.png)
    
32. Upgrade and install all of the packages you need to work on your new ubuntu server.

<br/>

# :books: References
- [:copyright: Canonical ubuntu Server - Basic installation](https://ubuntu.com/server/docs/installation)