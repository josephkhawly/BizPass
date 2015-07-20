# FTIAutomaticKeyboardAdjustment
An addition to UIViewController that automatically rearranges constraints to the bottom of the view (or bottom layout guide) to account for the keyboard when it's showing.

##Installing
Add these files to your project:

* UIViewController+FTIAutomaticKeyboardAdjustment.h
* UIViewController+FTIAutomaticKeyboardAdjustment.m

or add this to your podfile:

`````
pod 'FTIAutomaticKeyboardAdjustment'
`````

##Using
Just import the category!

`````
#import <FTIAutomaticKeyboardAdjustment/UIViewController+FTIAutomaticKeyboardAdjustment.h>
`````

##Demo
####Here's a fully configured UIViewController subclass
<img src="http://i.imgur.com/qXroFAi.png" width="537"/>

####Elements automatically move with no code required
<img src="https://dl.dropboxusercontent.com/u/3223776/Hosting/FTIKeyboardAdjusting.gif" width="347"/>

##License
The MIT License (MIT)

Copyright (c) 2015 Brendan Lee

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

