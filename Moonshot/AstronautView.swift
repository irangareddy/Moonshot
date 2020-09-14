//
//  AstronautView.swift
//  Moonshot
//
//  Created by RANGA REDDY NUKALA on 11/09/20.
//

import SwiftUI

struct AstronautView: View {
    
    struct InMission {
        var mission: Mission
        var role: String
    }
    
    var astronaut: Astronaut
    var missions: [Mission]
    
    var inMissions = [InMission]()
    
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        self.missions = missions
        
        
        
        var mactches = [InMission]()
        
        for mission in missions {
            for member in mission.crew {
                if member.name == astronaut.id {
                    mactches.append(InMission(mission: mission, role: member.role))
                }
            }
        }
        
        inMissions = mactches
        
    }
    

    
    

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
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("In Missions")
                            .bold()
                        ForEach(inMissions, id: \.self.role) { inMission in
                            
                            HStack(spacing: 10) {
                                Image(inMission.mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 60)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(inMission.mission.displayName)
                                        .font(.headline)
                                    Text(inMission.role)
                                        .font(.subheadline)
                                }
                                Spacer()
                            }.padding(.vertical,8)
                            
                           
                        }
                    }.padding()
                    Spacer(minLength: 25)
                }
                    
            }.navigationBarTitle(Text(astronaut.name), displayMode: .inline)
            
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[10], missions: missions)
    }
}
