//
//  ToDo.swift
//  ToDoList
//
//  Created by student11 on 4/9/19.
//  Copyright © 2019 Leo Louis. All rights reserved.
//

import Foundation

struct ToDo: Codable {
    
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static var dueDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    static var DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    
    static func loadToDos() -> [ToDo]? {
        guard let codedTodos = try? Data(contentsOf: ArchiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedTodos)
    }// ends static func loadToDos()
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL, options: .noFileProtection)
    }// ends static func saveToDos
    
    static func loadSampleTodos() -> [ToDo] {
        let todo1 = ToDo(title: "To Do One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "To Do Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "To Do Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        
        return [todo1, todo2, todo3]
    }//ends static func loadSampleTodos()
    
    
} // ends struct ToDo: Codable
