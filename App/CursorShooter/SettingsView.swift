//
//  SettingsView.swift
//  CursorShooter
//
//  Created by maki on 2022/12/29.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cursorarrow.click")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundColor(.accentColor)
            Text("Coming soon...")
                .font(.title)
        }
        .frame(minWidth: 180, minHeight: 180)
        .padding(.vertical, 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
