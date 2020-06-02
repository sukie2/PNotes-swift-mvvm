//
//  NoteDisplayViewController.swift
//  PNotes
//
//  Created by Sukitha on 1/6/20.
//  Copyright © 2020 Sukitha. All rights reserved.
//
import UIKit

class NoteDisplayViewController: UIViewController {
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tvData: UITextView!
    
    var viewModel: NoteViewModel? = nil
    var note: Note? = nil
    
    func configureView() {
        // Update the user interface for the detail item.
        if(note != nil){
            tfTitle.text = note?.noteTitle ?? ""
            tvData.text = note?.noteData ?? ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveNote))
        
        self.tvData.layer.borderColor = UIColor.lightGray.cgColor
        self.tvData.layer.borderWidth = 1
        
    }
    
    @objc func saveNote(){
        let title = tfTitle.text ?? ""
        let data = tvData.text ?? ""
        viewModel?.saveNote(note: note, title: title, data: data)
        self.navigationController?.popViewController(animated: true)
    }
}

