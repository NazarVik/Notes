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
        setMocks()
    }
    
    private func getNotes() {
        
    }
    
    private func setMocks() {
        let section = TableViewSection(title: "23 Apr 2023", items: [
        Note(title: "First note",
            description: "First note description",
            data: Date(),
            imageURL: nil,
            image: nil),
        Note(title: "Second note",
            description: "Second note description",
            data: Date(),
            imageURL: nil,
            image: nil)
        ])
        self.section = [section]
    }
}
