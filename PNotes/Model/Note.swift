//
//  File.swift
//  PNotes
//
//  Created by Sukitha on 1/6/20.
//  Copyright © 2020 Sukitha. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object{
    @objc dynamic var noteID = 0
    @objc dynamic var noteTitle = "Default"
    @objc dynamic var noteData = ""
}
