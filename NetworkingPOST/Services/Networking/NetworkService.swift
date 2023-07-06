//
//  NetworkService.swift
//  NetworkingPOST
//
//  Created by Никитин Артем on 6.07.23.
//

import Foundation

class NetworkService {
    static let shared = NetworkService(); private init() { }
    
    func getAllTodos() async throws -> [ToDo] {
        
        guard let url = URLManager.shared.createURL(endPoint: .todos, id: nil) else {
            throw NetworkError.badURL
        }
        
        do {
            let responce = try await URLSession.shared.data(from: url)
            let data = responce.0
            let decoder = JSONDecoder()
            let todos = try decoder.decode([ToDo].self, from: data)
            return todos
        } catch {
            throw error
        }
    }
    
    func createToDo(_ dto: ToDo.TodoDTO) async throws -> ToDo {
        
        guard let url = URLManager.shared.createURL(endPoint: .todos, id: nil) else {
            throw NetworkError.badURL
        }
        
        var req = URLRequest(url: url) // создание запроса
        
        // настройка запроса
        req.httpMethod = "POST"
        req.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
        
        let encoder = JSONEncoder()
        let body = try encoder.encode(dto)
        
        req.httpBody = body
        
        // отправка запроса, получение ответа
        let resp = try await URLSession.shared.data(for: req)
        
        let data = resp.0 // Извлечение данных из ответа
        
        // Декодирование данных в свифт модель
        let decoder = JSONDecoder()
        let todo = try decoder.decode(ToDo.self, from: data)
        
        return todo
    }
}
