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
struct TravelItem: Identifiable {
    let id = UUID()
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
        GeometryReader { geometry in
            
         ZStack {
                Color.customBackgroundColor
                    .ignoresSafeArea()
             ScrollView {
                 VStack {
                     HStack {
                         TextField("必要なものを追加", text: $inputItem)
                         //    .textFieldStyle(.roundedBorder)
                           //  .background(.white)
                             .overlay(
                                RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                                    .stroke(Color.green, lineWidth: 1.5)
                                    .padding(-7.0)
                             )
                             .padding(EdgeInsets(
                                top: 10,
                                leading: 20,
                                bottom: 5,
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
                        
                        
                List {
                    ForEach(travelLists) { item in
                        HStack {
                            Image(systemName:
                                    item.isChecked ? "square.fill" : "square")
                            .onTapGesture {
                                if let index = travelLists.firstIndex(where: { $0.id == item.id }) {
                                    travelLists[index].isChecked.toggle()
                                }
                            }
                            Text(item.item)
                        } // HStack
                                
                } // ForEach
                 .onDelete(perform: deleteItems)
                  .listRowSeparatorTint(.green)
              } // List
                .scrollContentBackground(.hidden)
               
                     
              } // VStack
                    .frame(minWidth: geometry.size.width, minHeight: geometry.size.height)
             } // ScrollView
                .scrollDismissesKeyboard(.immediately)
            } // ZStack
        } // GeometryReader
    } // body
    func deleteItems(at offsets: IndexSet) {
        travelLists.remove(atOffsets: offsets)
    }
    
} // ItemListView



#Preview {
    ItemListView()
}
