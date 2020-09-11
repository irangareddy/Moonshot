//
//  AstronautView.swift
//  Moonshot
//
//  Created by RANGA REDDY NUKALA on 11/09/20.
//

import SwiftUI

struct AstronautView: View {
    
    var astronaut: Astronaut
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Image(astronaut.id)
                            .resizable()
                            .scaledToFit()
                        .frame(maxWidth: geometry.size.width)
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("About")
                            .bold()
                        Text(astronaut.description)
                    }.layoutPriority(1).padding()
                    Spacer(minLength: 25)
                }
                    
            }.navigationBarTitle(Text(astronaut.name), displayMode: .inline)
            
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[1])
    }
}
