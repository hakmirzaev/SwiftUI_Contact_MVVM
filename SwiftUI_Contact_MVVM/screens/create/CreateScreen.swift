//
//  CreateScreen.swift
//  SwiftUI_Contact_MVVM
//
//  Created by Bekhruz Hakmirzaev on 26/04/23.
//

import SwiftUI

struct CreateScreen: View {
    @ObservedObject var viewModel = CreateViewModel()
    @Environment(\.presentationMode) var presentation
    @State var nameText = ""
    @State var phoneText = ""
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 20){
                Text("Name").fontWeight(.medium)
                TextField("Name", text: $nameText)
                    .padding(10).background(.gray.opacity(0.15)).cornerRadius(10)
                Text("Phone").fontWeight(.medium)
                TextField("Phone", text: $phoneText)
                    .padding(10).background(.gray.opacity(0.15)).cornerRadius(10)
                Button(action: {
                    if nameText.count != 0 && phoneText.count != 0 {
                        viewModel.apiContactCreate(contact: Contact(name: nameText, phone: phoneText), handler: { value in
                            if value {
                                self.presentation.wrappedValue.dismiss()
                            }
                        })
                    }
                }, label: {
                    HStack{
                        Spacer()
                        Text("Create").foregroundColor(.white)
                        Spacer()
                    }.padding(12).background(.blue).cornerRadius(10)
                })
                Spacer()
            }.padding(20)
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationBarTitle("Create Contact", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentation.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.left").foregroundColor(.white)
                .font(.system(size: 15))
        }))
        .toolbarBackground(
            .gray,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

struct CreateScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateScreen()
    }
}
