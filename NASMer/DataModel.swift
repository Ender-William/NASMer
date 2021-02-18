//
//  DataModel.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/2/14.
//

import Foundation
import Combine

class DATAModel{
    struct NasmData {
        static let showWindows = true
        static let show = false

        //NASM编译器路径
        static let nasmcompath:String = "/usr/local/Cellar/nasm/2.15.05/bin/nasm"

        //nasm文件的内容
        static let nasminside = ";////可以开心地在这里写汇编啦\n;////本软件使用的编译器是NASM\n;////编码格式为UTF-8"

        static let filename = ""

        static let commandresult = "" //获取CommandLineTool的返回值
    }
}
