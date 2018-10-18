# FileStorage
Secure file storage with encryption. This project reads and write your swift types on disk with encryption. It can read/write basic swift type such as `String`, `Array`, `Dictionary`, `Data`, Numbers (`Int`, `Float`, `Double`) etc or your custom classes, as long as those class inherit from `NSObject` and implement `NSCoding` or `Codable` protocol.


## Getting Started

- Clone the repo and run below command in your terminal to install the dependency for RNCryptor.  
	```
	$ pod install
	```
- Open FileStorage.xcworkspace and run the FileStorageTests.swift.


## Usage
Store your objects such as `String`, `Array`, `Dictionary`, custom class (inherite `NSObject` and implement `NSCoding` or `Codable`), ... by using `set(object, forKey: "keyName")` method and retrieve using utility methods for `string`, `bool`, `integer`, `float`, `double` etc. 

##### Store and Retrieve
Here is an example to store a `String` value and how to retrieve it. 
- Store:
	```
	let store = "Hello World"
	FileStorage.shared.set(store, forKey: "StoreKey")
	```

- Retrieve:
	```
	let retrieve = FileStorage.shared.string(forKey: "StoreKey")
	```

##### Custom class
Store custom classess by inherite from `NSObject` and implement `Codable` protocol.
```
struct Student: Codable, Equatable {
	var name: String
	var rollNo: Int
}
```
- Store:
	```
	let stu1: Student = Student.init(name: "Satya", rollNo: 28)
	FileStorage.shared.setObject(stu1, forKey: "Student")
	```    
- Retrieve:
	```
	let stu1 = FileStorage.shared.getObject("Student", as: Student.self)
	```

## Class Details

### FileStorage
This class provides methods for storing and retrieving your data. The data on disk is encrypted using RNCryptor.


### UnitTests

This module consists XCTest classe for testing. 
- **FileStorageTests**: This class consists of various test method to test data types, like Int, String, Bool, Float, Double, Array, Dictionary, Class, Struct for storing and retrieving data.

