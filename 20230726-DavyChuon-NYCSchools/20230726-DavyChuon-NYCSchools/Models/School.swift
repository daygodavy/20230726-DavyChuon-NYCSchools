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
//    let location: String
    let city: String
    let stateCode: String
//    let neighborhood: String
//    let phoneNumber: String
//    let schoolEmail: String
//    let website: String
    let finalgrades: String
    let graduationRate: String?
    let totalStudents: String
    
//    let stats: SchoolStats
}

struct SchoolStats: Codable {
    let dbn: String
    let schoolName: String
    let satCriticalReadingAvgScore: String
    let satMathAvgScore: String
    let satWritingAvgScore: String
}
