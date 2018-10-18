//
//  FileStorageTests.swift
//  FileStorageTests
//
//  Created by Satyadev on 18/10/18.
//  Copyright © 2018 Satyadev Chauhan. All rights reserved.
//

import XCTest
@testable import FileStorage

class FileStorageTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testBool() {
        
        let value1: Bool = true
        
        FileStorage.shared.set(value1, forKey: "Bool")
        let value2 = FileStorage.shared.bool(forKey: "Bool")
        
        XCTAssertEqual(value1, value2)
    }
    
    func testInt() {
        
        let value1: Int = 123456
        
        FileStorage.shared.set(value1, forKey: "Int")
        let value2 = FileStorage.shared.integer(forKey: "Int")
        
        XCTAssertEqual(value1, value2)
    }
    
    func testFloat() {
        
        let value1: Float = 12.34
        
        FileStorage.shared.set(value1, forKey: "Float")
        let value2 = FileStorage.shared.float(forKey: "Float")
        
        XCTAssertEqual(value1, value2)
    }
    
    func testDouble() {
        
        let value1: Double = 12.3456
        
        FileStorage.shared.set(value1, forKey: "Double")
        let value2 = FileStorage.shared.double(forKey: "Double")
        
        XCTAssertEqual(value1, value2)
    }
    
    func testString() {
        
        let value1: String = "Hello"
        
        FileStorage.shared.set(value1, forKey: "String")
        let value2 = FileStorage.shared.string(forKey: "String")
        
        XCTAssert(value1 == value2)
    }
    
    func testStringArray() {
        
        let value1: [String] = ["Hello", "World"]
        
        FileStorage.shared.set(value1, forKey: "StringArray")
        let value2 = FileStorage.shared.object(forKey: "StringArray") as? [String]
        
        XCTAssert(value1 == value2)
    }
    
    func testDictionary() {
        
        let value1: [String: String] = ["Name": "Peter", "Surname": "Parker"]
        
        FileStorage.shared.set(value1, forKey: "Dictionary")
        let value2 = FileStorage.shared.dictionary(forKey: "Dictionary") as? [String: String]
        
        XCTAssert(value1 == value2)
    }
    
    func testDictionaryHetro() {
        
        let value1: [String: Any] = ["a": 1, "b": 12.34, "c": "Satya", "d": true]
        
        FileStorage.shared.set(value1, forKey: "DictionaryHetro")
        let value2 = FileStorage.shared.dictionary(forKey: "DictionaryHetro")
        let string1: Int = value1["a"] as! Int
        let string2: Int = value2?["a"] as! Int
        XCTAssert(string1 == string2)
    }
    
    func testNSDate() {
        
        let value1: NSDate = NSDate()
        
        FileStorage.shared.set(value1, forKey: "NSDate")
        let value2 = FileStorage.shared.date(forKey: "NSDate")
        
        XCTAssert(value1 == value2)
    }
    
    func testDate() {
        
        let value1 = Date()
        
        FileStorage.shared.set(value1, forKey: "Date")
        let value2 = FileStorage.shared.object(forKey: "Date") as? Date
        
        XCTAssert(value1 == value2)
    }
    
    func testProfile() {
        
        let value1: Profile = Profile.init(name: "Satya", age: 28)
        
        FileStorage.shared.setObject(value1, forKey: "Profile")
        let value2 = FileStorage.shared.getObject("Profile") as? Profile
        
        XCTAssert(value1.name == value2?.name)
        XCTAssert(value1.age == value2?.age)
    }
    
    func testStudent() {
        
        let value1: Student = Student.init(name: "Satya", rollNo: 28)
        
        FileStorage.shared.setObject(value1, forKey: "Student")
        let value2 = FileStorage.shared.getObject("Student", as: Student.self)
        
        XCTAssert(value1.name == value2?.name)
        XCTAssert(value1.rollNo == value2?.rollNo)
    }
    
    func testStudentArray() {
        
        let stu1: Student = Student.init(name: "Satya", rollNo: 28)
        let stu2: Student = Student.init(name: "Dev", rollNo: 25)
        
        let value1 = [stu1, stu2]
        
        FileStorage.shared.setObject(value1, forKey: "StudentArray")
        if let value2 = FileStorage.shared.getObject("StudentArray", as: [Student].self) {
            XCTAssert(value1 == value2)
        } else {
            XCTFail()
        }
    }
    
    func testRemove() {
        let fileStorage = FileStorage.shared
        fileStorage.removeObject(forKey: "StudentArray")
        XCTAssertFalse(fileStorage.fileManager.fileExists(atPath: fileStorage.getPath("StudentArray").path))
    }
    
    func testRemoveAll() {
        let fileStorage = FileStorage.shared
        fileStorage.removeAll()
        XCTAssertFalse(fileStorage.fileManager.fileExists(atPath: FileStorage.baseFolderPath.path))
    }
}
