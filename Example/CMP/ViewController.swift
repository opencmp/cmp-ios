
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
        let context = OpenCmpContext(domen: "jsContent", key: "key")
        OpenCmp.config.activateWithContext(context: context)
    }

}


