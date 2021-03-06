//
//  Color.swift
//  CanvasGraphics
//
//  Created by Russell Gordon on 11/12/18.
//  Copyright © 2018 Russell Gordon. All rights reserved.
//

import Foundation

/// Used to set colors of figures generated by CanvasGraphics framework
open class Color {
    
    // FIXME: Need more research into how to properly write a class that handles invalid property geting/setting
    //
    // If I want to write a class that "fixes" or rationalizes invalid values provided to it, when:
    //
    // 1. initializing a new object
    // 2. setting properties of the object
    //
    // ...what is the correct way to do this in Swift?
    //
    // The purpose of the Color class I have written is to take hue, saturation, brightness,
    // and alpha values range between 0-360, 0-100, 0-100, and 0-100 respectively.
    //
    // My thought was that property observers are the answer:
    //
    // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html
    //
    // but Apple's documentation explicitly states that property observers are not called when
    // a property is set from within an initializer:
    //
    // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID204
    //
    // NOTE
    //
    //  When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.
    //
    // As you can see, I am using private functions that are called from the initializer
    // and the property observer (so I am not duplicating logic to rationalize the passed values).
    //
    // However, this seems inelegant.
    //
    // All in all, after doing more reading about failable initializers:
    //
    // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203
    //
    // ... it really seems like perhaps I should NOT be trying to rationalize invalid values. Perhaps, instead, I should just fail to initialize an object if bad values are provided.
    //
    // Future self – something to think about.
    
    // Static properties for convenience for basic colors
    public static let black : Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    public static let white : Color = Color(hue: 0, saturation: 0, brightness: 100, alpha: 100)
    public static let red : Color = Color(hue: 0, saturation: 80, brightness: 90, alpha: 100)
    public static let orange : Color = Color(hue: 30, saturation: 80, brightness: 90, alpha: 100)
    public static let yellow : Color = Color(hue: 60, saturation: 80, brightness: 90, alpha: 100)
    public static let green : Color = Color(hue: 120, saturation: 80, brightness: 90, alpha: 100)
    public static let blue : Color = Color(hue: 240, saturation: 80, brightness: 90, alpha: 100)
    public static let purple : Color = Color(hue: 270, saturation: 80, brightness: 90, alpha: 100)
    
    var hue: Float = 0.0 {
        didSet {
            hue = self.rationalizeToSinglePositiveRotation(hue)
            self.translatedHue = CGFloat(self.hue / 360)
        }
    }
    
    var saturation: Float = 0.0 {
        didSet {
            saturation = self.rationalizePercentage(saturation)
            self.translatedSaturation = CGFloat(self.saturation / 100)
        }
    }
    
    var brightness: Float = 0.0 {
        didSet {
            brightness = self.rationalizePercentage(brightness)
            self.translatedBrightness = CGFloat(self.brightness / 100)
        }
    }
    
    var alpha: Float = 0.0 {
        didSet {
            alpha = self.rationalizePercentage(alpha)
            self.translatedAlpha = CGFloat(self.alpha / 100)
        }
    }
    
    var translatedHue : CGFloat = 0.0
    var translatedSaturation : CGFloat = 0.0
    var translatedBrightness : CGFloat = 0.0
    var translatedAlpha : CGFloat = 0.0
    
    /// Sets the desired colour.
    ///
    /// To understand hue, saturation, and brightness, see [this summary](http://russellgordon.ca/lcs/HSB_Color_Model_Summary_Swift.pdf) or [this for more details](https://learnui.design/blog/the-hsb-color-system-practicioners-primer.html).
    /// - parameter hue: Value between 0 and 360 describing hue
    /// - parameter saturation: Value between 0 and 100 describing amount of saturation
    /// - parameter brightness: Value between 0 and 100 describing brightness
    /// - parameter alpha: Value between 0 and 100 describing opacity

    public init(hue: Float, saturation: Float, brightness: Float, alpha: Float) {
        
        // Set with provided values, but translate to valid values first
        self.hue = rationalizeToSinglePositiveRotation(hue)
        self.saturation = rationalizePercentage(saturation)
        self.brightness = rationalizePercentage(brightness)
        self.alpha = rationalizePercentage(alpha)
        
        // Prepare values to provide to NSColor initializer
        self.translatedHue = CGFloat(self.hue / 360)
        self.translatedSaturation = CGFloat(self.saturation / 100)
        self.translatedBrightness = CGFloat(self.brightness / 100)
        self.translatedAlpha = CGFloat(self.alpha / 100)
        
    }
    
    // Allow integer inputs to be used to set color values as well
    public convenience init(hue: Int, saturation: Int, brightness: Int, alpha: Int) {
        
        self.init(hue: Float(hue), saturation: Float(saturation), brightness: Float(brightness), alpha: Float(alpha))
        
    }
    
    // Takes a given number of degrees and translates to range between 0 and 360
    fileprivate func rationalizeToSinglePositiveRotation(_ value : Float) -> Float {
        
        if value < 0 {
            return 0.0
        } else if value > 360 {
            return value.truncatingRemainder(dividingBy: 360)
        }
        
        return value
        
    }
    
    // Takes a given value and translates to a percentage between 0 and 100
    fileprivate func rationalizePercentage(_ value : Float) -> Float {
        
        if value < 0 {
            return 0.0
        } else if value > 100 {
            return value.truncatingRemainder(dividingBy: 100)
        }
        
        return value
        
    }
    
}
