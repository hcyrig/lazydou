//
//  CSVSupportable.swift
//

import Foundation

import NOFoundation

public protocol CSVSupportable {
  
  static var csvKeys: String { get }
  var csvLine: String { get }
}

public class CSV<T: CSVSupportable> {
  
  private var models: [T]
  public init(models: [T]) { self.models = models }
  
  public func make() -> String? {
    
    var csv = T.csvKeys
    models.forEach { csv.append(contentsOf: $0.csvLine) }
    return csv
  }
  
  public func export(destinationFolderURL: URL,
                     infix: String = .empty) {
    
    let destinationFileURL = destinationFolderURL
      .appendingPathComponent(Bundle.applicationTitle + infix + "-dou-vacancies-list.csv")
    
    guard destinationFileURL.isFileURL else { return }
    
    guard let csvString = make() else { return }
    
    do {
      
      try csvString.write(to: destinationFileURL,
                          atomically: true,
                          encoding: .utf8)
      
    } catch {
      
      NOSTDOUT.display(error)
    }
  }
}
