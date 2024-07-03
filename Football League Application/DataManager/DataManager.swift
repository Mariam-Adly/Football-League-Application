//
//  DataManager.swift
//  Football League Application
//
//  Created by mariam adly on 02/07/2024.
//

import Foundation
import RxSwift

class DataManager {
    static let shared = DataManager()

    private let userDefaults = UserDefaults.standard
    private let fileManager = FileManager.default

    // Save objects to UserDefaults
    func saveObjects<T: Codable>(objects: T, forKey key: String) -> Single<Void> {
        return Single.create { single in
            do {
                let encodedData = try JSONEncoder().encode(objects)
                self.userDefaults.set(encodedData, forKey: key)
                single(.success(()))
            } catch {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }

    // Retrieve objects from UserDefaults
    func getObjects<T: Codable>(forKey key: String) -> Single<T?> {
        return Single.create { single in
            guard let savedData = self.userDefaults.data(forKey: key) else {
                single(.success(nil))
                return Disposables.create()
            }

            do {
                let objects = try JSONDecoder().decode(T.self, from: savedData)
                single(.success(objects))
            } catch {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }

    // Save objects to a file
    func saveObjectsToFile<T: Codable>(objects: T, fileName: String) -> Single<Void> {
        return Single.create { single in
            let fileURL = self.getFileURL(forFileName: fileName)

            do {
                let encodedData = try JSONEncoder().encode(objects)
                try encodedData.write(to: fileURL, options: .atomic)
                single(.success(()))
            } catch {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }

    // Retrieve objects from a file
    func getObjectsFromFile<T: Codable>(fileName: String) -> Single<T?> {
        return Single.create { single in
            let fileURL = self.getFileURL(forFileName: fileName)

            do {
                let data = try Data(contentsOf: fileURL)
                let objects = try JSONDecoder().decode(T.self, from: data)
                single(.success(objects))
            } catch {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }

    private func getFileURL(forFileName fileName: String) -> URL {
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(fileName)
    }
}
