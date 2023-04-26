//
//  EditViewModel.swift
//  SwiftUI_Contact_MVVM
//
//  Created by Bekhruz Hakmirzaev on 26/04/23.
//

import Foundation

class EditViewModel: ObservableObject {
    @Published var isLoading = false
    
    func apiContactEdit(contact: Contact, handler: @escaping (Bool) -> Void) {
        isLoading = true
        AFHttp.put(url: AFHttp.API_CONTACT_UPDATE + (contact.id)!, params: AFHttp.paramsContactCreate(contact: contact), handler: { response in
            self.isLoading = false
            switch response.result {
            case .success:
                print(response.result)
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        })
    }
}
