//
//  FileManagerPersistent.swift
//  NotesLesson
//
//  Created by Виктор Назаров on 24.05.23.
//

import Foundation
import UIKit

final class FileManagerPersistent {
    static func save(_ image: UIImage, with name: String) -> URL? {
        let data = image.jpegData(compressionQuality: 1)
        let url = getDocumentDirectory().appendingPathComponent(name)
        
        do {
            try data?.write(to: url)
            print("image was saved")
            return url
        } catch {
            print("saving image error: \(error)")
            return nil
        }
    }
    
    static func read(from url: URL) -> UIImage? {
        UIImage(contentsOfFile: url.path)
    }
    
    static func delete(from url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
            print("image was deleted")
        } catch {
            print("deleted image error: \(error)")
        }
    }
    
    private static func getDocumentDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
