//
//  ContentView.swift
//  SwiftUIListCellSelection
//
//  Created by slava bily on 20.07.2021.
//

import SwiftUI

class ClaimsSelection: ObservableObject {
    @Published var multiselection = Set<Claim>()
    
    func isSelected(_ claim: Claim) -> Bool {
        for _ in multiselection {
            if multiselection.contains(claim) {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func selection(of claim: Claim) {
         
        if multiselection.contains(claim) {
            multiselection.remove(claim)
        } else {
            multiselection.insert(claim)
        }
    }
}

struct Claim: Equatable, Hashable {
    var id: Int
    var description: String
}


struct ClaimCell: View {
    @ObservedObject var claimsSelection: ClaimsSelection
     
    var claim: Claim
    
    var body: some View {
        ZStack {
            claimsSelection.isSelected(claim) ? Color.green : Color.white
            Text(claim.description)
                .padding()
        }
    }
}

struct ContentView: View {
    @StateObject var claimsSelection = ClaimsSelection()
 
    var claims = [Claim(id: 0, description: "Value 1"),
                  Claim(id: 1, description: "Value 2"),
                  Claim(id: 2, description: "Value 3")]
    
    var body: some View {
        VStack {
            Spacer()
            List(claims, id: \.id) { claim in
                ClaimCell(claimsSelection: claimsSelection, claim: claim)
                    .onTapGesture {
                        claimsSelection.selection(of: claim)
                    }
            }
            .padding()
            .frame(maxHeight:250)
            .background(Color.gray)
            .cornerRadius(8)
            Spacer()
            Text("Multiselection result: \(claimsSelection.multiselection.count) claims selected")
                .onTapGesture {
                    print("\n \(claimsSelection.multiselection.description)")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
