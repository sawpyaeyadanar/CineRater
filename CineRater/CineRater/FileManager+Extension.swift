//
//  FileManager+Extension.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 4/9/23.
//

import Foundation
let fileName = "FavouriteMovie.json"

extension FileManager {
    static var docDirURL: URL {
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    /*
     replace with throwing function
    func saveDocument(contents: String, docName: String, completion: (LocalError?) -> Void) {
        let url = Self.docDirURL.appendingPathComponent(docName)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            completion(.saveError)
        }
    }
     */
    func saveDocument(contents: String, docName: String) throws {
        let url = Self.docDirURL.appendingPathComponent(docName)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
            debugPrint("Save successfully in Local: Here is path \(url.absoluteString)")
        } catch {
            throw LocalError.saveError
        }
    }
    
    /*
     replace with throwing function
    func readDocument(docName: String, completion: (Result<Data, LocalError>) -> Void) {
        let url = Self.docDirURL.appendingPathComponent(docName)
        do {
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch {
            completion(.failure(.readError))
        }
    }
     */
    
    func readDocument(docName: String) throws -> Data {
        let url = Self.docDirURL.appendingPathComponent(docName)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            throw LocalError.readError
        }
    }
    
    
    func docExist(named docName: String) -> Bool {
        fileExists(atPath: Self.docDirURL.appendingPathComponent(docName).path)
    }
}
