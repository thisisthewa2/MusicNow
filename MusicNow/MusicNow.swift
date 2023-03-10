//
//  ContentView.swift
//  MusicStreaming
//
//  Created by 안윤진 on 2023/03/09.
// 다수참고: https://www.youtube.com/watch?v=hkmnQcsz1Bs

import SwiftUI
import Firebase
/*
 - 파이어베이스를 사용한 음악 스트리밍 앱
 - 앨범에 따라 수록된 곡들이 다름
 - 플레이리스트 상단의 앨범을 선택하면 앨범에 수록된 곡들이 보이는데, 따로 선택하지 않은 경우 첫 앨범의 수록곡들이 보인다.
 */
struct Album: Hashable{
    var id = UUID()
    var name: String
    var image: String
    var songs : [Song]
}

struct Song: Hashable{
    var id = UUID()
    var name: String
    var time: String
    var file: String
}

struct AlbumArt: View{
    var album: Album
    var isWithText: Bool
    var body: some View{
        ZStack(alignment: .bottom, content: {
            Image(album.image)
                .resizable()
                .frame(width: 200,height: 200,alignment: .center)
            if isWithText == true{
                ZStack{
                    Blur(style: .dark)
                    Text(album.name).foregroundColor(.white)
                }.frame(height: 60, alignment: .center)
            }
        }).frame(width: 200,height: 200,alignment: .center).clipped().cornerRadius(20).shadow(radius: 10).padding(20)
    }
}

struct SongCell: View{
  
    var album: Album
    var song: Song
    var body: some View{
        // Song이 들어가는 HStack을 선택하든, 재생버튼을 선택하든 노래를 재생하고 싶어서 NavigationLink를 중첩사용
        NavigationLink(
            destination: PlayerView(album: album, song: song), label: {
                HStack{
                    
                    NavigationLink(destination: PlayerView(album: self.album, song: self.song),label: {Image("PlayButton").resizable().frame(width: 40.0, height: 40.0)})
                    
                    
                    Text(song.name)
                    Spacer()
                    Text(song.time)
                    Button{
                        
                    } label:{
                        Image("LikeButton").resizable().frame(width: 40.0, height: 40.0)
                    }
                    
                }
                .padding(20)
                .font(.system(size: 18))
                .fontWeight(.semibold)
            }
        )
       
    }
}
struct MusicNow: View {
    
    @ObservedObject var data = MusicData()
    @State private var currentAlbum: Album?
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    ScrollView(.horizontal, showsIndicators: false,content: {
                        LazyHStack{
                            //LazyStack의 차이점 https://seons-dev.tistory.com/entry/SwiftUI-Lazy-VHStack
                            ForEach(self.data.albums,id: \.self,content: {
                                album in AlbumArt(album: album,isWithText: true).onTapGesture {
                                    self.currentAlbum = album //선택한 앨범을 현재 앨범으로 지정
                                }
                            })
                        }
                    })
                    LazyVStack{
                        if self.data.albums.first==nil{
                            EmptyView()
                        }else{
                            ForEach((self.currentAlbum?.songs ?? self.data.albums.first?.songs) ?? [Song(name: "", time: "",file: "")]
                                    ,id: \.self,content:{
                                song in
                                SongCell(album: currentAlbum ?? self.data.albums.first!, song: song)
                                
                            })
                        }
                    }.listRowBackground(Color.clear)
                }.scrollContentBackground(.hidden)//list의 배경색상 숨김
            }.foregroundColor(Color("BlueGray"))
                .background(AngularGradient(colors: [Color("AngularFirst"),Color("AngularSecond"),Color("AngularThird"),Color("AngularFourth"),Color("AngularFifth"),Color("AngularSixth")], center: .topLeading)
                    .ignoresSafeArea(.all))
        }
    }
    
}



struct MusicNow_Previews: PreviewProvider {
    static var previews: some View {
        MusicNow()
    }
    
}
