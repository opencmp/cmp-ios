
import Foundation
import AVKit
import Photos
import LocalAuthentication
import Contacts
import EventKit
import MediaPlayer
import CoreMotion
import Speech
import Intents
import CoreBluetooth
import CoreNFC
import HealthKit


enum StatusString: String {
    case authorized
    case denied
    case notDetermined
    case restricted
    case limited
    case authorizedAlways
    case authorizedWhenInUse
}

enum PermissionType: String, CaseIterable {
    
    case NSPhotoLibraryAddUsageDescription    //Your app adds photos to the user's photo library
    case NSPhotoLibraryUsageDescription    //Your app accesses the user's photo library
    case NSCameraUsageDescription    //Your app uses the device camera
    
    case NSLocationAlwaysUsageDescription    //Your app uses location services all the time
    case NSLocationWhenInUseUsageDescription   // Your app uses location services only when the app is running
    
    case NSContactsUsageDescription    //Your app uses the address book
    case NSCalendarsUsageDescription    //Your app uses or modifies the user's calendar information
    case NSRemindersUsageDescription    //Your app creates reminders in the Reminders app
    case NSHealthShareUsageDescription    //Your app uses data from the Health app
    case NFCReaderUsageDescription    //Your app uses the NFC reader
    case NSBluetoothPeripheralUsageDescription   // Your app works with Bluetooth devices
    case NSMicrophoneUsageDescription    //Your app uses the device microphone
    case NSSiriUsageDescription    //Your app provides a SiriKit Intent
    case NSSpeechRecognitionUsageDescription    //Your app uses speech recognition
    case NSMotionUsageDescription    //Your app uses the device motion tracking hardware

    case NSAppleMusicUsageDescription   // Your app uses Apple Music integration
    case NSFaceIDUsageDescription    //Your app uses FaceID

    
    func allAtatus() -> String {
        switch self {
        case .NSPhotoLibraryAddUsageDescription:
            return photoLibraryAddUsage()
        case .NSPhotoLibraryUsageDescription:
            return photoLibraryUsage()
        case .NSCameraUsageDescription:
            return cameraUsage()
        case .NSLocationAlwaysUsageDescription:
            return locationAlwaysUsage()
        case .NSLocationWhenInUseUsageDescription:
            return locationWhenInUseUsage()
        case .NSContactsUsageDescription:
            return contactsUsage()
        case .NSCalendarsUsageDescription:
            return calendarsUsage()
        case .NSHealthShareUsageDescription:
           return healthUpdate()
        case .NFCReaderUsageDescription:
            return readerUsage()
        case .NSBluetoothPeripheralUsageDescription:
            return bluetoothPeripheral()
        case .NSMicrophoneUsageDescription:
            return microphoneUsage()
        case .NSSiriUsageDescription:
            return siriUsage()
        case .NSSpeechRecognitionUsageDescription:
            return speechRecognition()
        case .NSRemindersUsageDescription:
            return remindersUsage()
        case . NSMotionUsageDescription:
            return motionUsageDescription()
        case .NSAppleMusicUsageDescription:
            return appleMusicUsage()
        case .NSFaceIDUsageDescription:
            return faceIDUsage()
        }
    }
     
