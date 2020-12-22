
import Foundation

struct CMPStaticList {
    static let identifier = "org.cocoapods.CMP"
    static let forResource = "cmp"
    static let ofType = "html"
    static let plist = "CmpSettings.plist"
}

final class OpenCmpSettings {
    
    var plistURL: URL {
        let documentDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectoryURL.appendingPathComponent(CMPStaticList.plist)
    }
    
    func savePropertyList(_ plist: Any) throws{
        let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try plistData.write(to: plistURL)
    }

    func loadPropertyList() throws -> [String:String] {
        let data = try Data(contentsOf: plistURL)
        guard let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:String] else {
            return [:]
        }
        return plist
    }
}
