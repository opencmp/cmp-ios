import UIKit
import Foundation

protocol OpenCmpStore {
    func clear()
    func update(values: [String : Any]?)
    func getConsentString() -> String
}

public class UserDefaultsOpenCmpStore: OpenCmpStore {
    private let userDefaultsName: String?
    private let userDefaults: UserDefaults?
    private var observer: NSKeyValueObservation?
    var value:  [String : Any]? = [:]

    required init(userDefaultsType: String, cmpSettings: OpenCmpConfig) {
        self.userDefaultsName = userDefaultsType
        self.userDefaults = userDefaultsType == "" ? UserDefaults.standard : UserDefaults(suiteName: self.userDefaultsName)!
        observer = userDefaults?.observe(\.cmpSettings, options: [.initial, .new], changeHandler: { [self] (defaults, change) in
            guard let change = change.newValue else { return }
            value = change
            cmpSettings.setChangesListener(self)
        })
    }
    
    deinit {
        observer?.invalidate()
    }
    
    
//    func tester() {
//        update(values: ["fff": "sss"])
//        //userDefaults?.removeObject(forKey: CMPStaticList.cmpSettings)
//    }
    
    func clear() {
        userDefaults?.removeObject(forKey: CMPStaticList.cmpSettings)
    }
    
    
    func update(values: [String : Any]?) {
        guard let archivedData = values else { return }
        let convertData = NSKeyedArchiver.archivedData(withRootObject: archivedData)
        userDefaults?.set(convertData, forKey: CMPStaticList.cmpSettings)
    }
    
    func getConsentString() -> String {
        let data = userDefaults?.object(forKey: CMPStaticList.cmpSettings)
        guard let convert = data as? Data else { return "" }
        let dict = NSKeyedUnarchiver.unarchiveObject(with: convert)
        let jsonData = try! JSONSerialization.data(withJSONObject: dict ?? [], options: [])
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
        return jsonString
    }
}


private extension UserDefaults {
    @objc dynamic var cmpSettings: [String : Any]? {
        return dictionary(forKey: CMPStaticList.cmpSettings)
    }
}
