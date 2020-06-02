//
//  NoteRepository.swift
//  PNotes
//
//  Created by Sukitha on 1/6/20.
//  Copyright © 2020 Sukitha. All rights reserved.
//

import Foundation
import RealmSwift

class NoteRepository{
    let realm = try! Realm()
    
    func getNotesList()-> [Note]{
        let notes = realm.objects(Note.self)
        let sortedNotes = notes.sorted(byKeyPath: "noteEditTime", ascending: false)
        return sortedNotes.toArray()
    }
    
    func addNewNote(note: Note){
        try! realm.write {
            realm.add(note)
        }
    }
    
    func deleteNote(note: Note){
        try! realm.write {
             realm.delete(note)
         }
    }
    
    func updateNote(note: Note){
        let fliteredNotes = realm.objects(Note.self).filter("noteID = %@", note.noteID)
        if let noteToEdit = fliteredNotes.first {
            try! realm.write {
                noteToEdit.noteTitle = note.noteTitle
                noteToEdit.noteData = note.noteData
                noteToEdit.noteEditTime = note.noteEditTime
            }
        }
    }
}
