//
//  ToDo.swift
//  NetworkingPOST
//
//  Created by Никитин Артем on 6.07.23.
//

import Foundation

struct ToDo: Identifiable, Codable {
    let id: Int
    let userId: Int
    let title: String
    let completed: Bool
    
    // для отправки id не нужен и не нужно декодировать(без Codable)
    var dto: TodoDTO {
        let dto = TodoDTO(userId: userId, title: title, completed: completed)
        return dto
    }
    
    struct TodoDTO: Encodable {
        let userId: Int
        let title: String
        let completed: Bool
    }
}
