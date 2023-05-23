//
//  Note.swift
//  NotesLesson
//
//  Created by Виктор Назаров on 22.05.23.
//

import Foundation

struct Note: TableViewItemProtocol {
    let title: String
    let description: String?
    let data: Date
    let imageURL: String?
    let image: Data? = nil
}
