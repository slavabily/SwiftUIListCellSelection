//
//  ContentView.swift
//  SwiftUIListCellSelection
//
//  Created by slava bily on 20.07.2021.
//

import SwiftUI

struct Claim: Equatable, Hashable {
    var id: Int
    var description: String
}

struct ClaimCell: View {
    
    var claim: Claim
    @Binding var selectedClaim: Claim?
    
    var body: some View {
        ZStack {
            claim == selectedClaim ? Color.green : Color.white
            Text(claim.description)
                .padding()
        }
    }
}

struct ContentView: View {
    
    @State var selectedClaim: Claim?
    
    @State var multiselection = Set<Claim>()
        
    var claims = [Claim(id: 0, description: "Value 1"),
                  Claim(id: 1, description: "Value 2"),
                  Claim(id: 2, description: "Value 3")]
    
    var body: some View {
        VStack {
            Spacer()
            List(claims, id: \.id) { claim in
                ClaimCell(claim: claim, selectedClaim: self.$selectedClaim)
                    .onTapGesture {
                        selectedClaim = claim
                        
                        guard selectedClaim != nil else { return }
                        
                        if multiselection.contains(selectedClaim!) {
                            multiselection.remove(selectedClaim!)
                        } else {
                            multiselection.insert(selectedClaim!)
                        }
                    }
            }
                .padding()
                .frame(maxHeight:180)
                .background(Color.gray)
                .cornerRadius(8)
            Text("Use : \(self.selectedClaim?.description ?? "none")").onTapGesture {
                print("Do something (eg go to detail view) with \(self.selectedClaim?.description ?? "none")")
            }.padding()
            Spacer()
            Text("Multiselection result")
                .onTapGesture {
                    print("\n \(multiselection.description)")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
