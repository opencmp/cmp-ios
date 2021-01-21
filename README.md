#Integration

##Struktur
Das Package enthaelt zwei Order:
- Example: Beispiel-Integration
- OpenCmp: Die CMP-Library, die in die App importiert werden muss
##Integration
Die Integration erfolgt in der AppDelegate Klasse:
```
let config = OpenCmpConfig(
    "domain.de",
    setErrorHandler: { result in
        print("Error", result)
    }, setChangesListener: { change in
        print("CMP change", change.value)
    })
//initialize framework
OpenCmp.initialize(config)
```
##Features
###Button fuer nachtraegliche Einstellungen
Damit der User nachtraeglich Einstellungen zum Consent anpassen kann, bietet das CMP eine Funktion an, um das Popup zu erzeugen:
```
OpenCmp.showUI()
```
###Zugriff auf Consent
Der Consent ist in den `UserDefaults.standard` gespeichert und kann direkt von dort gelesen und auch auf Aenderungen reagiert werden.
Die im Consent enthaltenen Key-Value-Paare entnehmen Sie bitte der Spezifikation der IAB:
https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#how-is-a-cmp-used-in-app 
