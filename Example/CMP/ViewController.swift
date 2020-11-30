//
//  ViewController.swift
//  CMP
//
//  Created by Kovtun Dmitriy on 11/12/2020.
//  Copyright (c) 2020 Kovtun Dmitriy. All rights reserved.
//

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
        let filePath = Bundle.main.path(forResource: "cmp", ofType: "html")
        do {
            let jsContent = try String.init(contentsOfFile: filePath!, encoding: String.Encoding.utf8)
            let context = OpenCmpContext(domen: jsContent, key: "key")
            OpenCmp.config.activateWithContext(context: context)
        }
        catch let error as NSError{
            print(error.debugDescription)
        }
    }


}


