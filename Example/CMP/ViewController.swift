
import CMP
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func testAction(_ sender: Any) {
        let config = OpenCmpConfig(
            "traffective.com",
            setStorageName: "open_cmp.storage",
            setErrorHandler: { result in
                print(result)
            }, setChangesListener: { value in
                print(value)
            })
        
        OpenCmp.initialize(self, config)
    }

    
}
