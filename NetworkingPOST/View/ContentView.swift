//
//  ContentView.swift
//  NetworkingPOST
//
//  Created by Никитин Артем on 6.07.23.
//

import SwiftUI
 
struct ContentView: View {
    
    @State var todos = [ToDo]()
    @State var todoTitle = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Введите название новой задачи", text: $todoTitle)
                Button("Создать") {
                    print("Создание новой задачи")
                    let dto = ToDo.TodoDTO(userId: 6,
                                           title: todoTitle,
                                           completed: false)
                    Task {
                        let todo = try await NetworkService.shared.createToDo(dto)
                        print(todo.id)
                        print(todo.title) // Данные уже из сервера
                    }
                    
                }.padding()
            }
            List {
                ForEach(todos) { todo in
                    Text(todo.title)
                }
            }
        }
        .padding()
        .onAppear {
            Task {
                let todos = try await NetworkService.shared.getAllTodos()
                self.todos = todos
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
