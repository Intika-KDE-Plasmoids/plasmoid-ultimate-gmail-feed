Ultimate Gmail Feed v2.1 
========================

https://www.opendesktop.org/p/1248550/

Ultimate Gmail Feed is a plasmoid for Plasma 5. It provides a list of your unread emails from your Gmail inbox. You also get notified when you receive new messages.

Features:
- Multi account
- Editable Transfert Protocol 
- Editable RSS Server 
- Editable RSS Server Query
- Command to open email application (Application or Browser Link)
- Command to open email (Application or Browser Link)
- Automatic polling interval
- Offline Secure Mode (Checking email only manually)
- Multiline Display
- Editable Height Popup Scroll View
- Editable Width Popup Scroll View
- And much more...

Any donations are welcome to : paypal : intika.dev@gmail.com thanks ^^ 

This plasmoid is designed to work with RSS Feeds Mails, you can use it with providers other than gmail by changing the configuration

This plasmoid is based on "Gmail Feed" from anthon38, Big thanks to anthon38 for his work

**Install:**

Check the released RPM
https://www.opendesktop.org/p/1248550

**Build & Install:**

    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DLIB_INSTALL_DIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
    make
    make install

![screenshot](https://i.imgur.com/kqD5uxQ.png)
![screenshot](http://i.imgur.com/uH3LwNA.png)

**Build/Update Distribution:**

- Install rpm source
- Edit spec & extract/edit sources
- "tar -xvf ultimategmailfeed-2.1.tar.gz"
- Edit sources
- tar -zcvf ultimategmailfeed-2.1.tar.gz ultimategmailfeed-2.1
- rpmbuild -ba plasma-applet-ultimategmailfeed.spec
- alien -d plasma-applet-ultimategmailfeed-2.1-1.mga6.x86_64.rpm
- Warning do it all with su... to avoid chown root:root 
- Unpack unbuntu package "dpkg-deb -R ./ultimategmailfeed-v2.1-alien-amd64.deb ./ugm"
- notepadqq ugm/DEBIAN/control "(Converted from a rpm package by alien version 8.95. & manually edited by intika)"
- notepadqq ugm/DEBIAN/md5sums 
- replace "usr/lib64" with "usr/lib/x86_64-linux-gnu"  
- mv ugm/usr/lib64/ ugm/usr/x86_64-linux-gnu
- mkdir ugm/usr/lib
- mv ugm/usr/x86_64-linux-gnu ugm/usr/lib/
- dpkg-deb -b ./ugm ultimategmailfeed-v2.1-debian-ubuntu-amd64.deb
