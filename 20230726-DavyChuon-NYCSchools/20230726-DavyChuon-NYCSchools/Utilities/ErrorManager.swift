//
//  ErrorManager.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import Foundation

// Enum for presenting user facing errors
enum ErrorManager: String, Error {
    case invalidURL = "The endpoint you're trying to reach created an invalid request. Please try again."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
