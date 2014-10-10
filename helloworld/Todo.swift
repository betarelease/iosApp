//
//  Todo.swift
//  helloworld
//
//  Created by Sudhindra Rao on 10/10/14.
//  Copyright (c) 2014 Sudhindra Rao. All rights reserved.
//

//
//  Album.swift
//  MusicPlayer
//
//  Created by Jameson Quave on 9/16/14.
//  Copyright (c) 2014 JQ Software LLC. All rights reserved.
//

import Foundation

class Todo {
    var title: String
    init(title: String) {
        self.title = title
    }
    
    class func todosWithJSON(allResults: NSArray) -> [Todo] {
        var todos = [Todo]()
        if allResults.count>0 {
            for result in allResults {
                
                var name = result["content"] as? String ?? "BLANK"
                
                var newTodo = Todo(title: name)
                todos.append(newTodo)
            }
        }
        return todos
    }
    
}