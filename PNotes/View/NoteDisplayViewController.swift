//
//  NoteDisplayViewController.swift
//  PNotes
//
//  Created by Sukitha on 1/6/20.
//  Copyright © 2020 Sukitha. All rights reserved.
//

import UIKit

class NoteDisplayViewController: UIViewController {
    
    var viewModel: NoteViewModel? = nil
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveNote))
        configureView()
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    @objc func saveNote(){
        viewModel?.addNewNote()
        self.navigationController?.popViewController(animated: true)
    }


}

