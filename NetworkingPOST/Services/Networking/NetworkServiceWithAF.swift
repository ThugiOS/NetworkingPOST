//
//  NetworkServiceWithAF.swift
//  NetworkingPOST
//
//  Created by Никитин Артем on 6.07.23.
//

import Foundation
import Alamofire

class NetworkServiceWithAF {
    static let shared = NetworkServiceWithAF(); private init() { }
    
    func createToDo(_ dto: ToDo.TodoDTO, completion: @escaping (Result<ToDo, Error>) -> ()) {
        
        guard let url = URLManager.shared.createURL(endPoint: .todos, id: nil) else {
            completion(.failure(NetworkError.badURL))
            return
        }

        
        let header = HTTPHeader(name: "Content-type",
                                value: "application/json; charset=UTF-8")
        
        AF.request(url, method: .post, parameters: dto, encoder: .json, headers: [header])
            .validate() // .validate() - проверка
            .response { response in
                guard let data = response.data else {
                    if let error = response.error {
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
            }
    }
}
