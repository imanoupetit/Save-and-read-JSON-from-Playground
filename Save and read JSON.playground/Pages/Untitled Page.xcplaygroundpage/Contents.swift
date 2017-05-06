
import Foundation
import PlaygroundSupport

let fileUrl = PlaygroundSupport.playgroundSharedDataDirectory.appendingPathComponent("Persons.json")
let personArray =  [["person": ["name": "Dani", "age": "24"]], ["person": ["name": "Ray", "age": "50"]]]

func saveToJsonFile() {
    // Transform array into data and save it into file
    do {
        let data = try JSONSerialization.data(withJSONObject: personArray, options: JSONSerialization.WritingOptions.prettyPrinted)
        try data.write(to: fileUrl, options: [])
    } catch {
        print(error)
    }
}

func saveToJsonFile2() {
    // Create a write-only stream
    guard let stream = OutputStream(toFileAtPath: fileUrl.path, append: false) else { return }
    stream.open()
    defer {
        stream.close()
    }
    
    // Transform array into data and save it into file
    var error: NSError?
    JSONSerialization.writeJSONObject(personArray, to: stream, options: JSONSerialization.WritingOptions.prettyPrinted, error: &error)
    
    // Handle error
    if let error = error {
        print(error)
    }
}

func retrieveFromJsonFile() {
    // Read data from .json file and transform data into an array
    do {
        let data = try Data(contentsOf: fileUrl, options: [])
        guard let personArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: [String: String]]] else { return }
        print(personArray) // prints [["person": ["name": "Dani", "age": "24"]], ["person": ["name": "ray", "age": "70"]]]
    } catch {
        print(error)
    }
}

func retrieveFromJsonFile2() {
    // Create a read-only stream
    guard let stream = InputStream(url: fileUrl) else { return }
    stream.open()
    defer {
        stream.close()
    }
    
    // Read data from .json file and transform data into an array
    do {
        guard let personArray = try JSONSerialization.jsonObject(with: stream, options: []) as? [[String: [String: String]]] else { return }
        print(personArray) // prints [["person": ["name": "Dani", "age": "24"]], ["person": ["name": "ray", "age": "70"]]]
    } catch {
        print(error)
    }
}

saveToJsonFile()
retrieveFromJsonFile()
//saveToJsonFile2()
//retrieveFromJsonFile2()
