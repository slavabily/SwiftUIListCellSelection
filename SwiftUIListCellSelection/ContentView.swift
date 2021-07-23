//
//  ContentView.swift
//  SwiftUIListCellSelection
//
//  Created by slava bily on 20.07.2021.
//

import SwiftUI

class ClaimsSelection: ObservableObject {
    @Published var multiselection = Set<Claim>()
}

struct Claim: Equatable, Hashable {
    var id: Int
    var description: String
}


struct ClaimCell: View {
    @ObservedObject var claimsSelection: ClaimsSelection
    @Binding var selectedClaim: Claim?
    var claim: Claim
    
    var body: some View {
        ZStack {
            isSelected() ? Color.green : Color.white
            Text(claim.description)
                .padding()
        }
    }
    
    func isSelected() -> Bool {
        for _ in claimsSelection.multiselection {
            if claimsSelection.multiselection.contains(claim) {
                return true
            } else {
                return false
            }
        }
        return false
    }
}

struct ContentView: View {
    @StateObject var claimsSelection = ClaimsSelection()
    @State var selectedClaim: Claim?
 
    var claims = [Claim(id: 0, description: "Value 1"),
                  Claim(id: 1, description: "Value 2"),
                  Claim(id: 2, description: "Value 3")]
    
    var body: some View {
        VStack {
            Spacer()
            List(claims, id: \.id) { claim in
                ClaimCell(claimsSelection: claimsSelection, selectedClaim: $selectedClaim, claim: claim)
                    .onTapGesture {
                        selection(of: claim)
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
    
    func selection(of claim: Claim) {
        selectedClaim = claim
        
        guard selectedClaim != nil else { return }
        
        if claimsSelection.multiselection.contains(selectedClaim!) {
            claimsSelection.multiselection.remove(selectedClaim!)
        } else {
            claimsSelection.multiselection.insert(selectedClaim!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
