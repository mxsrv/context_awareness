# context_awareness

## Authorizations for the application 

The application requests authorization for your location and activity while it is running to determine your position on the map and your current activity. Apart from that the user can run the application as a background service to passively download and upload data. This process can be stopped by pressing on the application icon -> App-Details -> Force Stop 


## Getting Started

### For Developers  

#### Requirements

Before you begin, make sure that the following requirements are met:

* android-sdk version 28 with android-studio.
* working flutter installation (we tested with version 2.2.1).
* You either have a mobile device (at the moment only android is supported) connected to your workstation in debug mode or an android emulator setup.



#### How to run 

* clone the git-repository:

```bash
git clone https://github.com/mxsrv/context_awareness/
cd context_awareness
```

* get all flutter dependencies

```bash
flutter pub get
```

* start the application with flutter

```bash
flutter run
```

## License

This project's code is licensed under the [GNU General Public License version 3 (GPL-3.0-or-later)](LICENSE).
