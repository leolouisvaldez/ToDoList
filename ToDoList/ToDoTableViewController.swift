//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by student11 on 4/9/19.
//  Copyright © 2019 Leo Louis. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    
    var todos = [ToDo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor.green
        
        if let savedTodos = ToDo.loadToDos() {
            todos = savedTodos
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    } // viewDidLoad end
    
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }// if let
        
    }// checkmarkTapped()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    } // ends override func numberofsections

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }// ends override func tableview

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIndentifier")
            as? ToDoCell else {
                fatalError("Could not dequeue a cell")
        }
        cell.delegate = self
        
        let todo = todos[indexPath.row]
        cell.titleLabel.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        if todo.dueDate < Date() && !todo.isComplete {
            cell.titleLabel.textColor = .red
        }
        // Configure the cell...
        return cell
    }// ends  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }// ends override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath)
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert { // ToDo.saveToDos(todos)
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 
    @IBAction func unwindToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceVC = segue.source as! ToDoDetailViewController
        if let todo = sourceVC.todo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }//ends
        }// ends if let todo
        ToDo.saveToDos(todos)
    }// ends @IBAction func unwindToDoList(segue: UIStoryboardSegue)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let toDoDetailVC = segue.destination as! ToDoDetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedToDo = todos[indexPath.row]
            toDoDetailVC.todo = selectedToDo
        }// ends if segue.identifier
    } // ends override func prepare(for segue: UIStoryboardSegue, sender: Any)
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
