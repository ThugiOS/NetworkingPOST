//
//  NetworkError.swift
//  NetworkingPOST
//
//  Created by Никитин Артем on 6.07.23.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badRequest
    case badResponce
    case invalidDecoding
}
