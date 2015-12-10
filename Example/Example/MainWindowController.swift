//
//  MainWindowController.swift
//  Example
//
//  Created by Raphael Hanneken on 10/12/15.
//  Copyright © 2015 Raphael Hanneken. All rights reserved.
//

import Cocoa
import LineNumberTextView

class MainWindowController: NSWindowController {

  // Points to the NSTextView.
  @IBOutlet var text: LineNumberTextView!

  override var windowNibName: String {
    return "MainWindowController"
  }

  override func windowDidLoad() {
      super.windowDidLoad()

      // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
  }
    
}
