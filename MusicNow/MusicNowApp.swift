//
//  MusicNowApp.swift
//  MusicNow
//
//  Created by 안윤진 on 2023/03/10.
//

import SwiftUI
import FirebaseCore
import Firebase



@main
struct MusicNowApp: App {
    let data = MusicData()
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init(){
        FirebaseApp.configure()
        data.loadAlbum()
    }
    var body: some Scene {
        WindowGroup {
            MusicNow(data: data)
        }
    }
}
