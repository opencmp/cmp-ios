//
//  OpenCmp.swift
//  CMP
//
//  Created by Роман Чугай on 30.11.2020.
//

import Foundation

struct CMPStaticList {
    static let identifier = "org.cocoapods.CMP"
    static let forResource = "cmp"
    static let ofType = "html"
}
public class OpenCmp {
    
    public static let config = OpenCmp()
    private init() {}
    
    @available(iOS 9.0, *)
    public func activateWithContext(context: OpenCmpContext) {
        if  let filePath = Bundle(identifier: CMPStaticList.identifier)?.path(forResource: CMPStaticList.forResource, ofType: CMPStaticList.ofType) {
            do {
                let jsContent = try String.init(contentsOfFile: filePath, encoding: String.Encoding.utf8)
                let web = WebPrezenterViewController()
                web.request = jsContent
                web.view.backgroundColor = .clear
                web.modalTransitionStyle = .crossDissolve
                web.modalPresentationStyle = .fullScreen
            }  catch let error as NSError{
                print(error.debugDescription)
            }
        }
    }
}
