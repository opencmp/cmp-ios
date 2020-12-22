import UIKit

protocol OpenCmpStore {
    func clear()
    func update(values: NSDictionary)
    func getConsentString() -> String
}

public class UserDefaultsOpenCmpStore: OpenCmpStore {
    let userDefaultsType: String?
    private let userDefaults: UserDefaults
    
    init(userDefaultsType: String) {
        self.userDefaultsType = userDefaultsType
        self.userDefaults = userDefaultsType == "" ? UserDefaults.standard : UserDefaults(suiteName: self.userDefaultsType)!
    }
    
    func clear() {
        userDefaults.removeObject(forKey: CMPStaticList.identifier)
    }
    
    func update(values: NSDictionary) {
        userDefaults.set(values, forKey: CMPStaticList.identifier)
    }
    
    func getConsentString() -> String {
        let dict = userDefaults.object(forKey: CMPStaticList.identifier)
        let jsonData = try! JSONSerialization.data(withJSONObject: dict ?? [], options: [])
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
        return jsonString
    }
    

}

