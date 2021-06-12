//
//  ContentView.swift
//  safecracker
//
//  Created by Vineeth on 12/06/21.
//

import SwiftUI

struct ContentView: View {
    
    func tick(at tick: Int) -> some View {
        VStack {
            Rectangle()
                .fill(Color.primary)
                .opacity(tick % 10 == 0 ? 1 : 0.4)
                .frame(width: 2, height: tick % 10 == 0 ? 15 : 7)
            if(tick % 10 == 0) {
                Text((tick).description)
            }
            Spacer()
        }.rotationEffect(Angle.degrees(Double(tick)/(100) * 360))
    }
    
    @State var rotation: Double = 0.0
    
    var body: some View {
        GeometryReader { metric in
            VStack {
                VStack {
                    ZStack {
                        ForEach(0..<100) { tick in
                            self.tick(at: tick)
                        }
                    }
                    .rotationEffect(Angle.degrees(Double(rotation)/(100) * 360))
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                       maxWidth: metric.size.width - 25,
                       minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                       maxHeight: metric.size.height * 0.5 - 25,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    Circle().stroke(Color.primary, lineWidth: 5)
                )
                
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                   maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                   maxHeight: metric.size.height * 0.5,
                   alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//            .background(Color.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
