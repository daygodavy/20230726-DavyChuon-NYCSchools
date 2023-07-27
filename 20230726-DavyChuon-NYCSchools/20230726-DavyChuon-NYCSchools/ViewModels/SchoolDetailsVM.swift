//
//  SchoolDetailsVM.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import Foundation

class SchoolDetailsVM {
    
    // MARK: - Variables
    let school: SchoolStats
    
    // MARK: - Initializer
    init(school: SchoolStats) {
        self.school = school
    }
    
    // MARK: - Computed Properties
    var schoolName: String {
        return "\(self.school.schoolName)"
    }
    
    var readingAvgSAT: String {
        return "SAT Critical Reading Avg: \(self.school.satCriticalReadingAvgScore)"
    }
    
    var mathAvgSAT: String {
        return "SAT Math Avg: \(self.school.satMathAvgScore)"
    }
    
    var writingAvgSAT: String {
        return "SAT Writing Avg: \(self.school.satWritingAvgScore)"
    }
}
