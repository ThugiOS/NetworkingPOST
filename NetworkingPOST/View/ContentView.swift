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
                    NetworkServiceWithCompletion.shared.createToDo(dto) { result in
                        switch result {
                        case .success(let todo):
                            print(todo.title)
                        case .failure(let error):
                            print(error)
                        }
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
