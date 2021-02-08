//
//  ImageCache.swift
//  News
//
//  Created by Spurge on 06/02/21.
//

import Foundation

class ImageCache{
    
    static func imageFileExists(name: String) -> Bool {
        let path = getImagePath(name: name)
        print("path",path)
        let value = FileManager.default.fileExists(atPath: path.path)
        return value
    }
    
    static func getImagePath(name: String) -> URL {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsDirectoryURL.appendingPathComponent(name)
        return destinationUrl
    }
    
    private static func downloadImg(url: URL, name: String, completion: @escaping (Bool) -> Void) {
        let destinationUrl = getImagePath(name: name)
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            print("A file exists at this path - don't download it again!")
        } else {
            URLSession.shared.downloadTask(with: url) { location, response, error in
                guard let location = location, error == nil else { return }
                do {
                    try FileManager.default.moveItem(at: location, to: destinationUrl)
                    print("Successfully downloaded and cached file!")
                } catch {
                    print("Failed to download file!")
                    print(error)
                }
            }.resume()
        }
    }

    static func downloadImage(url: URL, name: String, completion: @escaping (Bool) -> Void) {
        if !imageFileExists(name: name) {
            downloadImg(url: url, name: name, completion: completion)
        } else {
        }
    }
}
