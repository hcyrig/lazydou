//
//  Vacancy.swift
//

import Foundation

extension Vacancies {
  
  public struct Vacancy: Codable {
    
    public var title: String
    public var url: String
    public var companyTitle: String
    public var companyUrl: String
    public var description: String
  }
}

extension Vacancies.Vacancy {
  
  public init(_ model: Dictionary<String, String>) {
    
    title         = model["vacancyTitle"] ?? .empty
    url           = model["vacancyRef"] ?? .empty
    companyTitle  = model["companyTitle"] ?? .empty
    companyUrl    = model["companyRef"] ?? .empty
    description   = model["vacancyDescription"] ?? .empty
  }
}


// MARK: - CSVSupportable -

extension Vacancies.Vacancy: CSVSupportable {
  
  public static var csvKeys: String {
    return "company, company url, vacancy, url, description\n"
  }
  
  public var csvLine: String {
    
    return "\(replaceSpecial(companyTitle)), \(replaceSpecial(companyUrl)), \(replaceSpecial(title)), \(replaceSpecial(url)), \(replaceSpecial(description))\n"
  }
  
  public func replaceSpecial(_ string: String) -> String {
    
    var string = string
    string = string.replacingOccurrences(of: ",", with: " | ")
    string = string.replacingOccurrences(of: ";", with: " | ")
    return string
  }
}


// MARK: - Hashable -

extension Vacancies.Vacancy: Hashable {
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(companyUrl)
    hasher.combine(url)
  }
}
