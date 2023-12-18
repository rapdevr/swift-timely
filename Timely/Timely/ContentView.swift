//
//  ContentView.swift
//  Timely
//
//  Created by Rishi Thiahulan on 13/12/2023.
//

import SwiftUI
import Foundation
import AuthenticationServices

class ViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // controller setup code goes here
    }
    
    @IBAction func didTapGetNameButton(_ sender: UIButton) {
        requestName()
    }
    
    func requestName() {
        // create an instance of the apple ID provider
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        // make a request for the users name
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName]
        
        // create an authorisation controller with the request
        let authorisationController = ASAuthorizationController(authorizationRequests: [request])
        
        // set the delegate to handle authorisation responses
        authorisationController.delegate = self
        
        // set the presentation context provider
        authorisationController.presentationContextProvider = self
        
        // perform the request
        authorisationController.performRequests()
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // handle a good auth
        if let appleIDCred = authorization.credential as? ASAuthorizationAppleIDCredential {
            // User's name is available in cred
            let name = appleIDCred.fullName
            
            
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // handle any errors
        print("Auth error! \(error.localizedDescription)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // specify the presentation anchor
        return self.view.window!
    }
    
    
}

struct ContentView: View {
    var body: some View {
        
        @State var Origin: String = ""
        
        Text("Good \(getTime())! ")
            .padding(.top)
            
            
        
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, !")
        }
        .padding()
        
        // text fields for inputting stations
        VStack {
            
        }
            TextField("Where From?", text: $Origin)
                .textFieldStyle(.roundedBorder)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                .autocorrectionDisabled()
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
        }
    }

func getTime() -> String {
    let CurrentDate = Date()
    let calendar = Calendar.current
    
    let hour = calendar.component(.hour, from: CurrentDate)
    
    if hour > 12 {
        return "Afternoon"
    }
    else {
        return "Morning"
    }
}

#Preview {
    ContentView()
}
