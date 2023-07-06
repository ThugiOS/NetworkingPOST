//
//  NetworkServiceWithCompletion.swift
//  NetworkingPOST
//
//  Created by Никитин Артем on 6.07.23.
//

import Foundation

class NetworkServiceWithCompletion {
    static let shared = NetworkServiceWithCompletion(); private init() { }
    
    
    func createToDo(_ dto: ToDo.TodoDTO, completion: @escaping (Result<ToDo, Error>) -> ()) {
        // УРЛ
        guard let url = URLManager.shared.createURL(endPoint: .todos, id: nil) else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        // НАСТРОЙКА И ПОДГОТОВКА ЗАПРОСА
        // создание запроса
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
        // Из swift модели переводим в json
        let encoder = JSONEncoder()
        guard let body = try? encoder.encode(dto) else {
            completion(.failure(NetworkError.invalidEncoding))
            return
        }
        req.httpBody = body // в этом теле данные, которые мы передадим при запросте
        
        // ОТПРАВКА ЗАПРОСА/ПОЛУЧЕНИЕ ОТВЕТА
        URLSession.shared.dataTask(with: req) { data, response, error in
            guard let data else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            // Декодирование данных в свифт модель
            let decoder = JSONDecoder()
            guard let todo = try? decoder.decode(ToDo.self, from: data) else {
                completion(.failure(NetworkError.invalidDecoding))
                return
            }
            completion(.success(todo))
        }.resume()
    }
}
