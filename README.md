# LineNumberTextView #

LineNumberTextView is a simple subclass of NSTextView, which adds line numbers to the left of the text view. Like this:

![Example](https://raw.githubusercontent.com/raphaelhanneken/line-number-text-view/master/screenshot_01.png)

## Why does this project exist? ##

Curiosity. I was just wondering how to do this, since there is no build in solution for this, but so many programs display line numbers. Therefore I don't think this is an ideal solution, but it satisfied me.

## How to use it ##

First of all you need to [download](https://github.com/raphaelhanneken/line-number-text-view/archive/master.zip) this project and build the framework. You can then add the binary to your project. Just drag and drop it onto "Embedded Binaries", like so:

![Project](https://raw.githubusercontent.com/raphaelhanneken/line-number-text-view/master/screenshot_02.png)

Next, in the Interface Builder, you have to change the class of your NSTextView to "LineNumberTextView".

![TextView class](https://raw.githubusercontent.com/raphaelhanneken/line-number-text-view/master/screenshot_03.png)

You can now change the foreground and background color, of the line number gutter, right within the Interface Builder:

![Interface Builder](https://raw.githubusercontent.com/raphaelhanneken/line-number-text-view/master/screenshot_04.png)

And you're done. Build and run your project and your TextView should have a line number view.

### How to change the colors programmatically ###
As simple as this:
```swift
textView.gutterForegroundColor = NSColor(calibratedHue: 0, saturation: 0, brightness: 0, alpha: 1)
textView.gutterBackgroundColor = NSColor(calibratedHue: 0, saturation: 0, brightness: 0.9, alpha: 1)
```


----------

### License ###

The MIT License (MIT)

Copyright (c) 2015 Raphael Hanneken

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
