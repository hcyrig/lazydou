//
//  MainViewController.swift
//

import AppKit

import NOFoundation

import lazyapi

class MainViewController: BaseViewController {
  
  @IBOutlet weak var contentStackView: NSStackView!
  @IBOutlet weak var cityPopUp: NSPopUpButton!
  @IBOutlet weak var categoryPopUp: NSPopUpButton!
  @IBOutlet weak var experiencesPopUp: NSPopUpButton!
  @IBOutlet weak var searchTextField: NSTextField!
  
  @IBOutlet private weak var exportButton: NSButton!
  
  var vacancies: [Vacancies.Vacancy] = []
  var discordHTTPClient: DouHTTPClient!
  
  override func setupInterface() {
    super.setupInterface()
    
    discordHTTPClient = DouHTTPClient(context: .init())
    
    searchTextField.delegate = self
    
    setupPopUpsLists()
  }
}
