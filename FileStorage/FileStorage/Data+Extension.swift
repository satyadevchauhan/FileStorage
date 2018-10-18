//
//  Data+Extension.swift
//  FileStorage
//
//  Created by Satyadev on 18/10/18.
//  Copyright © 2018 Satyadev Chauhan. All rights reserved.
//

import UIKit
import RNCryptor

extension Data {
    
    public func encrypt(_ password: String) -> Data {
        return RNCryptor.encrypt(data: self, withPassword: password)
    }
    
    public func decrypt(_ password: String) -> Data? {
        do {
            return try RNCryptor.decrypt(data: self, withPassword: password)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