    private func photoLibraryAddUsage() -> String {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            return StatusString.authorized.rawValue
        case.denied:
           return StatusString.denied.rawValue
        case .notDetermined:
            return StatusString.notDetermined.rawValue
        case .restricted:
            return StatusString.restricted.rawValue
        case .limited:
            return StatusString.restricted.rawValue
        }
    }
    
    private func photoLibraryUsage() -> String {
        return photoLibraryAddUsage()
    }
    
    private func cameraUsage() -> String {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return StatusString.authorized.rawValue
        case.denied:
            return StatusString.denied.rawValue
        case .notDetermined:
            return StatusString.notDetermined.rawValue
        case .restricted:
            return StatusString.restricted.rawValue
        }
    }
    
    private func locationAlwaysUsage() -> String {
        switch  CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            return StatusString.authorizedAlways.rawValue
        case .authorizedWhenInUse:
            return StatusString.authorizedWhenInUse.rawValue
        case .denied:
            return StatusString.denied.rawValue
        case .notDetermined:
            return StatusString.notDetermined.rawValue
        case .restricted:
            return StatusString.restricted.rawValue
        }
    }
    
    private func locationWhenInUseUsage() -> String {
        return locationAlwaysUsage()
    }
    
   
    private func contactsUsage() -> String {
        if #available(iOS 9.0, *) {
            switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized:
                return StatusString.authorized.rawValue
            case .denied:
                return StatusString.denied.rawValue
            case .restricted:
                return StatusString.restricted.rawValue
            case .notDetermined:
                return StatusString.notDetermined.rawValue
            }
        } else {
            return StatusString.notDetermined.rawValue
        }
    }
    
    private func calendarsUsage() -> String {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            return StatusString.authorized.rawValue
        case .denied:
            return StatusString.denied.rawValue
        case .restricted:
            return StatusString.restricted.rawValue
        case .notDetermined:
            return StatusString.notDetermined.rawValue
        }
    }
    
    private func healthUpdate() -> String {
        if HKHealthStore.isHealthDataAvailable() {
            return StatusString.authorized.rawValue
            
        } else {
            return StatusString.notDetermined.rawValue
        }
    }

    private func readerUsage() -> String {
        if #available(iOS 11.0, *) {
           if NFCNDEFReaderSession.readingAvailable {
            return StatusString.authorized.rawValue
           } else {
            return StatusString.denied.rawValue
           }
        } else {
            return StatusString.notDetermined.rawValue
        }
    }
    
    private func bluetoothPeripheral() -> String {
        switch CBPeripheralManager.authorizationStatus() {
        case .authorized:
            return StatusString.authorized.rawValue
        case .denied:
            return StatusString.denied.rawValue
        case .restricted:
            return StatusString.restricted.rawValue
        case .notDetermined:
            return StatusString.notDetermined.rawValue
        }
    }
    
    private func microphoneUsage() -> String {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized:
            return StatusString.authorized.rawValue
        case.denied:
            return StatusString.denied.rawValue
        case .notDetermined:
            return StatusString.notDetermined.rawValue
        case .restricted:
            return StatusString.restricted.rawValue
        }
    }

    //Siri siriAuthorizationStatus
    private func siriUsage() -> String {
        if #available(iOS 10.0, *) {
//            switch INPreferences.siriAuthorizationStatus() {
//            case .authorized:
//                return StatusString.authorized.rawValue
//            case .denied:
//                return StatusString.denied.rawValue
//            case .restricted:
//                return StatusString.restricted.rawValue
//            case .notDetermined:
                return StatusString.notDetermined.rawValue
//            }
        } else {
            return StatusString.notDetermined.rawValue
        }
    }
    
    //speechRecognition
    private func  speechRecognition() -> String {
        var result = ""
        result =  StatusString.authorized.rawValue
//        OperationQueue.main.addOperation {
//            if #available(iOS 10.0, *) {
//                SFSpeechRecognizer.requestAuthorization { authStatus in
//                    switch authStatus {
//                    case .authorized:
//                        result =  StatusString.authorized.rawValue
//                    case .denied:
//                        result = StatusString.denied.rawValue
//                    case .restricted:
//                        result = StatusString.restricted.rawValue
//                    case .notDetermined:
//                        result = StatusString.notDetermined.rawValue
//                    }
//                }
//            } else {
//                result = StatusString.notDetermined.rawValue
//            }
//        }
        return result
    }
    

    private func remindersUsage() -> String {
        switch EKEventStore.authorizationStatus(for: .reminder) {
        case .authorized:
            return StatusString.authorized.rawValue
        case .denied:
            return StatusString.denied.rawValue
        case .restricted:
            return StatusString.restricted.rawValue
        case .notDetermined:
            return StatusString.notDetermined.rawValue
        }
    }
    
    
    //motionUsageDescription
    private func motionUsageDescription() -> String {
        return StatusString.restricted.rawValue
//        switch AVCaptureDevice.authorizationStatus(for: .closedCaption) {
//        case .authorized:
//            return StatusString.authorized.rawValue
//        case.denied:
//            return StatusString.denied.rawValue
//        case .notDetermined:
//            return StatusString.notDetermined.rawValue
//        case .restricted:
//            return StatusString.restricted.rawValue
//        }
    }

    private func appleMusicUsage() -> String {
        if #available(iOS 9.3, *) {
            switch  MPMediaLibrary.authorizationStatus() {
            case .authorized:
                return StatusString.authorized.rawValue
            case .denied:
                return StatusString.denied.rawValue
            case .restricted:
                return StatusString.restricted.rawValue
            case .notDetermined:
                return StatusString.notDetermined.rawValue
            }
        } else {
            return StatusString.notDetermined.rawValue
        }
    }
    
    private func faceIDUsage() -> String {
        let myContext = LAContext()
        let myLocalizedReasonString = ""
        
        var authError: NSError?
        var status = ""
        if #available(iOS 8.0, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    if success {
                        status = StatusString.authorized.rawValue
                    } else {
                        status = StatusString.notDetermined.rawValue
                    }
                }
            }
        }
        return status
    }

}


