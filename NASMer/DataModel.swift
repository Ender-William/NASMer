//
//  DataModel.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/2/14.
//

import Foundation

public class DATAModel{
    
    public let data=Data()
    public let array=[UInt8]()
    public let str=""

    public let error: NSError? = nil

    public let nasmcompath:String = "/usr/local/Cellar/nasm/2.15.05/bin/nasm"
    public let could_i_edit = true
    public let nasminside = "" //nasm文件的内容
    public let IsItEmpty = true
    public let filename = "Filename"
    public let showFileChooser = false
    public let commandresult = "" //获取CommandLineTool的返回值
    public let documentURL = ""
    public let show = false
    //@Published var image:Image?
    //@Published var nimage:NSImage?
    public var fileName:String?
    public var fileURL:URL?
    
}
