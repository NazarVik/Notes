//
//  NoteViewModel.swift
//  NotesLesson
//
//  Created by Виктор Назаров on 23.05.23.
//

import Foundation

protocol NoteViewModelProtocol {
    var text: String { get }
    
    func save(with text: String)
    func delete()
}

final class NoteViewModel: NoteViewModelProtocol {
    let note: Note?
    var text: String {
        let text = (note?.title ?? "") + "\n\n" + (note?.description ?? "")
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    init(note: Note?) {
        self.note = note
    }
    
    // MARK: - methods
    func save(with text: String) {
        let date = note?.data ?? Date()
        let (title, description) = createTitleAndDescription(from: text)
        
        let note = Note(title: title,
                        description: description,
                        data: date,
                        imageURL: nil )
        NotePersistent.save(note)
    }
    
    func delete() {
        guard let note = note else { return }
        
        NotePersistent.delete(note)
    }
    
    private func createTitleAndDescription(from text: String) -> (String, String?) {
        var description = text
        
        guard let index = description.firstIndex(where: { $0 == "." || $0 == "!" || $0 == "?" || $0 == "\n"}) else { return (text,nil)}
        
        let title = String(description[...index])
        description.removeSubrange(...index)
        
        return (title, description)
    }
}