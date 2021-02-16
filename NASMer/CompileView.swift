//
//  CompileView.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/1/30.
//

import SwiftUI
//主程序
struct CompileView: View {
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                CompileFormatPicker()  //编译格式选择器
            }
            //CompileFormatPicker()  //编译格式选择器
            NasmOutputPath()    //编译后的文件输出地址
        }
    }
}
//预览程序
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        CompileView()
            .preferredColorScheme(.dark)
            .frame(width: 400, height: 200)
            .previewDisplayName("NASMer - How to Compile")
    }
}


//编译格式选择器
struct CompileFormatPicker: View {
    @State var CompileFormat:String = "" //Specifying the Output File Format
    //
    //e.g. Command : nasm -f bin program.asm -o program.com
    //
    @State var CompileFileName:String = "" //Specifying the Output File Name
    var body: some View {
        VStack {
            Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("如何编译")) {
                Text("已选路径").tag(1)
                Text("Shell命令").tag(2)
            }
            .frame(width: 160, height: 50,alignment: .leading)
            Picker(selection: .constant(1), label: Text("编译格式")) {
                Text("bin").tag(1)
                Text("elf32").tag(2)
                Text("elf64").tag(3)
                Text("elf").tag(4)
                Text("obj").tag(5)
                Text("macho").tag(6)
                Text("macho32").tag(7)
                Text("macho64").tag(8)
            }
            .frame(width: 160, height: 50,alignment: .leading)
            .preferredColorScheme(.dark)
        }
    }
}

//nasm编译器路径控件
struct NasmOutputPath: View {
    @State var nasmcomoutputpath:String = "/usr/local/Cellar/nasm/2.15.05/bin/nasm"
    @State var could_i_edit = true
    var body: some View {
        VStack(alignment:.leading) {
            Text("编译后文件保存导出地址")
                .foregroundColor(.green)
                .font(.headline)
            TextField(nasmcomoutputpath, text: $nasmcomoutputpath)
                .frame(width: 380, height: 30,alignment:.center)
        }
    }
}
