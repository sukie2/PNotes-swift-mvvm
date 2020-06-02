//
//  NoteListViewController.swift
//  PNotes
//
//  Created by Sukitha on 1/6/20.
//  Copyright © 2020 Sukitha. All rights reserved.
//

import UIKit

class NoteListViewController: UITableViewController {
    var detailViewController: NoteDisplayViewController? = nil
    var viewModel: NoteViewModel = NoteViewModel(withRepository: NoteRepository())
    var objects = [Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newNoteAction(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? NoteDisplayViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        objects = viewModel.getNotesList()
        self.tableView.reloadData()
    }
    
    @objc func newNoteAction(_ sender: Any) {
        navigateToNoteDetails(noteID: -1)
    }
    
    func navigateToNoteDetails(noteID: Int){
        let noteDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteDisplayViewController") as! NoteDisplayViewController;
        noteDetailViewController.viewModel = viewModel
        self.navigationController?.pushViewController(noteDetailViewController, animated: true)
    }
    
//    // MARK: - Segues
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "showDetail" {
//            guard let indexPath = tableView.indexPathForSelectedRow else { return }
//            if let controller = segue.destination as? NoteDisplayViewController {
//                let object = objects[indexPath.row] as! NSDate
//                controller.detailItem = object
//            }
//        }
//    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let note = objects[indexPath.row] as! Note
        cell.textLabel!.text = note.noteTitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = objects[indexPath.row]
            viewModel.deleteNote(note: noteToDelete as! Note)
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        navigateToNoteDetails(noteID: 0)
    }

}

