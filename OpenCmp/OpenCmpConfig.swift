import Foundation


public struct OpenCmpConfig {
    
    let domen: String
    let setStorageName: String?
    let setErrorHandler: ((Error) -> (Void))!
    let setChangesListener: ((String) -> (Void))!
    
    public init(_ domen: String, setStorageName: String? = nil, setErrorHandler: @escaping (Error)->(Void), setChangesListener: @escaping(String)->(Void) ) {
        self.domen = domen
        self.setStorageName = setStorageName
        self.setErrorHandler =  { result in
            setErrorHandler(result)
        }
        
        self.setChangesListener = { result in
            setChangesListener(result)
        }
    }
    
}


