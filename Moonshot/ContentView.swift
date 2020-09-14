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
    @State private var showingCrewMembers = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44, alignment: .center)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(mission.displayName)
                                .font(.headline)
                            if(showingCrewMembers) {
                                HStack {
                                    ForEach(mission.crew, id: \.self.role) { member in
                                        Text(member.name.capitalized)
                                            .font(.caption)
                                    }
                                }
                            } else {
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                            }
                            
                            
                        }
                    }
                }
            }.navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Toggle(isOn: $showingCrewMembers) {
                Text("Show Crew Members")
            })
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
