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


