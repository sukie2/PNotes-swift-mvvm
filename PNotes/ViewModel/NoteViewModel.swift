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
    
    func addNewNote(note: Note){
        let configuredNote = NoteUtility.getConfigureNote(note: note)
        repositiry.addNewNote(note: configuredNote)
    }
    
    func deleteNote(note: Note){
        repositiry.deleteNote(note: note)
    }
    
    func getNotesList() -> [Note]{
        return repositiry.getNotesList()
    }
    
    func updateNote(note: Note){
        let configuredNote = NoteUtility.configureEditTime(note: note)
        repositiry.updateNote(note: configuredNote)
    }
    
    @objc func saveNote(note: Note?, title: String, data: String){
        var tempNote = Note()
        tempNote.noteID = note?.noteID ?? 0
        tempNote.noteEditTime = note?.noteEditTime ?? 0
        tempNote.noteTitle = title
        tempNote.noteData = data
        
        if(tempNote.noteID == 0){
            addNewNote(note: tempNote)
        }else{
            updateNote(note: tempNote)
        }
    }
    
}
