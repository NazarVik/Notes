//
//  NotesListViewModel.swift
//  NotesLesson
//
//  Created by Виктор Назаров on 22.05.23.
//

import Foundation
import UIKit

protocol NotesListViewModelProtocol {
    var section: [TableViewSection] { get }
    var reloadTable: (() -> Void)? { get set }
    
    func getNotes()
    func getImage(for url: URL) -> UIImage?
}

final class NotesListViewModel: NotesListViewModelProtocol {
    var reloadTable: (() -> Void)?
    //для того что бы нельзя было изменить за пределами этого класса
    private(set) var section: [TableViewSection] = [] {
        didSet {
            reloadTable?()
        }
    }// секции с зоголоками и ячейками
    
    init() {
        getNotes()
    }
    
    func getNotes() {
        let notes = NotePersistent.fetchAll()
        section = []
        
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
    
    func getImage(for url: URL) -> UIImage? {
        FileManagerPersistent.read(from: url)
    }
    
    private func setMocks() {
        let section = TableViewSection(title: "23 Apr 2023", items: [
        Note(title: "First note",
            description: "First note description",
            date: Date(),
            imageURL: nil),
        Note(title: "Second note",
            description: "Second note description",
            date: Date(),
            imageURL: nil)
        ])
        self.section = [section]
    }
}
