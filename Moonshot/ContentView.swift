//
//  ContentView.swift
//  Moonshot
//
//  Created by RANGA REDDY NUKALA on 09/09/20.
//

import SwiftUI



struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: Text("\(mission.description)")) {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44, alignment: .center)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                        }
                    }
                }
            }.navigationBarTitle("Moonshot")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
