//
//  DataManager.swift
//  Football League Application
//
//  Created by mariam adly on 02/07/2024.
//

import Foundation
class DataManager {
    static let shared = DataManager()

    private let userDefaults = UserDefaults.standard
    private let fileManager = FileManager.default

    // Save objects to UserDefaults
    func saveObjects<T: Codable>(objects: T, forKey key: String) {
        do {
            let encodedData = try JSONEncoder().encode(objects)
            userDefaults.set(encodedData, forKey: key)
        } catch {
            print("Error encoding objects: \(error.localizedDescription)")
        }
    }

    // Retrieve objects from UserDefaults
    func getObjects<T: Codable>(forKey key: String) -> T? {
        guard let savedData = userDefaults.data(forKey: key) else { return nil }

        do {
            let objects = try JSONDecoder().decode(T.self, from: savedData)
            return objects
        } catch {
            print("Error decoding objects: \(error.localizedDescription)")
            return nil
        }
    }

    // Save objects to a file
    func saveObjectsToFile<T: Codable>(objects: T, fileName: String) {
        let fileURL = getFileURL(forFileName: fileName)

        do {
            let encodedData = try JSONEncoder().encode(objects)
            try encodedData.write(to: fileURL, options: .atomic)
        } catch {
            print("Error saving objects to file: \(error.localizedDescription)")
        }
    }

    // Retrieve objects from a file
    func getObjectsFromFile<T: Codable>(fileName: String) -> T? {
        let fileURL = getFileURL(forFileName: fileName)

        do {
            let data = try Data(contentsOf: fileURL)
            let objects = try JSONDecoder().decode(T.self, from: data)
            return objects
        } catch {
            print("Error retrieving objects from file: \(error.localizedDescription)")
            return nil
        }
    }

    private func getFileURL(forFileName fileName: String) -> URL {
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(fileName)
    }
}
