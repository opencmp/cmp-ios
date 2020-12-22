import UIKit

protocol OpenCmpStore {
    func clear()
    func update(values: NSDictionary)
    func getConsentString() -> String
}

public class UserDefaultsOpenCmpStore: OpenCmpStore {
    func clear() {
        
    }
    
    func update(values: NSDictionary) {
        
    }
    
    func getConsentString() -> String {
        return ""
    }
    

}

