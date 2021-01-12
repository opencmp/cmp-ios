
import CMP
import UIKit

class ViewController: UIViewController {
//in your class or AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        //creating config with domain, storageName, errorHandler and data changeListener
        let config = OpenCmpConfig(
            "traffective.com",
            setStorageName: "open_cmp.storage",
            setErrorHandler: { result in
                print("Error", result)
            }, setChangesListener: { change in
                print("CMP change", change.value)
            })
        //initialize framework
        OpenCmp.initialize(self, config)
    }

    @IBAction func showPopup(_ sender: Any) {
        //show UI
        OpenCmp.showUI()

    }
    @IBAction func cleanData(_ sender: Any) {
        //clear saved data
        OpenCmp.cleanUserDefaults()
    }
    
}
