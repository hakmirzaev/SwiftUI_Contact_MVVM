//
//  EditScreen.swift
//  SwiftUI_Contact_MVVM
//
//  Created by Bekhruz Hakmirzaev on 26/04/23.
//

import SwiftUI

struct EditScreen: View {
    @ObservedObject var viewModel = EditViewModel()
    @Environment(\.presentationMode) var presentation
    var contact: Contact
    @State var nameText = ""
    @State var phoneText = ""
    
    var body: some View {
        NavigationView{
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
                            viewModel.apiContactEdit(contact: Contact(id: contact.id!, name: nameText, phone: phoneText), handler: { value in
                                if value {
                                    self.presentation.wrappedValue.dismiss()
                                }
                            })
                        }
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Edit").foregroundColor(.white)
                            Spacer()
                        }.padding(12).background(.blue).cornerRadius(10)
                    })
                    Spacer()
                }.padding(20)
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarTitle("Edit Contact", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(
                .gray,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }.onAppear{
            nameText = contact.name!
            phoneText = contact.phone!
        }
    }
}

struct EditScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditScreen(contact: Contact(name: "", phone: ""))
    }
}
