//
//  MainViewController+PopUps.swift
//

import AppKit

public var Experiences: [(title: String, value: String)] = [
  
  ("Any Experience", ""),
  ("0-1", "0-1"),
  ("1-3", "1-3"),
  ("3-5", "3-5"),
  ("5+", "5plus")
]

public var Cities: [String] = [
  
  "All Cities",
  "Харків",
  "Київ",
  "Львів",
  "Одеса",
  "Вінниця",
  "Дніпро",
  "Ужгород",
  "Івано-Франківськ",
  "Чернівці",
  "Чернігів",
  "Луцьк",
  "Хмельницький",
  "Полтава",
  "Черкаси",
  "Миколаїв",
  "Кременчук",
  "Рівне",
  "Суми",
  "Житомир",
  "Запоріжжя",
  "Тернопіль",
  "Херсон",
  "Кропивницький",
  "Маріуполь",
  "віддалена робота",
  "🚜 за кордоном"
]

public var Categories: [String] = [
  
  "All Categories",
  ".NET",
  "1С",
  "Analyst",
  "Android",
  "Animator",
  "Architect",
  "Artist",
  "Big Data",
  "Blockchain",
  "C++",
  "Data Science",
  "DBA",
  "Design",
  "DevOps",
  "Embedded",
  "ERP/CRM",
  "Finances",
  "Flutter",
  "Front End",
  "Golang",
  "HR",
  "iOS/macOS",
  "Java",
  "Legal",
  "Marketing",
  "Node.js",
  "Office Manager",
  "Other",
  "PHP",
  "Product Manager",
  "Project Manager",
  "Python",
  "QA",
  "React Native",
  "Ruby",
  "Rust",
  "Sales",
  "Salesforce",
  "Scala",
  "Scrum Master",
  "Security",
  "SEO",
  "Support",
  "SysAdmin",
  "Technical Writer",
  "Unity",
  "Unreal Engine"
]

extension MainViewController {
  
  public func setupPopUpsLists() {
    
    cityPopUp.addItems(withTitles: Cities)
    cityPopUp.target = self
    cityPopUp.action = #selector(cityButtonAction(_:))
    cityPopUp.selectItem(withTitle: Cities.first!)
    
    categoryPopUp.addItems(withTitles: Categories)
    categoryPopUp.target = self
    categoryPopUp.action = #selector(categoryButtonAction(_:))
    categoryPopUp.selectItem(withTitle: Categories.first!)
    
    experiencesPopUp.addItems(withTitles: Experiences.compactMap({ $0.title }))
    experiencesPopUp.target = self
    experiencesPopUp.action = #selector(experiencesButtonAction(_:))
    experiencesPopUp.selectItem(withTitle: Experiences.first!.title)
  }
}
