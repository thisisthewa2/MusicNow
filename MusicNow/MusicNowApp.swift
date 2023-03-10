//
//  MusicNowApp.swift
//  MusicNow
//
//  Created by 안윤진 on 2023/03/10.
//

import SwiftUI
import FirebaseCore
import Firebase

/*
    개발한 것
 - 파이어베이스와 연동해 음원 스트리밍
 - 앨범마다 다른 수록곡(플레이리스트) 보이기, 곡 선택 시 음악 재생
 - 음악 재생멈춤, 이전/다음 곡 재생
 - 백그라운드 재생
 
    추후 개발할 것
 - ui 수정
 - 프로그레스바 추가
 - 음원마다 시간 대 맞게 맞추기
 - 아티스트 정보 띄우기
 - 하트 버튼 클릭하면 선호 표시, 선호 표시한 곡만 모아서 보여주기
 */

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
