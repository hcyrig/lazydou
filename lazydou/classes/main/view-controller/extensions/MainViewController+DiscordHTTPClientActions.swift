//
//  MainViewController+DiscordHTTPClient.swift
//

import AppKit

import NOFoundation

import lazyapi

extension MainViewController {
  
  public func establishSessionAction(
    context: DouHTTPClient.Context,
    completion: @escaping VoidCallback) {
      
      discordHTTPClient.getSession { response in
        
        context.csrftoken = Vacancies.csrfTokenBy(cookie: response.cookie)
        context.middlewarecsrftoken = Vacancies.middlewareCSRFTokenBy(htmlData: response.data)
        context.cookie = response.cookie
        
        completion()
      }
    }
  
  public func vacanciesAction(
    context: DouHTTPClient.Context,
    completion: @escaping VoidCallback) {
      
      self.discordHTTPClient.context.offSet = .zero
      
      self.vacancies = []
      
      DispatchQueue.global(qos: .background).async { [weak self] in
        
        guard let `self` = self else { return }
        
        self.fetchVacanciesAction(completion: {
          
          completion()
        })
      }
    }
  
  public func fetchVacanciesAction(completion: @escaping VoidCallback) {
    
    self.discordHTTPClient.getData(
      context: self.discordHTTPClient.context) { [weak self] response in
        
        guard let `self` = self else { return }
        
        let tempVacancies = Vacancies.collectionBy(htmlData: response.html)
        
        self.discordHTTPClient.context.offSet += response.num
        
        self.vacancies.append(contentsOf: tempVacancies)
        
        if !tempVacancies.isEmpty {
          
          self.fetchVacanciesAction(completion: completion)
          
        } else {
          
          completion()
        }
      }
  }
}
