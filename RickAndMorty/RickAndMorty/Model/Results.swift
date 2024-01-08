//
//  Result.swift
//  RickAndMorty
//
//  Created by dam2 on 18/12/23.
//

import Foundation

struct RespuestaPersonajes: Decodable {
    var results: [Personaje]
}

struct Personaje: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Origin
    var location: Location
    var image: String
    var episode: [String]
    var url: String
    var created: String
}

struct Origin: Decodable {
    var name: String
    var url: String
}

struct Location: Decodable {
    var name: String
    var url: String
}
