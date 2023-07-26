//
//  School.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import Foundation

struct School: Codable {
//    let dbn: String
    let schoolName: String
//    let location: String
    let city: String
    let stateCode: String
//    let neighborhood: String
//    let phoneNumber: String
//    let schoolEmail: String
//    let website: String
    let finalgrades: String
    let graduationRate: String
    let totalStudents: String
    
//    let stats: SchoolStats
}

struct SchoolStats: Codable {
//    let dbn: String
    let schoolName: String
    let satCriticalReadingAvgScore: String
    let satMathAvgScore: String
    let satWritingAvgScore: String
}

extension School {
    public static func getMockData() -> [School] {
        return [
            School(schoolName: "HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES", city: "Bronx", stateCode: "NY", finalgrades: "9-12", graduationRate: "96%", totalStudents: "1234"),
            School(schoolName: "NEW EXPLORATIONS INTO SCIENCE, TECHNOLOGY AND MATH HIGH SCHOOL", city: "Springfield Gardens", stateCode: "NY", finalgrades: "9-12", graduationRate: "87%", totalStudents: "2345"),
            School(schoolName: "CASCADES HIGH SCHOOL", city: "Staten Island", stateCode: "NY", finalgrades: "9-12", graduationRate: "100%", totalStudents: "3456"),
            School(schoolName: "RALPH R. MCKEE CAREER AND TECHNICAL EDUCATION HIGH SCHOOL", city: "Long Island City", stateCode: "NY", finalgrades: "9-12", graduationRate: "71%", totalStudents: "4567")
        ]
    }
}
