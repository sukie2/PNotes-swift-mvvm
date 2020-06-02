//
//  NoteListViewController.swift
//  PNotes
//
//  Created by Sukitha on 1/6/20.
//  Copyright © 2020 Sukitha. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class NoteListViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    var detailViewController: NoteDisplayViewController? = nil
    var viewModel: NoteViewModel = NoteViewModel(withRepository: NoteRepository())
    var noteList = [Any]()
    
    
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
        registerTableViewCells()
        
        // For empty data set message
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.noteList = self.viewModel.getNotesList()
        self.tableView.reloadData()
        
    }
    
    @objc func newNoteAction(_ sender: Any) {
        navigateToNoteDetails(note: Note())
    }
    
    private func navigateToNoteDetails(note: Note){
        let noteDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteDisplayViewController") as! NoteDisplayViewController;
        noteDetailViewController.viewModel = viewModel
        noteDetailViewController.note = note
        self.navigationController?.pushViewController(noteDetailViewController, animated: true)
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "NoteCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "NoteCell")
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteCell
        
        let note = noteList[indexPath.row] as! Note
        cell?.labelTitle!.text = note.noteTitle
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = noteList[indexPath.row]
            viewModel.deleteNote(note: noteToDelete as! Note)
            noteList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let note = noteList[indexPath.row]
        navigateToNoteDetails(note: note as! Note)
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Welcome"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }

    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Tap the + button to add your first note"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "logo")
    }
}

