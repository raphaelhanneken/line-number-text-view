//
// LineNumberGutter.swift
// LineNumberTextView
// https://github.com/raphaelhanneken/line-number-text-view
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Raphael Hanneken
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Cocoa

private let GUTTER_WIDTH: CGFloat = 20.0


/// Adds line numbers to a NSTextField.
class LineNumberGutter: NSRulerView {

  ///  Initializes a LineNumberGutter and attaches it to the given text view.
  ///
  ///  - parameter textView: NSTextView to attach the LineNumberGutter to.
  ///
  ///  - returns: An initialized LineNumberGutter object.
  init(withTextView textView: NSTextView) {
    // Make sure everything's set up properly before initializing properties.
    super.init(scrollView: textView.enclosingScrollView, orientation: .VerticalRuler)

    // Set the rulers clientView to the supplied textview.
    self.clientView = textView
    // Define the ruler's width.
    self.ruleThickness = GUTTER_WIDTH
  }

  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  ///  Draws the line numbers.
  ///
  ///  - parameter rect: NSRect to draw the gutter view in.
  override func drawHashMarksAndLabelsInRect(rect: NSRect) {
    // Unwrap the clientView, the layoutManager and the textContainer, since we'll
    // them sooner or later.
    guard let textView      = self.clientView as? NSTextView,
              layoutManager = textView.layoutManager,
              textContainer = textView.textContainer,
              content       = textView.string else {
        return
    }

    // Get the range of the currently visible glyphs.
    let visibleGlyphsRange = layoutManager.glyphRangeForBoundingRect(textView.visibleRect, inTextContainer: textContainer)

    // Check how many lines are out of the current bounding rect.
    var lineNumber: Int = 1
    do {
      // Define a regular expression to find line breaks.
      let newlineRegex = try NSRegularExpression(pattern: "\n", options: [])
      // Check how many lines are out of view; From the glyph at index 0
      // to the first glyph in the visible rect.
      lineNumber += newlineRegex.numberOfMatchesInString(content, options: [], range: NSMakeRange(0, visibleGlyphsRange.location))
    } catch {
      return
    }

    // Get the index of the first glyph in the visible rect, as starting point...
    var firstGlyphOfLineIndex = visibleGlyphsRange.location

    // ...then loop through all visible glyphs, line by line.
    while firstGlyphOfLineIndex < NSMaxRange(visibleGlyphsRange) {
      // Get the character range of the line we're currently in.
      let charRangeOfLine  = (content as NSString).lineRangeForRange(NSRange(location: layoutManager.characterIndexForGlyphAtIndex(firstGlyphOfLineIndex), length: 0))
      // Get the glyph range of the line we're currently in.
      let glyphRangeOfLine = layoutManager.glyphRangeForCharacterRange(charRangeOfLine, actualCharacterRange: nil)

      var firstGlyphOfRowIndex = firstGlyphOfLineIndex
      var lineWrapCount        = 0

      // Loop through all rows (soft wraps) of the current line.
      while firstGlyphOfRowIndex < NSMaxRange(glyphRangeOfLine) {
        // The effective range of glyphs within the current line.
        var effectiveRange = NSRange(location: 0, length: 0)
        // Get the rect for the current line fragment.
        let lineRect = layoutManager.lineFragmentRectForGlyphAtIndex(firstGlyphOfRowIndex, effectiveRange: &effectiveRange, withoutAdditionalLayout: true)

        // Draw the current line number;
        // When lineWrapCount > 0 the current line spans multiple rows.
        if lineWrapCount == 0 {
          self.drawLineNumber(lineNumber, atYPosition: lineRect.minY)
        } else {
          break
        }

        // Move to the next row.
        firstGlyphOfRowIndex = NSMaxRange(effectiveRange)
        lineWrapCount++
      }

      // Move to the next line.
      firstGlyphOfLineIndex = NSMaxRange(glyphRangeOfLine)
      lineNumber++
    }

    // Draw another line number for the extra line fragment.
    if let _ = layoutManager.extraLineFragmentTextContainer {
      self.drawLineNumber(lineNumber, atYPosition: layoutManager.extraLineFragmentRect.minY)
    }
  }


  func drawLineNumber(num: Int, atYPosition yPos: CGFloat) {
    // Unwrap the text view.
    guard let textView = self.clientView as? NSTextView,
              font     = textView.font else {
      return
    }
    // Define attributes for the attributed string.
    let attrs = [NSFontAttributeName: font]
    // Define the attributed string.
    let attributedString = NSAttributedString(string: "\(num)", attributes: attrs)
    // Get the NSZeroPoint from the text view.
    let relativePoint    = self.convertPoint(NSZeroPoint, fromView: textView)
    // Calculate the x position, within the gutter.
    let xPosition        = GUTTER_WIDTH - (attributedString.size().width + 5)
    // Draw the attributed string to the calculated point.
    attributedString.drawAtPoint(NSPoint(x: xPosition, y: relativePoint.y + yPos))
  }
}