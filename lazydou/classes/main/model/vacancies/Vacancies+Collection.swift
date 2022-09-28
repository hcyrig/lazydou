//
//  Vacancies+Collection.swift
//

import Foundation

import NOFoundation

import SwiftSoup

// MARK: - Collection -

extension Vacancies {
  
  public static func collectionBy(htmlData: String) -> [Vacancy] {
    
    var vacancies = [Vacancy]()
    
    do {
      
      let document = try SwiftSoup.parse(htmlData)
      let listOfElements = try document.select("li")
      vacancies = listOfElements
        .map({ (element) -> Dictionary<String, Any>? in
          
          do {
            
            let titles = try element.getElementsByClass("title")
            let vacancyRef = try titles.first()?.getElementsByClass("vt").attr("href") ?? ""
            let vacancyTitle = try titles.first()?.getElementsByClass("vt").text().replacingOccurrences(of: ",", with: ";") ?? ""
            let companyRef = try titles.first()?.getElementsByClass("company").attr("href") ?? ""
            let companyTitle = try titles.first()?.getElementsByClass("company").text() ?? ""
            let info = try element.getElementsByClass("sh-info")
            let vacancyDescription = try info.text().replacingOccurrences(of: ",", with: ";")
            
            var vacancyModel = Dictionary<String, Any>()
            vacancyModel["vacancyTitle"]        = vacancyTitle
            vacancyModel["vacancyRef"]          = vacancyRef
            vacancyModel["companyTitle"]        = companyTitle
            vacancyModel["companyRef"]          = companyRef
            vacancyModel["vacancyDescription"]  = vacancyDescription
            return vacancyModel
            
          } catch {
            print(error)
            return nil
          }
        })
        .compactMap({ $0 as? [String: String] })
        .compactMap({ Vacancy($0) })
      
    } catch {
      
      NOSTDOUT.display(error)
      
      return vacancies
    }
    return vacancies
  }
  
  public static func sort(vacancies: [Vacancies.Vacancy]) -> [Vacancies.Vacancy] {
    
    vacancies.sorted(by: { ($0.title, $0.companyTitle) < ($1.title, $1.companyTitle) })
  }
}
