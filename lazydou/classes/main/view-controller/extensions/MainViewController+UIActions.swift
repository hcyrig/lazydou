//
//  MainViewController+Actions.swift
//

import AppKit

import lazyapi

extension MainViewController {
  
  @IBAction func exportAction(_ sender: NSButton) {
    
    fetchDestinationFolderURLAction()
  }
  
  @objc public func cityButtonAction(_ sender: NSPopUpButton) {
    
    if sender.title == Cities.first {
      self.discordHTTPClient.context.city = nil
      return
    }
    
    self.discordHTTPClient.context.city = sender.title
  }
  
  @objc public func categoryButtonAction(_ sender: NSPopUpButton) {
    
    if sender.title == Categories.first {
      self.discordHTTPClient.context.category = nil
      return
    }
    
    self.discordHTTPClient.context.category = sender.title
  }
  
  @objc public func experiencesButtonAction(_ sender: NSPopUpButton) {
    
    guard let experience = Experiences.first(where: { $0.title == sender.title })?.value
    else {
      self.discordHTTPClient.context.experience = nil
      return
    }
    
    if experience == Experiences.first?.value {
      self.discordHTTPClient.context.experience = nil
      return
    }
    
    self.discordHTTPClient.context.experience = experience
  }
}
