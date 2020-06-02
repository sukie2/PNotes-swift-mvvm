//
//  NoteViewModel.swift
//  PNotes
//
//  Created by Sukitha on 1/6/20.
//  Copyright © 2020 Sukitha. All rights reserved.
//

import Foundation

class NoteViewModel: NSObject{
    var repositiry: NoteRepository
    
    init(withRepository repo: NoteRepository) {
        repositiry = repo
    }
    
    func addNewNote(){
        var note = Note()
        let configuredNote = NoteUtility.getConfigureNote(note: note)
        repositiry.addNewNote(note: configuredNote)
    }
    
    func deleteNote(note: Note){
        repositiry.deleteNote(note: note)
    }
    
    func getNotesList() -> [Note]{
        return repositiry.getNotesList()
    }
    
    func editNote(note: Note){
        repositiry.editNote(note: note)
    }
    
}
