//
//  School.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import Foundation

struct School: Codable {
    let dbn: String
    let schoolName: String
    let primaryAddressLine1: String
    let city: String
    let stateCode: String
    let zip: String
    let latitude: String
    let longitude: String
    let phoneNumber: String
    let website: String
    let finalgrades: String
    let graduationRate: String?
    let totalStudents: String
    
//    let stats: SchoolStats?
}

struct SchoolStats: Codable {
    let dbn: String
    let schoolName: String
    var satCriticalReadingAvgScore: String
    var satMathAvgScore: String
    var satWritingAvgScore: String
}
