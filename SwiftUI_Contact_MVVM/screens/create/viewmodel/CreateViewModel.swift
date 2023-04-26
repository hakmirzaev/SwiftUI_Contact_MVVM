//
//  CreateViewModel.swift
//  SwiftUI_Contact_MVVM
//
//  Created by Bekhruz Hakmirzaev on 26/04/23.
//

import Foundation

class CreateViewModel: ObservableObject {
    @Published var isLoading = false
    
    func apiContactCreate(contact: Contact, handler: @escaping (Bool) -> Void) {
        isLoading = true
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsContactCreate(contact: contact), handler: { response in
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
