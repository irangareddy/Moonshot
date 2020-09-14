//
//  MissionView.swift
//  Moonshot
//
//  Created by RANGA REDDY NUKALA on 11/09/20.
//

import SwiftUI


struct MissionView: View {
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    struct CrewMember {
        var role: String
        var astronaut: Astronaut
    }
    
    var mission: Mission
    var astronauts: [Astronaut]
    var crewMembers: [CrewMember]
    
    init(mission: Mission,astronauts: [Astronaut]) {
        self.mission = mission
        self.astronauts = astronauts
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        
        }
        crewMembers = matches
    }
    
    
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Image(mission.image)
                            .resizable()
                            .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Launch date:")
                                .bold()
                            Text(mission.formattedLaunchDate)
                        }
                        Text("About")
                            .bold()
                            .padding(.top,8)
                        Text(mission.description)
                            
                    }.padding(.top)
                    .layoutPriority(1)
                    VStack(alignment: .leading, spacing: 4){
                        Text("Crew Members")
                            .bold()
                        ForEach(crewMembers, id: \.self.role) { member in
                            NavigationLink(
                                destination: AstronautView(astronaut: member.astronaut, missions: missions)) {
                                HStack {
                                    Image(member.astronaut.id)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: geometry.size.width * 0.25)
                                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                                        
                                    VStack(alignment: .leading,spacing: 3){
                                        Text(member.astronaut.name)
                                            .font(.headline)
                                        Text(member.role)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }.padding(.vertical,3)
                                
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }.padding(.top)
                    Spacer(minLength: 25)
                }.padding(.horizontal)
                    
            }.navigationBarTitle(Text(mission.displayName), displayMode: .inline)
            
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
    }
}
