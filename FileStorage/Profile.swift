//
//  Profile.swift
//  FileStorage
//
//  Created by Satyadev on 18/10/18.
//  Copyright © 2018 Satyadev Chauhan. All rights reserved.
//

import UIKit

class Profile: NSObject, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var name: String?
    var age: Int?
    
    enum CodingKeys: String {
        case name
        case age
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: CodingKeys.name.rawValue)
        aCoder.encode(age, forKey: CodingKeys.age.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: CodingKeys.name.rawValue) as? String
        age = aDecoder.decodeObject(forKey: CodingKeys.age.rawValue) as? Int
    }
}
