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
import Combine


struct ContentView: View {

    
    //这部分声明了要使用的变量
    
    //这俩是用于刷新组件而使用的
    @State var show = DATAModel.NasmData.show
    @State var showWindows = DATAModel.NasmData.showWindows
    
    //NASM编译器路径
    @State var nasmcompath = DATAModel.NasmData.nasmcompath
    
    //
    @State var filename = DATAModel.NasmData.filename
    
    //nasm文件的内容
    @State var nasminside = DATAModel.NasmData.nasminside

    @State var commandresult = DATAModel.NasmData.commandresult
    
    @State var nasmcomoutputpath = DATAModel.NasmData.nasmcomoutputpath
    
    //文件地址
    @State var Openfilepath = DATAModel.NasmData.Openfilepath
    
    @State var ShellPath = DATAModel.NasmData.ShellPath
    
    
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
                        ASMOpener.allowedFileTypes = ["asm","nas"]
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
                                        var printPath = TheFile
                                        printPath.removeFirst(7)
                                        commandresult = DATAModel.CommandResult.OpenFilePath + printPath
                                        Openfilepath = printPath
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
                .keyboardShortcut("o", modifiers: [.command])
                
                
                
                
                Button("保存"){
                    let ASMSaver: NSSavePanel = NSSavePanel()
                        ASMSaver.prompt = "Save"
                        ASMSaver.worksWhenModal = true
                        ASMSaver.title = "保存文件"
                        ASMSaver.showsTagField = false
                        ASMSaver.nameFieldStringValue = "Untitle"+".asm"
                        ASMSaver.message = "请选择一个文件夹来保存文件"
                        ASMSaver.runModal()
                    let chosenfile = ASMSaver.url
                    if (chosenfile != nil){
                        var Saver = chosenfile!.absoluteString //选择后的文件地址
                        
                        Saver.removeFirst(7)
                        print(Saver)
                        
                        do {
                            try nasminside.write(toFile: Saver, atomically: true, encoding: String.Encoding.utf8)
                            commandresult = "Save Successful"
                        }catch{
                            commandresult = "File did not save"
                        }
   
                    }else{
                        commandresult = "File path can not be nil"
                    }
                }
                .keyboardShortcut("s",modifiers: [.command])
                
                
                
                
                Button("导出编译文件"){
                    let ShellCommand = "nasm -f bin ~" + Openfilepath
                    //runShell(["sudo -"])
                    //runShell("sudo -s")
                    runShell("william")
                    let Shelloutput = runShell(ShellCommand)
                    print(Shelloutput)
                    commandresult = Shelloutput
                    if (showWindows == true){
                        showWindows = false
                    }else{
                        showWindows = true
                    }
                }
                .keyboardShortcut("e", modifiers: [.command])
                
            }
            .frame(width:670,alignment: .leading)
            
            
            
            Text("Design for editing and compiling assembly")
                .font(.subheadline)
                .foregroundColor(Color.white)
        
            
            
            if(showWindows == true){
                HStack{
                    TextField(ShellPath, text: $ShellPath)
                        .frame(width: 332, height: 30,alignment:.center)
                    TextField(nasmcompath, text: $nasmcompath)
                        .frame(width: 332, height: 30,alignment:.center)
                    
                }
            }else{
                HStack{
                    TextField(ShellPath, text: $ShellPath)
                        .frame(width: 332, height: 30,alignment:.center)
                    TextField(nasmcompath, text: $nasmcompath)
                        .frame(width: 332, height: 30,alignment:.center)
                    
                }
            }
            //SourceCodeTextEditor组件，用来输入程序源码的部分
            //这个组件是使用开源文本编辑软件中的一部分，用来显示具体的程序行数以及语法高亮
            //原程序中只有Java，JS，Python以及Swift语言的高亮格式
            //通过分析这些文件的组成方式，新建了一个Assembly语言的高亮格式文件
            //这里使用if...else...语句是为了在从文件中打开并加载文件内容后能够让组件正确显示出来文件内容的
            //如果不实用这个语句就无法完成组件的刷新
            //这个应该是原程序的问题，那个开源软件也是不能完成View的刷新
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
            
            
            
        
            TextEditor(text: .constant(commandresult)) //使用了text: .constant()可以有效地禁止编辑TextEditor的内容
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


