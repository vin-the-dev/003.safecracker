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
    
    @State var currentRotaion: Angle = .zero
    @GestureState var twistAngle: Angle = .zero
    @State var arrSuccess = [false, false, false]
    @State var currentSelection = 0
    @State var isSuccess = false
    
    let keys = [Int.random(in: 0...360), Int.random(in: 0...360), Int.random(in: 0...360) ]
    let rotationGesture = RotationGesture(minimumAngleDelta: Angle(degrees: 5))
    
    let unselectedGradient = LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .top, endPoint: .bottom)
    let selectedGradient = LinearGradient(gradient: Gradient(colors: [Color.green, Color.gray]), startPoint: .top, endPoint: .bottom)
    
    
    var body: some View {
        GeometryReader { metric in
            VStack {
                Spacer()
                Text("Safe Cracker 🔐")
                    .font(.system(size: 50))
//                    .font(.headline)
                VStack {
                    HStack {
                        VStack {
                            
                        }
                        .frame(minWidth: 0,
                               maxWidth: 50,
                               minHeight: 0,
                               maxHeight: 50,
                               alignment: .center)
                        .background(arrSuccess[0] ? selectedGradient : unselectedGradient)
                        .clipShape(Circle())
                        .padding()
                        .shadow(color: arrSuccess[0] ? Color.green : Color.gray, radius: 10, x: 0.0, y: 0.0 )
                        
                        VStack {
                            
                        }
                        .frame(minWidth: 0,
                               maxWidth: 50,
                               minHeight: 0,
                               maxHeight: 50,
                               alignment: .center)
                        .background(arrSuccess[1] ? selectedGradient : unselectedGradient)
                        .clipShape(Circle())
                        .padding()
                        .shadow(color: arrSuccess[0] ? Color.green : Color.gray, radius: 10, x: 0.0, y: 0.0 )
                        
                        VStack {
                            
                        }
                        .frame(minWidth: 0,
                               maxWidth: 50,
                               minHeight: 0,
                               maxHeight: 50,
                               alignment: .center)
                        .background(arrSuccess[2] ? selectedGradient : unselectedGradient)
                        .clipShape(Circle())
                        .padding()
                        .shadow(color: arrSuccess[0] ? Color.green : Color.gray, radius: 10, x: 0.0, y: 0.0 )
                    }
                    .padding()
                }
                Spacer()
                VStack {
                    VStack {
                        ZStack {
                            ForEach(0..<100) { tick in
                                self.tick(at: tick)
                            }
                            
                            VStack {
                                
                            }
                            .frame(minWidth: 0,
                                   maxWidth: 200,
                                   minHeight: 0,
                                   maxHeight: 200,
                                   alignment: .center)
                            .background(Color.primary)
                            .clipShape(Circle())
                            .shadow(radius: 50)
                            .onTapGesture {
                                print("Tapped")
                                let val:Int = Int(abs((currentRotaion + twistAngle).degrees).rounded())
                                let newVal = val - ((val / 360) * 360)
                                print(newVal)
                                if(newVal == keys[currentSelection] ||
                                    newVal == keys[currentSelection] + 1 ||
                                    newVal == keys[currentSelection] - 1
                                ) {
                                    print("success")
                                    arrSuccess[currentSelection] = true
                                    print(arrSuccess)
                                    currentSelection = currentSelection + 1
                                    if currentSelection > 2 {
                                        isSuccess = true
                                    }
                                }
                            }
                        }
                        .rotationEffect(currentRotaion + twistAngle)
                        .frame(minWidth: 0,
                               maxWidth: metric.size.width - 25,
                               minHeight: 0,
                               maxHeight: metric.size.height * 0.5 - 25,
                               alignment: .center)
                        .overlay(
                            Circle().stroke(Color.primary, lineWidth: 5)
                        )
                    }
                    .gesture(
                        RotationGesture()
                            .updating($twistAngle, body: { (angle, state, _) in
                                state = angle
                                print("start")
                                print(currentRotaion.degrees)
                                print(twistAngle.degrees)
                                print("end")
                                
                                let val:Int = Int(abs((currentRotaion + twistAngle).degrees).rounded())
                                //                            print("start")
                                //                            print(val)
                                //                            print(val / 360)
                                print(val - ((val / 360) * 360))
                                let newVal = val - ((val / 360) * 360)
                                //                            print("end")
                                
                                print(keys)
                                
                                if(newVal == keys[currentSelection] ||
                                    newVal == keys[currentSelection] + 1 ||
                                    newVal == keys[currentSelection] - 1
                                ) {
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                }
                                else {
                                    let generator = UIImpactFeedbackGenerator(style: .light)
                                    generator.impactOccurred()
                                }
                            })
                            .onEnded({ (value) in
                                currentRotaion += value
                            })
                    )
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                           maxHeight: metric.size.height * 0.5,
                           alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    //            .background(Color.red)
                }
                .padding(.bottom, 50)
//                .padding(.horizontal, 20)
                
            }
            .alert(isPresented: $isSuccess) { () -> Alert in
                Alert(
                    title: Text("Wow"),
                    message: Text("You have successfully cracked the safe, here is a cookie 🍪"),
                    primaryButton: .default(
                        Text("Go Again"),
                        action: {
                            currentSelection = 0
                            arrSuccess = [false, false, false]
                            currentRotaion = .zero
                            
                        }
                    ),
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
