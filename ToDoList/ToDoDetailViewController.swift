//
//  ToDoDetailViewController.swift
//  ToDoList
//
//  Created by student11 on 4/9/19.
//  Copyright © 2019 Leo Louis. All rights reserved.
//

import UIKit

class ToDoDetailViewController: UITableViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var isDatePickerHidden = true
    var todo: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            navigationItem.title = "To Do Item"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSavebuttonState()
    }// ends override func viewDidLoad()
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSavebuttonState()
    }//ends IBAction func textEditingChanged
    
    func updateSavebuttonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }// ends func updateSavebuttonState()
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }//ends @IBAction func returnPressed
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected // checks and unchecks
    }// ends @IBAction func isCompleteButtonTapped
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }//ends @IBAction func datePickerChanged
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
        if todo?.dueDate ?? Date() < Date() && todo?.isComplete == false {
            dueDateLabel.textColor = .red
        } //ends if todo?.dueDate
    }// ends func updateDueDateLabel
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch (indexPath) {
        case [1,0]:
                return isDatePickerHidden ? normalCellHeight: largeCellHeight
        case [2,0]:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath) {
        case [1,0]:
            isDatePickerHidden = !isDatePickerHidden
            dueDateLabel.textColor = isDatePickerHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }// ends override func tableView
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text!
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }
    
    
}
































