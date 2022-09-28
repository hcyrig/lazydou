//
//  MainViewController+CSVActions.swift
//

import AppKit

extension MainViewController {
  
  public func fetchDestinationFolderURLAction() {
    
    NSOpenPanel
      .openDirectory(path: FileManager.homeDowndloadURL.absoluteString,
                     allowedMultipleSelection: false ) {[weak self] urls in
        
        guard let `self` = self else { return }
        
        guard !urls.isEmpty, let url = urls.first else { return }
        
        self.discordHTTPClient.context.destinationFolderURL = url
        
        self.establishSessionAction(context: self.discordHTTPClient.context) { [weak self] in
          
          guard let `self` = self else { return }
          
          self.vacanciesAction(context: self.discordHTTPClient.context) { [weak self] in
            
            guard let `self` = self else { return }
            
            self.exportCSVAction()
          }
        }
      }
  }
  
  func exportCSVAction() {
    
    let csv = CSV(models: Vacancies.sort(vacancies: self.vacancies))
    
    guard let destinationFolderURL = self.discordHTTPClient.context.destinationFolderURL else { return }
    
    csv.export(destinationFolderURL: destinationFolderURL,
               infix: self.discordHTTPClient.context.searchTitle)
  }
}
