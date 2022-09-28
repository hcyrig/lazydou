//
//  MainWindowController.swift
//

import Foundation

import AppKit

import NOFoundation

final class MainWindowController: NSWindowController {
  
  override func windowDidLoad() {
    
    applyWindowControllerRestorationName("dou-window-controller")
    
    super.windowDidLoad()
  }
}
