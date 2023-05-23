//
//  TableViewSection.swift
//  NotesLesson
//
//  Created by Виктор Назаров on 22.05.23.
// описание секции

import Foundation

protocol TableViewItemProtocol {
    
}
struct TableViewSection {
    var title: String?
    var items: [TableViewItemProtocol]
}
