//
//  PlayerView.swift
//  MusicStreaming
//
//  Created by 안윤진 on 2023/03/09.
//

import SwiftUI
import AVKit
import Firebase
import AVFoundation

struct PlayerView: View {
    @State var  album: Album
    @State var song: Song
    
    @State var player = AVPlayer()
    @State var isPlaying : Bool = false //재생여부
    var body: some View{
        ZStack{
            Image(album.image).resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .dark).edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                AlbumArt(album: album,isWithText: false)
                Text(song.name).font(.title).fontWeight(.light).foregroundColor(.white)
                Spacer()
                ZStack{
                    Color.white.cornerRadius(20).shadow(radius: 10)
                    HStack{
                        Button(action: self.previous, label: {
                            Image("RewindButton").resizable()
                        }).frame(width: 50,height: 50,alignment: .center)
                        
                        Button(action: self.playPause, label: {
                            Image(isPlaying ? "StartButton" : "StopButton").resizable()
                        }).frame(width: 50,height: 50,alignment: .center)
                        
                        Button(action: self.next, label: {
                            Image("SkipButton").resizable()
                        }).frame(width: 50,height: 50,alignment: .center)
                    }
                }.edgesIgnoringSafeArea(.bottom).frame(height:200,alignment: .center)
                
            }
        }.foregroundColor(Color("BlueGray"))
            .onAppear(){
                self.playSong()
            }
    }
    
    //음악 재생
    func playSong()
    {
            let storage = Storage.storage().reference(forURL: self.song.file)
            storage.downloadURL{(url, error) in
                if error != nil{
                    print(error)
                }else{
                    do{
                        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                    }catch{}
                    player = AVPlayer(url: url!)
                    player.play()
                }
            }
    }
    
    
    //멈춤
    func playPause(){
        self.isPlaying.toggle()
        if isPlaying == true{
            player.pause()
        }else{
            player.play()
        }
    }
    //다음 곡 재생
    func next(){
        if let currentIndex = album.songs.firstIndex(of: song){
            if currentIndex == album.songs.count-1{
                
            }else{
                player.pause()
                song = album.songs[currentIndex+1]
                self.playSong()
            }
        }
    }
    //이전 곡 재생
    func previous(){
        if let currentIndex = album.songs.firstIndex(of: song){
            if currentIndex == 0{
                
            }else{
                player.pause()
                song = album.songs[currentIndex-1]
                self.playSong()
            }
        }
    }
}
