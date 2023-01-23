# :book: Set up a Static IP Address

By [Antonio Salazar](mailto:antonio.salazar@ymail.com) - January 2023

# Description
Sometimes it is necessary to set up the virtual machine IP addresses as static. Depending on the project, this could be very useful.

This document shows how to set up the Static IP Address for the Ubuntu 22.04 server and the CentOS 7 minimal.

# Work summary
- Set up a new IP static address on a virtual machine.

# Requisites
- Install [Oracle VM VirtualBox Manager](https://www.virtualbox.org/manual/UserManual.html#intro-installing) on your laptop, personal computer, or workstation.
- Set up a new Virtual Machine
  - [Create a new CentOS 7 Virtual Machine in VirtualBox](../vm/centos7/README)
  - [Create a new Ubuntu 22.04 Virtual Machine in VirtualBox](../vm/ubuntu2204/README)
- Power On the Virtual Machine.


# :paw_prints: Steps

1. Login to the VM with the admin user.
2. Switch to root `sudo su - # [ENTER]`
3. Set up your variables with the network values.

    ```bash
    NIC=`ip -o -4 a | grep -v 127.0.0.1 | awk '{print $2}'`
    IP=10.7.2.10
    CIDR="${IP}/24"
    PRIMARY=8.8.8.8
    SECONDARY=8.8.4.4
    GATEWAY=10.7.2.1
    UUID=`uuidgen $NIC`
    ```
  
    Where the values mean:

    |Variable | Description|
    |--|--|
    |NIC| VM network interface card|
    |IP| new static IP address|
    |CIDR| CIDR block. (in this example **Class C** type)|
    |PRIMARY| primary DNS IP Address by Google (free) |
    |SECONDARY| secondary DNS IP Address by Google (free) |
    |GATEWAY| virtual network gateway IP address|
    |UUID| Universal Unique Identifier for the network interface card|

_Click [here](#on-centos-7-minimal) to continue working on [CentOS 7 minimal](#on-centos-7-minimal)._

# On Ubuntu 22.04 Server 

4. Backup the current netplan configuration file `/etc/netplan/00-installer-config.yaml`.

    ```bash
    cp -p /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bak
    ```

5. Create the new netplan configuration file `/etc/netplan/00-installer-config.yaml` with the new values.

    ```bash
    tee /etc/netplan/00-installer-config.yaml<<EOF
    network:
      renderer: networkd
      ethernets:
        ${NIC}:
          addresses:
            - $CIDR
          nameservers:
            addresses: [$PRIMARY, $SECONDARY]
          routes:
            - to: default
              via: $GATEWAY
      version: 2
    EOF 
    ```

6. Apply the changes.

    ```bash
    netplan apply
    ```
7. [Verify the new settings](#verify-the-new-settings)


<br/>

# On CentOS 7 minimal
4. Backup the NIC configuration file

    ```bash
    cp -p /etc/sysconfig/network-scripts/ifcfg-$NIC /etc/sysconfig/network-scripts/ifcfg-$NIC.bak
    ```

5. Create the newconfiguration file `/etc/sysconfig/network-scripts/ifcfg-$NIC` with the new values.

    ```bash
    tee /etc/sysconfig/network-scripts/ifcfg-$NIC<<EOF
    TYPE=Ethernet
    BOOTPROTO=none
    IPADDR=$IP
    GATEWAY=$GATEWAY
    DNS1=$PRIMARY
    DNS2=$SECONDARY
    DEFROUTE=yes
    IPV4_FAILURE_FATAL=no
    IPV6INIT=no
    NAME=$NIC
    UUID=$UUID
    DEVICE=$NIC
    ONBOOT=yes
    EOF 
    ```

6. Re-start the network service

    ```bash
    systemctl restart network
    ```

<br/>


# Verify the new settings

```bash
# Show NIC settings
ip a s $NIC

# Show route settings
ip r

# Show all IP addresses
ip -o -4 a
```

<br/>

# :books: References
- [:copyright: Canonical Ubuntu Server - Network Configuration](https://ubuntu.com/server/docs/network-configuration)