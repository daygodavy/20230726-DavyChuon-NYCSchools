//
//  SchoolDetailsVM.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import Foundation
import CoreLocation

class SchoolDetailsVM {
    
    // MARK: - Variables
    var schoolStats: SchoolStats
    var schoolInfo: School
    var onStatsLoaded: ((SchoolStats?)->Void)?
    
    
    // MARK: - Initializers
    init(schoolStats: SchoolStats, school: School) {
        self.schoolStats = schoolStats
        self.schoolInfo = school
        getSchoolStats()
    }
    
    
    // MARK: - Methods

    // Fetching school's SAT data
    private func getSchoolStats() {
        Task {
            do {
                let data = try await NetworkManager.shared.fetchSchool(id: schoolStats.dbn)
                setSchoolStats(data.first)
                onStatsLoaded?(schoolStats)
            } catch {
                // TODO: PRESENT CUSTOM ERROR WITH THE ERRORMANAGER RESPONSE
            }
        }
    }
    
    
    // Setting fetched SAT data into SchoolStats model
    private func setSchoolStats(_ school: SchoolStats?) {
        guard let school = school else { return }
        guard let _ = Int(school.satCriticalReadingAvgScore),
        let _ = Int(school.satWritingAvgScore),
        let _ = Int (school.satMathAvgScore)
        else { return }
        
        schoolStats.satCriticalReadingAvgScore = school.satCriticalReadingAvgScore
        schoolStats.satWritingAvgScore = school.satWritingAvgScore
        schoolStats.satMathAvgScore = school.satMathAvgScore
    }
    
    
    // MARK: - Computed Properties
    var schoolName: String {
        // Edge case: some school names contain unnecessary suffix
        let name = schoolStats.schoolName.removeExtraSuffix(", The")
        
        return "\(name)"
    }
    
    var readingAvgSAT: String {
        return "SAT Critical Reading Avg: \(schoolStats.satCriticalReadingAvgScore)"
    }
    
    var mathAvgSAT: String {
        return "SAT Math Avg: \(schoolStats.satMathAvgScore)"
    }
    
    var writingAvgSAT: String {
        return "SAT Writing Avg: \(schoolStats.satWritingAvgScore)"
    }
    
    var phoneNumber: String {
        return "Phone Number:\n\(schoolInfo.phoneNumber)"
    }
    
    var address: String {
        return "\(schoolInfo.primaryAddressLine1), \(schoolInfo.city) \(schoolInfo.stateCode) \(schoolInfo.zip)"
    }
    
    var website: String {
        return "Website:\n\(schoolInfo.website)"
    }
    
    var coordinate: CLLocationCoordinate2D? {
        if let lat: CLLocationDegrees = Double(schoolInfo.latitude),
           let long: CLLocationDegrees = Double(schoolInfo.longitude) {
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        
        return nil
    }
}
