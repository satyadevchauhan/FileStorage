//
//  FileStorage.swift
//  FileStorage
//
//  Created by Satyadev on 18/10/18.
//  Copyright © 2018 Satyadev Chauhan. All rights reserved.
//

import Foundation

class FileStorage {
    
    static let shared = FileStorage()
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let baseFolderPath = FileStorage.DocumentsDirectory.appendingPathComponent("FileStorage".md5)
    
    let fileManager = FileManager.default
    
    init() {
        
    }
    
    public func getPath(_ path: String) -> URL {
        let fileName = String(path.md5)
        return FileStorage.baseFolderPath.appendingPathComponent(fileName)
    }
    
    /// Write data for key.
    @discardableResult public func write(data: Data, forKey: String) -> Bool {
        
        if fileManager.fileExists(atPath: FileStorage.baseFolderPath.path) == false {
            do {
                try self.fileManager.createDirectory(at: FileStorage.baseFolderPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error while creating base folder")
            }
        }
        
        let filePath = self.getPath(forKey).path
        // Encryption
        let encryptedData = data.encrypt(filePath)
        return self.fileManager.createFile(atPath: filePath, contents: encryptedData, attributes: nil)
    }
    
    /// Read data for key.
    public func readData(_ forKey: String) -> Data? {
        
        let filePath = self.getPath(forKey).path
        
        if (fileManager.fileExists(atPath: filePath)) {
            
            // Decryption
            if let encryptedData = fileManager.contents(atPath: filePath) {
                return encryptedData.decrypt(filePath)
            } else {
                return nil
            }
            
        } else {
            return nil
        }
    }
    
}

// MARK: Read & Write utils
extension FileStorage {
    
    // MARK: NSCoding
    
    /// Set an object for key. This object must inherit from `NSObject` and implement `NSCoding` protocol. `String`, `Array`, `Dictionary` conform to this method.
    @discardableResult public func setObject(_ object: NSCoding, forKey: String) -> Bool {
        
        //deprecated in iOS 11
        //let data = NSKeyedArchiver.archivedData(withRootObject: object)
        //return write(data: data, forKey: forKey)
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: true)
            return write(data: data, forKey: forKey)
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    /// Read an object for key. This object must inherit from `NSObject` and implement NSCoding protocol. `String`, `Array`, `Dictionary` conform to this method
    public func getObject(_ forKey: String) -> NSObject? {
        let data = readData(forKey)
        
        if let data = data {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? NSObject
        }
        
        return nil
    }
    
    // MARK: Codable
    
    /// Set an object for key. This object must inherit from `NSObject` and implement `Codable` protocol.
    @discardableResult public func setObject<T: Encodable>(_ object: T, forKey: String) -> Bool {
        do {
            let data = try PropertyListEncoder().encode(object)
            return write(data: data, forKey: forKey)
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    /// Get an object for key. This object must inherit from `NSObject` and implement NSCoding protocol. `String`, `Array`, `Dictionary` conform to this method
    public func getObject<T: Decodable>(_ forKey: String, as type: T.Type) -> T? {
        if let data = readData(forKey) {
            do {
                let objectT = try PropertyListDecoder().decode(type, from: data)
                return objectT
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        
        return nil
    }
}

// MARK: Remove
extension FileStorage {
    
    /// Remove data by key
    public func removeObject(forKey: String) {
        do {
            let filePath = self.getPath(forKey).path
            try fileManager.removeItem(atPath: filePath)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Remove all data
    public func removeAll() {
        do {
            try self.fileManager.removeItem(atPath: FileStorage.baseFolderPath.path)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: Utilities
extension FileStorage {
    
    /// -objectForKey:
    func object(forKey defaultName: String) -> Any? {
        return getObject(defaultName)
    }
    
    /// -stringForKey:
    func string(forKey defaultName: String) -> String? {
        return getObject(defaultName) as? String
    }
    
    /// -stringArrayForKey:
    func stringArray(forKey defaultName: String) -> [String]? {
        return getObject(defaultName) as? [String]
    }
    
    /// -arrayForKey:
    func array(forKey defaultName: String) -> [Any]? {
        return getObject(defaultName) as? [Any]
    }
    
    /// -dictionaryForKey:
    func dictionary(forKey defaultName: String) -> [String : Any]? {
        return getObject(defaultName) as? [String : Any]
    }
    
    /// -dataForKey:
    func data(forKey defaultName: String) -> Data? {
        return getObject(defaultName) as? Data
    }
    
    /// -integerForKey:
    func integer(forKey defaultName: String) -> Int {
        return getObject(defaultName) as! Int
    }
    
    /// -floatForKey:
    func float(forKey defaultName: String) -> Float {
        return getObject(defaultName) as! Float
    }
    
    /// -doubleForKey:
    func double(forKey defaultName: String) -> Double {
        return getObject(defaultName) as! Double
    }
    
    /// -boolForKey:
    func bool(forKey defaultName: String) -> Bool {
        return getObject(defaultName) as! Bool
    }
    
    /// -dateForKey:
    func date(forKey defaultName: String) -> NSDate? {
        return getObject(defaultName) as? NSDate
    }
    
    
    /// -setObject:ForKey:
    func set(_ value: Any?, forKey defaultName: String) {
        setObject(value as! NSCoding, forKey: defaultName)
    }
    
    /// -setString:ForKey:
    func set(_ value: String, forKey defaultName: String) {
        setObject(NSString(string: value), forKey: defaultName)
    }
    
    /// -setInt:ForKey:
    func set(_ value: Int, forKey defaultName: String) {
        setObject(NSNumber(value: value), forKey: defaultName)
    }
    
    /// -setFloat:ForKey:
    func set(_ value: Float, forKey defaultName: String) {
        setObject(NSNumber(value: value), forKey: defaultName)
    }
    
    /// -setDouble:ForKey:
    func set(_ value: Double, forKey defaultName: String) {
        setObject(NSNumber(value: value), forKey: defaultName)
    }
    
    /// -setBool:ForKey:
    func set(_ value: Bool, forKey defaultName: String) {
        setObject(NSNumber(value: value), forKey: defaultName)
    }
    
    /// -setDate:ForKey:
    func set(_ value: NSDate, forKey defaultName: String) {
        setObject(value, forKey: defaultName)
    }
}
