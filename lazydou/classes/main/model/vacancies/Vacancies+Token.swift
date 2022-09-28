//
//  Vacancies+Token.swift
//

import Foundation

import NOFoundation

import SwiftSoup

// MARK: - Tokens -

extension Vacancies {
  
  public static func csrfTokenBy(cookie: String) -> String? {
    
    guard let csrftoken = cookie.matchesBy(regex: #"(csrftoken=)(\w+)"#).first
    else { return nil }
   
    return csrftoken
  }
  
  public static func middlewareCSRFTokenBy(htmlData: Data) -> String? {
    
    guard let html = String(data: htmlData, encoding: .utf8) else { return nil }
    
    do {
      
      let htmlDocument = try SwiftSoup.parse(html)
      
      let scripts = try htmlDocument.select("script")
      
      guard let envScript = scripts.last() else { return nil }
      
      let scriptBody = envScript.data()
      
      guard var rawCsrfMiddlewareToken = scriptBody
        .matchesBy(regex: #"window.CSRF_TOKEN = (.)*;"#).first,
            !rawCsrfMiddlewareToken.isEmpty else { return nil }
      
      rawCsrfMiddlewareToken = rawCsrfMiddlewareToken
        .replacingOccurrences(of: "\"", with: "")
      rawCsrfMiddlewareToken = rawCsrfMiddlewareToken
        .replacingOccurrences(of: "window.CSRF_TOKEN = ", with: "")
      rawCsrfMiddlewareToken = rawCsrfMiddlewareToken
        .replacingOccurrences(of: ";", with: "")
      
      return rawCsrfMiddlewareToken as String
      
    } catch {
      
      NOSTDOUT.display(error)
      
      return nil
    }
  }
}
