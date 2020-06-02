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
        return notes.toArray()
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
}
