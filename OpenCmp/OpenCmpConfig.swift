import Foundation


public struct OpenCmpConfig {
    
    var domen: String
    let storageName: String?
    let errorHandler: ((String) -> (Void))?
    let consentChangesListener: ((UserDefaultsOpenCmpStore) -> (Void))?
    
    public init(_ domen: String, setStorageName: String? = nil, setErrorHandler: @escaping (String)->(Void), setChangesListener: @escaping(UserDefaultsOpenCmpStore)->(Void) ) {
        
        self.domen = domen
        self.storageName = setStorageName
        self.errorHandler =  { result in
            setErrorHandler(result)
        }
        self.consentChangesListener = { result in
            setChangesListener(result)
        }
    }
    
}


