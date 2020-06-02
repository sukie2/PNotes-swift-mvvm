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
    @objc dynamic var noteID: Int = 0
    @objc dynamic var noteTitle = ""
    @objc dynamic var noteData = ""
    @objc dynamic var noteEditTime: Int = 0
}
