//
//  MainViewController+TextFieldDelegate.swift
//

import AppKit

extension MainViewController: NSTextFieldDelegate {
  
  func controlTextDidChange(_ obj: Notification) {
    
    guard let incommingTextField = obj.object as? NSTextField else { return }
    
    handleSearchTextField(textField: incommingTextField)
  }
  
  private func handleSearchTextField(textField: NSTextField) {
    
    guard textField == self.searchTextField else { return }
    
    self.discordHTTPClient.context.searchText = textField.stringValue
  }
}
