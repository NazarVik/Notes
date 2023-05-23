//
//  NotesListViewModel.swift
//  NotesLesson
//
//  Created by Виктор Назаров on 22.05.23.
//

import Foundation

protocol NotesListViewModelProtocol {
    var section: [TableViewSection] { get }
}

final class NotesListViewModel: NotesListViewModelProtocol {
    //для того что бы нельзя было изменить за пределами этого класса
    private(set) var section: [TableViewSection] = [] // секции с зоголоками и ячейками
    
    init() {
        getNotes()
    }
    
    private func getNotes() {
        let notes = NotePersistent.fetchAll()
        print(notes)
        
        let groupedObjects = notes.reduce(into: [Date: [Note]]()) { result, note in
            let date = Calendar.current.startOfDay(for: note.date)
            result[date, default: []].append(note)
        }
        
        let keys = groupedObjects.keys
        
        keys.forEach { key in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            let stringDate = dateFormatter.string(from: key)
            
            section.append(TableViewSection(title: stringDate, items: groupedObjects[key] ?? []))
        }
    }
    
    private func setMocks() {
        let section = TableViewSection(title: "23 Apr 2023", items: [
        Note(title: "First note",
            description: "First note description",
            data: Date(),
            imageURL: nil),
        Note(title: "Second note",
            description: "Second note description",
            data: Date(),
            imageURL: nil)
        ])
        self.section = [section]
    }
}
