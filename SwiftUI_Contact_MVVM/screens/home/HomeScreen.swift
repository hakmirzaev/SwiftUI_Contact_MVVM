//
//  HomeScreen.swift
//  SwiftUI_Contact_MVVM
//
//  Created by Bekhruz Hakmirzaev on 26/04/23.
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    @State private var showingEdit = false
    
    func delete(indexSet: IndexSet) {
        let contact = viewModel.contacts[indexSet.first!]
        viewModel.apiContactDelete(contact: contact, handler: { value in
            if value {
                viewModel.apiContactList()
            }
        })
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(viewModel.contacts, id: \.self) { contact in
                        ContactCell(contact: contact).onLongPressGesture{
                            self.viewModel.tempContact = contact
                            self.showingEdit.toggle()
                        }.sheet(isPresented: $showingEdit, content: {
                            EditScreen(contact: viewModel.tempContact)
                        })
                    }.onDelete(perform: delete)
                }.listStyle(PlainListStyle())
                
                if viewModel.isLoading{
                    ProgressView()
                }
            }
            
            .navigationBarItems(leading: Button(action: {
                viewModel.apiContactList()
            }, label: {
                Image("ic_refresh").resizable().foregroundColor(.white)
            }), trailing: NavigationLink(destination: CreateScreen(), label: {
                Image("ic_add").resizable().foregroundColor(.white)
            }))
            .navigationBarTitle("SwiftUI MVVM", displayMode: .inline)
            .toolbarBackground(
                .gray,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }.onAppear{
            viewModel.apiContactList()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
