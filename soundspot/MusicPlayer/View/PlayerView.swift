//
//  PlayerView.swift
//  soundspot
//
//  Created by James Maturino on 10/17/21.
//

import Foundation
import SwiftUI
import AVFoundation


struct PlayerView : View
{
    @StateObject var viewModel : PlayerViewModel
    
    
    var body: some View
    {
        
        VStack
        {
            if(viewModel.trackList[viewModel.trackIndex].pictureData == nil && !viewModel.trackList[viewModel.trackIndex].pictureDownloaded){
                Image("defaultTrackImg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .shadow(radius: 1)
					.padding(20)
            }else{
                Image(uiImage: UIImage(data: viewModel.trackList[viewModel.trackIndex].pictureData!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .shadow(radius: 1)
					.padding(20)
            }
            
            Text(viewModel.trackList[viewModel.trackIndex].title)
                .foregroundColor(Color.gray).padding().font(.title2)
           
           
            ZStack
            {
                VStack{
                    PlayerSlider(viewModel: viewModel)
                    HStack{
                        Text(viewModel.progress)
                        Spacer()
                        Text(viewModel.trackLength)
                    }.padding(.leading).padding(.trailing)
                    PlayerControllers(viewModel: viewModel)
        
                }
            }
        }.onAppear{
            viewModel.onEvent(event: MusicPlayerEvent.Launched) 
        }.background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
    }
    
    struct PlayerSlider : View {
        @ObservedObject var viewModel : PlayerViewModel
        var body: some View{
            Slider(value: Binding<Double>(
                get: {viewModel.progressPercentage},
                set: {
                    viewModel.onEvent(event: MusicPlayerEvent.DraggingSlider)
                    viewModel.progressPercentage = $0
                }
            ),
                   in: 0 ... 100, step: 1){
                // if dragging ended update music player
                if !$0 {
                       viewModel.onEvent(event: MusicPlayerEvent.SliderChanged)
                   }
            }.padding(.leading).padding(.trailing)
        }
    }
    
    struct PlayerControllers : View {
        @ObservedObject var viewModel : PlayerViewModel
        var body: some View{
            HStack
            {
                Button(action: {
                    viewModel.onEvent(event: MusicPlayerEvent.PreviousPressed)
                },  label: {
                    Image("previousTrack").resizable()
                }).frame(width: 50, height: 50, alignment: .center).foregroundColor(Color.gray.opacity(0.2))
                   
                
                Button(
                    action: {viewModel.onEvent(event: MusicPlayerEvent.PlayPausePressed)},
                       label: {
                    Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .foregroundColor(Color.pink)
                }).frame(width: 70, height: 70, alignment: .center)
                
                Button(action: {
                    viewModel.onEvent(event: MusicPlayerEvent.NextPressed)
                }, label: {
                    Image("nextTrack").resizable()
                }).frame(width: 50, height: 50, alignment: .center).foregroundColor(Color.gray.opacity(0.2))
            }
        }
    }
}











struct PlayerView_Previews: PreviewProvider {
     
    static func getMusicModel() ->  Array<Track>{
        var model = Track(name: "music Name", link: "", trackDownloaded: false, pictureLink: nil, pictureDownloaded: false, pictureData: nil)
        
        var list = Array<Track>()
        list.append(model)
        return list
    }
    
    static var previews: some View {
    
    let list = PlayerView_Previews.getMusicModel()
    PlayerView(viewModel: PlayerViewModel(trackList: list, trackIndex: 0))
                .previewDevice("iPhone 13 Pro")
    }
}


