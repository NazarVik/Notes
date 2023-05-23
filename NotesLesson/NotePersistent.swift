//
//  NotePersistent.swift
//  NotesLesson
//
//  Created by Виктор Назаров on 23.05.23.
//

import Foundation
import CoreData

final class NotePersistent {
    private static let context = AppDelegate.persistentContainer.viewContext
    
    static func save(_ note: Note) {
        
    }
    
    static func delete(_ note: Note) {
        
    }
    
    static func fetchAll() -> [Note] {
        return []
    }
}
