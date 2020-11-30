//
//  UiViewControllerPresenter.swift
//  CMP
//
//  Created by Роман Чугай on 12.11.2020.
//

import Foundation
import AVKit


@available(iOS 9.0, *)
public extension UIViewController {
    
    @objc func present(completion: (() -> Void)? = nil) {
        if let url = URL(string: ConstantList.baseUrl) {
            let urlRequest = URLRequest(url: url)
            let web = WebPrezenterViewController()
            web.request = urlRequest
            web.modalPresentationStyle = .fullScreen
            present(web, animated: true, completion: completion)
        }
    }
    @objc func info() {
        var status: [String: String] = [:]
        for item in PermissionType.allCases {
            status[item.rawValue] = item.allAtatus()
        }
        print(status)
//        if let fileUrl = Bundle.main.infoDictionary?.keys {
//            print(Bundle.main.infoDictionary)
//            let uuur = fileUrl.filter  { $0.contains("UsageDescription") }
//
//
//        }
        
    }
}
