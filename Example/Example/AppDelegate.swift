//
//  AppDelegate.swift
//  Example
//
//  Created by Raphael Hanneken on 10/12/15.
//  Copyright © 2015 Raphael Hanneken. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  /// Holds the main application window.
  var mainWindowController: MainWindowController!


  func applicationDidFinishLaunching(aNotification: NSNotification) {
    // Create a new window controller object.
    let mainWindowController = MainWindowController()

    // Display the associated window on screen.
    mainWindowController.showWindow(self)

    // Point the instance variable to the newly created window controller.
    self.mainWindowController = mainWindowController
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }
  
}

