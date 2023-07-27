//
//  NetworkManager.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL: String = "https://data.cityofnewyork.us/resource"
    private let limit: Int = 25
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchAllSchools(page: Int) async throws -> [School] {
        let offset: Int = page * limit
        let endPoint = "\(baseURL)/s3k6-pzi2.json?$limit=\(limit)&$offset=\(offset)"

        guard let url = URL(string: endPoint) else { throw ErrorManager.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw ErrorManager.invalidResponse }

        do {
            return try decoder.decode([School].self, from: data)
        } catch {
            print(error)
            throw ErrorManager.invalidData
        }
    }
    
    func fetchSchool(id: String) async throws -> [SchoolStats] {
        let endPoint = "\(baseURL)/f9bf-2cp4.json?dbn=\(id)"
        
        guard let url = URL(string: endPoint) else { throw ErrorManager.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw ErrorManager.invalidResponse }
        
        do {
            return try decoder.decode([SchoolStats].self, from: data)
        } catch {
            print(error)
            throw ErrorManager.invalidData
        }
    }
}
