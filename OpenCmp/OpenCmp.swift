import Foundation


public class OpenCmp {
    
    @available(iOS 9.0, *)
    public static func initialize(_ viewController: UIViewController,_ context: OpenCmpConfig) {
        if  let filePath = Bundle(identifier: CMPStaticList.identifier)?.path(forResource: CMPStaticList.forResource, ofType: CMPStaticList.ofType) {
            do {
                let jsContent = try String.init(contentsOfFile: filePath, encoding: String.Encoding.utf8)
                let web = WebPrezenterViewController()
                web.cmpSettings = context
                web.view.backgroundColor = .clear
                web.modalTransitionStyle = .crossDissolve
                web.modalPresentationStyle = .fullScreen
            }  catch let error as NSError{
                print(error.debugDescription)
            }
        }
    }
}
