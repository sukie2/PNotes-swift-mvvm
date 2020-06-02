//
//  DateExt.swift
//  PNotes
//
//  Created by Sukitha on 1/6/20.
//  Copyright © 2020 Sukitha. All rights reserved.
//

import Foundation

class NoteUtility: NSObject {
    static func getConfigureNote(note: Note) -> Note{
        var configuredNote = configureID(note: note)
        configuredNote = configureTitle(note: configuredNote)
        
        return configuredNote
    }
    
    static func configureID(note: Note)-> Note{
        let since1970 = Date().timeIntervalSince1970
        note.noteID = Int(since1970 * 1000)
        
        return note
    }
    
    static func configureTitle(note: Note) -> Note {
        if(note.noteTitle.isEmpty){
            note.noteTitle = "Default"
        }
        return note
    }
}
