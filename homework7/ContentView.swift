//
//  ContentView.swift
//  homework7
//
//  Created by Nail Kamilov on 10.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    //Create for every variable @State
    @State private var berlintime = Date()
    @State var hours = 0
    @State var minutes = 0
    @State var seconds = 0
    @State var lampsArr = Array(repeating: false, count: 24)
    
    //Implement timer
    let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.2))
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 0) {
                Group {
                    HStack {
                        Text("Time is \(hours):\(minutes):\(seconds)")
                            .onReceive(timer, perform: { _ in
                                self.seconds += 1
                                checkingTime()
                            })
                            .font(Font.system(size: 17, weight: .semibold))
                            .padding()
                    }
                    
                }
                ZStack {
                    //First rectangle
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .frame(width: 358, height: 312)
                    VStack {
                          secondsBulps
                          fiveHourBulps
                          oneHourBulps
                          fiveMinuteBulps
                          oneMinuteBulps

                    }
                }.padding(10)
                ZStack {
                    //Second rectangle
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 358, height: 54, alignment: .center)
                        .foregroundColor(.white)
                    HStack {
                        Text("Insert Time")
                        Spacer()
                        timePicker(time: $berlintime).onChange(of: berlintime) {_
                            in
                            setTime()
                            convertHours(hours: hours)
                            convertMinutes(minutes: minutes)
                        }
                    }.padding(.horizontal)
                        .frame(width: 358, height: 54, alignment: .center)
                }
                Spacer()
            }
        }.onAppear {
            setTime()
    }
}
    // Create rule for time hour < 60, minute < 60
    func checkingTime(){
        if(self.seconds == 60){
            self.seconds = 0
            self.minutes += 1
        }
        if(self.minutes == 60){
            self.minutes = 0
            self.hours += 1
        }
        
        if(self.hours == 24){
            self.hours = 0
        }
    }
    
    //Taking parametres of time
    func setTime(){
        lampsArr = Array(repeating: false, count: 24)
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: berlintime)
        hours = components.hour ?? 0
        minutes = components.minute ?? 0
        seconds = components.second ?? 0
    }
     
    // Convert seconds
    func convertSeconds(seconds: Int, clockArr: inout [Bool]) {
        clockArr[0] = (seconds % 2 == 0 ? true : false)
    }
    
    //Converting to hours
    func convertHours(hours: Int) {
        var lamps = 0
        if hours > 4{
            lamps = hours / 5
            for i in Range(1...lamps){
                lampsArr[i] = true
            }
        }
        lamps = hours % 5
        if lamps > 0{
            for i in Range(5...lamps + 4){
                lampsArr[i] = true
            }
        }
    }
    
    //Converting to minutes
    func convertMinutes(minutes: Int) {
        var lamps = 0
        if minutes > 4 {
            lamps = minutes / 5
            for i in Range(9...lamps + 8){
                lampsArr[i] = true
            }
        }
        lamps = minutes % 5
        if lamps > 0{
            for i in Range(20...lamps + 19){
                lampsArr[i] = true
            }
        }
    }
    
    // Create second Lamp
    var secondsBulps: some View{
        Circle()
            .frame(width: 56, height: 56)
            .foregroundColor((seconds % 2 == 0 ? colors.yellow : colors.lightYellow))
    }
    
    // fiveHour
    var fiveHourBulps: some View{
        HStack(spacing: 10){
            HourBulp(isOn: $lampsArr[1])
            HourBulp(isOn: $lampsArr[2])
            HourBulp(isOn: $lampsArr[3])
            HourBulp(isOn: $lampsArr[4])
        }
    }
    
    // oneHour
    var oneHourBulps: some View{
        HStack(spacing: 10){
            HourBulp(isOn: $lampsArr[5])
            HourBulp(isOn: $lampsArr[6])
            HourBulp(isOn: $lampsArr[7])
            HourBulp(isOn: $lampsArr[8])
        }
    }
    
    // fiveMinutes
    var fiveMinuteBulps: some View{
        HStack(spacing: 9){
            Group {
                FiveMinuteBulp(isOn: $lampsArr[9], isRed: false)
                FiveMinuteBulp(isOn: $lampsArr[10], isRed: false)
                FiveMinuteBulp(isOn: $lampsArr[11], isRed: true)
                FiveMinuteBulp(isOn: $lampsArr[12], isRed: false)
                FiveMinuteBulp(isOn: $lampsArr[13], isRed: false)
            }
            Group{
                FiveMinuteBulp(isOn: $lampsArr[14], isRed: true)
                FiveMinuteBulp(isOn: $lampsArr[15], isRed: false)
                FiveMinuteBulp(isOn: $lampsArr[16], isRed: false)
                FiveMinuteBulp(isOn: $lampsArr[17], isRed: true)
                FiveMinuteBulp(isOn: $lampsArr[18], isRed: false)
                FiveMinuteBulp(isOn: $lampsArr[19], isRed: false)
            }
        }
        .padding(.horizontal)
    }
    
    
    var oneMinuteBulps: some View{
        HStack(spacing: 10){
            OneMinuteBulp(isOn: $lampsArr[20])
            OneMinuteBulp(isOn: $lampsArr[21])
            OneMinuteBulp(isOn: $lampsArr[22])
            OneMinuteBulp(isOn: $lampsArr[23])
        }
    }
}
    
struct timePicker: View {
    @Binding var time: Date
    var body: some View {
        DatePicker("", selection: $time, displayedComponents:
                .hourAndMinute)
                .labelsHidden()
                .environment(\.locale, Locale(identifier: "en_DK"))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
