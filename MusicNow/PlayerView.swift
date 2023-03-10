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
    var album: Album
    var song: Song
    
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
                let storage = Storage.storage().reference(forURL: self.song.file)
                storage.downloadURL{(url, error) in
                    if error != nil{
                        print(error)
                    }else{
                        player = AVPlayer(url: url!)
                        player.play()
                    }
                }
            }
    }
    func playPause(){
        self.isPlaying.toggle()
        if isPlaying == true{
            player.pause()
        }else{
            player.play()
        }
    }
    
    func next(){
        
    }
    
    func previous(){
        
    }
}
