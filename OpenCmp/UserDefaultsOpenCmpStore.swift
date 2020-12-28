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
    public var value: [String : Any]? = [:]

    required init(userDefaultsType: String, cmpSettings: OpenCmpConfig) {
        self.userDefaultsName = userDefaultsType
        self.userDefaults = userDefaultsType == "" ? UserDefaults.standard : UserDefaults(suiteName: self.userDefaultsName)!
       
        observer = userDefaults?.observe(\.cmpSettings, options: [ .new], changeHandler: { [self] (defaults, change) in
            guard let change = change.newValue else { return }
            guard let dict = NSKeyedUnarchiver.unarchiveObject(with: change) as? [String : Any]? else { return }
            value = dict
            cmpSettings.setChangesListener(self)
        })
    }
    
    deinit {
        observer?.invalidate()
    }
    
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
    @objc dynamic var cmpSettings: Data {
        return data(forKey: CMPStaticList.cmpSettings)!
    }
}
