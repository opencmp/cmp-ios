import Foundation

@available(iOS 9.0, *)
public class OpenCmp {
    
    public static func initialize(_ viewController: UIViewController,_ context: OpenCmpConfig) {
        if  let filePath = Bundle(identifier: CMPStaticList.identifier)?.path(forResource: CMPStaticList.forResource, ofType: CMPStaticList.ofType) {
            do {
                let jsContent = try String.init(contentsOfFile: filePath, encoding: String.Encoding.utf8)
                let web = WebPrezenterShared.shared
                web.cmpSettings = context
                web.cmpSettings.domen = jsContent.replacingOccurrences(of: CMPStaticList.domain, with: context.domen)
                web.userDefaultSettings = UserDefaultsOpenCmpStore(userDefaultsType: context.storageName ?? "", cmpSettings: context)
                web.view.backgroundColor = .clear
                web.modalTransitionStyle = .crossDissolve
                web.modalPresentationStyle = .fullScreen
            }  catch let error as NSError{
                let err: Error = CmpError.loadingHtml(errorDescription: error.debugDescription)
                CmpErrorReader.shared.handleError(err)
            }
        }
    }
    
    public static func showUI() {
        WebPrezenterShared.shared.showUI()
    }
    
    public static func cleanUserDefaults() {
        WebPrezenterShared.shared.clean()
    }
}

@available(iOS 9.0, *)
class WebPrezenterShared {
    static let shared = WebPrezenterViewController()
    private init() {}
}


