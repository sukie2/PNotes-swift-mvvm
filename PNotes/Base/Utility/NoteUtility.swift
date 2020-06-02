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
        configuredNote = configureEditTime(note: configuredNote)
        return configuredNote
    }
    
    static func getTimeStamp() -> Int{
        let since1970 = Date().timeIntervalSince1970
        return Int(since1970 * 1000)
    }
    
    static func configureID(note: Note)-> Note{
        note.noteID = getTimeStamp()
        return note
    }
    
    static func configureEditTime(note: Note)-> Note{
        note.noteEditTime = getTimeStamp()
        return note
    }
    
    static func configureTitle(note: Note) -> Note {
        if(note.noteTitle.isEmpty){
            note.noteTitle = "New Note"
        }
        return note
    }
}
