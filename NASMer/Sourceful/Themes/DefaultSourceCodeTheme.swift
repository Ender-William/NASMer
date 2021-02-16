//
//  DefaultSourceCodeTheme.swift
//  SourceEditor
//
//  Created by Louis D'hauwe on 24/07/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation
import AppKit

public struct DefaultSourceCodeTheme: SourceCodeTheme {
	
	public init() {
		
	}
	
	private static var lineNumbersColor: NSColor {
		return NSColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
	}
	
	public let lineNumbersStyle: LineNumbersStyle? = LineNumbersStyle(font: NSFont(name: "Menlo", size: 16)!, textColor: lineNumbersColor)
	
	public let gutterStyle: GutterStyle = GutterStyle(backgroundColor: NSColor(red: 21/255.0, green: 22/255, blue: 31/255, alpha: 1.0), minimumWidth: 32)
	
	public let font = NSFont(name: "Menlo", size: 15)!
	
	public let backgroundColor = NSColor(red: 31/255.0, green: 32/255, blue: 41/255, alpha: 1.0)
	
	public func color(for syntaxColorType: SourceCodeTokenType) -> NSColor {
		
		switch syntaxColorType {
		case .plain:
			return .white
            
        case .command:
            return NSColor(red: 134/255, green: 193/255, blue: 102/255, alpha: 1.0)
            
		case .number:
			return NSColor(red: 116/255, green: 109/255, blue: 176/255, alpha: 1.0)
            
		case .string:
			return NSColor(red: 211/255, green: 35/255, blue: 46/255, alpha: 1.0)
			
		case .identifier:
			return NSColor(red: 225/255, green: 107/255, blue: 140/255, alpha: 1.0)
			
		case .keyword:
			return NSColor(red: 215/255, green: 0, blue: 143/255, alpha: 1.0)
			
		case .comment:
			return NSColor(red: 69.0/255.0, green: 187.0/255.0, blue: 62.0/255.0, alpha: 1.0)
			
		case .editorPlaceholder:
			return backgroundColor
		}
		
	}
	
}
