//
//  ContentView.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/1/27.
//

import Foundation
import SwiftUI
import Cocoa
//import SavannaKit
//import SourceEditor



struct ContentView: View {
    
    //这俩是用于刷新组件而使用的
    @State private var showWindows = true
    @State private var show = false
    
    //NASM编译器路径
    @State var nasmcompath:String = "/usr/local/Cellar/nasm/2.15.05/bin/nasm"
    
    //nasm文件的内容
    @State public var nasminside = ";////可以开心地在这里写汇编啦\n;////本软件使用的编译器是NASM\n;////编码格式为UTF-8"
    
    @State var filename = ""
    
    @State var commandresult = "" //获取CommandLineTool的返回值
    

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center){
                
                Text("Hello, Assembly World！")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                
                Button("编译前的设定"){
                    let detailView = CompileView()
                    let controller = DetailWC(rootView: detailView)
                    controller.window?.title = "NASMer - How to Compile"
                    controller.showWindow(nil)
                    if (showWindows == true){
                        showWindows = false
                    }else{
                        showWindows = true
                    }
                }
                
                
                Button("\(self.show ? "打开文件":"打开文件")"){
                    
                    let ASMOpener: NSOpenPanel = NSOpenPanel()
                        ASMOpener.prompt = "Open"
                        ASMOpener.worksWhenModal = true
                        ASMOpener.allowsMultipleSelection = false
                        ASMOpener.canChooseDirectories = false
                        ASMOpener.resolvesAliases = true
                        ASMOpener.title = "打开文件"
                        //myFiledialog.message = message
                        ASMOpener.runModal()
                    let chosenfile = ASMOpener.url
                        if (chosenfile != nil)
                        {
                            let TheFile = chosenfile!.absoluteString //选择后的文件地址
                            
                            print(TheFile)
                            filename = TheFile
                            
                            let fileManager = FileManager.default
                            if let url = URL.init(string: TheFile) {
                                if fileManager.fileExists(atPath: url.path) {
                                    let txtData = fileManager.contents(atPath: url.path)
                                    //var dataArray:[[Substring]] = []
                                    if txtData == nil {
                                        //return nil
                                        commandresult = "nil !"
                                    }
                                    print(txtData as Any)
                                    //print(txtData!.availableStringEncodings)
                                    let readString = String(data: txtData!, encoding: String.Encoding.utf8)
                                    if readString != nil{
                                        
                                        print("readString: \(String(describing: readString))")
                                        nasminside = String(readString!)
                                        print("nasminside: \(nasminside)")
                                        commandresult = "Read Successful!"
                                        //print(dataArray)
                                        
                                    }else{
                                        commandresult = "Format error"
                                    }
                                }else {
                                    print("Path loss file is not exists")
                                    //return nil
                                }
                            }
                            print([])
                        }
                        else
                        {
                            commandresult = "Operation Cancel!"
                        }
                    print(nasminside)
                    self.show.toggle()
                    print()
                    
                    //用来强制刷新SourceCodeTextEditor组件的
                    //我也不知道为啥必须使用一个关联的逻辑才能刷新那个组件，可能是那个组建的问题吧或者是
                    //苹果的View的刷新机制的问题吧，艹，简直恶心透了！！！
                    //这个组件千万不能删，删掉了就不能正常刷新了
                    
                    if (showWindows == true){
                        showWindows = false
                    }else{
                        showWindows = true
                    }
                }
                
                
                Button("保存"){
                    let ASMSaver: NSSavePanel = NSSavePanel()
                        ASMSaver.prompt = "Save"
                        ASMSaver.worksWhenModal = true
                        ASMSaver.title = "保存文件"
                        ASMSaver.showsTagField = false
                        //ASMSaver.nameFieldStringValue = "Untitle"+".asm"
                        ASMSaver.runModal()
                    let chosenfile = ASMSaver.url
                    if (chosenfile != nil){
                        let Saver = chosenfile!.absoluteString //选择后的文件地址
                        let directory = FileManager.default.currentDirectoryPath
                        let directoryURL = URL(fileURLWithPath: Saver,isDirectory: true)
                        
                        print(directoryURL)
                        
                        
                        
                        
                        
                        commandresult = Saver
                        print(commandresult)
                        
                        do{
                            try! nasminside.write(toFile: Saver, atomically:  true , encoding: String.Encoding.utf8)

                        }catch{
                            
                        }
                        
                        
                    }else{
                        print("Nil")
                    }
                }
                
                Button("导出编译文件"){
                    
                }
            }
            .frame(width:670,alignment: .leading)
            
            Text("Design for editing and compiling assembly")
                .font(.subheadline)
                .foregroundColor(Color.white)
        
            if(showWindows == true){
                TextField(nasmcompath, text: $nasmcompath)
                    .frame(width: 670, height: 30,alignment:.center)
            }else{
                TextField(nasmcompath, text: $nasmcompath)
                    .frame(width: 670, height: 30,alignment:.center)
            }
            
            //SourceCodeTextEditor组件，用来输入程序源码的部分
            //这个组件是使用开源文本编辑软件中的一部分，用来显示具体的程序行数以及语法高亮
            //原程序中只有Java，JS，Python以及Swift语言的高亮格式
            //通过分析这些文件的组成方式，新建了一个Assembly语言的高亮格式文件
            //这里使用if...else...语句是为了在从文件中打开并加载文件内容后能够让组件正确显示出来文件内容的
            //如果不实用这个语句就无法完成组件的刷新
            //这个应该是原程序的问题，那个开源软件也是不能完成内容的刷新
            if(showWindows == true){
                SourceCodeTextEditor(text: $nasminside)
                //TextEditor(text:$nasminside)
                    .frame(width: 670, height: 400.0,alignment:.center)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .font(.custom("Monaco", size: 16))
            }else{
                SourceCodeTextEditor(text: $nasminside)
                //TextEditor(text:$nasminside)
                    .frame(width: 670, height: 400.0,alignment:.center)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .font(.custom("Monaco", size: 16))
            }
            
            
            
        
            TextEditor(text: $commandresult)
                .frame(width: 670, height:70 ,alignment:.center)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .font(.custom("Monaco", size: 14))
                
            
        }
        .frame(minWidth: 670, minHeight: 50,alignment:.leading)
        //.padding()
        //.frame(width: 450, height: 60, alignment: .leading)
    }
    
}


struct ContentView_Previews: PreviewProvider  {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .frame(width: 700, height: 600)
            .previewDisplayName("NASMer")
    }
}


