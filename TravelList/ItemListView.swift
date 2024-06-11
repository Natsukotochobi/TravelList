//
//  ItemListView.swift
//  TravelList
//
//  Created by natsuko mizuno on 2024/06/04.
//

import SwiftUI

// ボタンスタイルを定義する
struct BorderedRoundedButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    var color: Color = .blue
    private let disabledColor: Color = .init(uiColor: .lightGray)
    private let backgroundColor: Color = .white
    private let cornerRadius: CGFloat = 8.0
    private let lineWidth: CGFloat = 2.0
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .fontWeight(.bold)
            .foregroundColor(isEnabled ? color : disabledColor)
            .background(backgroundColor)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(isEnabled ? color : disabledColor, lineWidth: lineWidth))
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}

// 配列の要素をstructで定義
struct TravelItem {
    var isChecked: Bool
    var item: String
}

struct ItemListView: View {
    
    @State var inputItem: String = ""
    @State var travelLists: [TravelItem] = [
        TravelItem(isChecked: true, item: "着替え"),
        TravelItem(isChecked: false, item: "充電器"),
        TravelItem(isChecked: false, item: "化粧品")
    ]
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    TextField("必要なものを追加", text: $inputItem)
                        .textFieldStyle(.roundedBorder)
                        .padding(EdgeInsets(
                            top: 10,
                            leading: 10,
                            bottom: 20,
                            trailing: 20
                        )) // TextField
                    
                    Button(action: {
                        if !inputItem.isEmpty {
                            print("追加されました")
                            travelLists.append(
                                TravelItem(isChecked: false, item: inputItem)
                            )
                            inputItem = ""
                        } // if
                    }, label: {
                        Text("追加")
                    }) // Button
                    .buttonStyle(BorderedRoundedButtonStyle())
                    .padding(.trailing, 20)
                    .disabled(inputItem.isEmpty)
                } // HStack
                
                
                List(0 ..< travelLists.count, id:\.self) { index in
                    HStack {
                        Image(systemName:
                                travelLists[index].isChecked ? "square.fill" : "square")
                        .onTapGesture {
                            travelLists[index].isChecked.toggle()
                        }
                        Text(travelLists[index].item)
                    } // HStack
                    
                } // List
            } // VStack
        } // ZStack
        
        
        
        
    } // body
} // ItemListView

#Preview {
    ItemListView()
}
