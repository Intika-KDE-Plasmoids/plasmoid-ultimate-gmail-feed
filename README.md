Ultimate Gmail Feed v1.6
========================

Ultimate Gmail Feed is a plasmoid for Plasma 5. It provides a list of your unread emails from your Gmail inbox. You also get notified when you receive new messages.

Features :
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

Any donations are welcome to : paypal : intika.dev@gmail.com thanks ^^ 

This plasmoid is designed to work with RSS Feeds Mails, you can use it with providers other than gmail by changing the configuration

This plasmoid is based on "Gmail Feed" from anthon38, Big thanks to anthon38 for his work

**Install :**

Check the released RPM
https://www.opendesktop.org/p/1248550

**Build & Install :**

    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DLIB_INSTALL_DIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
    make
    make install

![screenshot](https://i.imgur.com/kqD5uxQ.png)
![screenshot](http://i.imgur.com/uH3LwNA.png)
