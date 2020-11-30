//
//  OpenCmpContex.swift
//  CMP
//
//  Created by Роман Чугай on 30.11.2020.
//

import Foundation


public struct OpenCmpContext {
    
    let domen: String
    let key_registration: String

    public init(domen: String, key: String) {
        self.domen = domen
        self.key_registration = key
    }
    
}

public class OpenCmp {
    
    public static let config = OpenCmp()
    private init() {}

    @available(iOS 9.0, *)
    public func activateWithContext(context: OpenCmpContext) {
        let web = WebPrezenterViewController()
        web.request = context.domen
        web.view.backgroundColor = .clear
        web.modalTransitionStyle = .crossDissolve
        web.modalPresentationStyle = .fullScreen
    }
}
