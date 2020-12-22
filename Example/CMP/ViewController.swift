
import UIKit
import CMP


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func testAction(_ sender: Any) {
        testWithHtmlFile()
    }
    
    
    func testWithHtmlFile() {
        let context = OpenCmpConfig("traffective.com", setErrorHandler: { result in
            print(result)
        }, setChangesListener: { value in
           print(value)
        })
        OpenCmp.initialize(self, context)
    }

}


