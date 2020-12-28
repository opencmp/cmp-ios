
import CMP
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = OpenCmpConfig(
            "traffective.com",
            setStorageName: "open_cmp.storage",
            setErrorHandler: { result in
                print(result)
            }, setChangesListener: { chamge in
                print("value", chamge.value)
            })
        OpenCmp.initialize(self, config)
        
    }

    @IBAction func showPopup(_ sender: Any) {
        OpenCmp.showUI()

    }
    @IBAction func cleanData(_ sender: Any) {
        OpenCmp.cleanUserDefaults()
    }
    
}
