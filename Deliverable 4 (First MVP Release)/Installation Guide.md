# Usage guide for developers and users
*Note: Local development and testing was done on Windows machines for android devices only.*

## Developers

### Dependancies
* Android Studio
* Flutter SDK 
* Android Emulator
* Java SDK(for apk compilation)

### Android
1. download flutter sdk from flutter.dev
2. update enviornment variable PATH with path to the flutter\bin folder.
3. resolve any issues when typing flutter doctor into the cli on Windows.
4. install android studio
5. install android sdk via android studio
6. configure an android emulator via android studio using the avd manager(android studio->tools->avd manager and create virtual device). note: android emulator will require a hypervisor. If using Hyper-V, make sure it's enabled in features on Win10 and in the bios, otherwise you can use Intel HAXM if available.
7. import the project into android studio. 
8. type flutter pub get into the cli to resolve packages.
9. run project solution on emulator(make sure emulator is already setup)

## Users
### Android
1. if on windows(no mobile phone), download an android emulator for pc. Common ones are: bluestacks, and nox(you may need to consult external guides).
1. download the [.apk](https://github.com/Decafoats/FireForceRepository/blob/master/Deliverable%204%20(First%20MVP%20Release)/app-release.apk) file that should be distributed with the project.
2. import the .apk file into your android device or emulator(you may need to consult external guides).
3. when importing, you may need to resolve any security issues for android devices(allow permission).
4. launch the application by clicking on it.
