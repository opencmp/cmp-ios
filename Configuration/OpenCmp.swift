//
//  OpenCmp.swift
//  CMP
//
//  Created by Роман Чугай on 30.11.2020.
//

import Foundation

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
