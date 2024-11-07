//
//  PredatorMap.swift
//  JP APex Predators
//
//  Created by Jinyuan Zhang on 07/11/2024.
//

import MapKit
import SwiftUI

struct PredatorMap: View {
    let predators = Predators()

    @State var position: MapCameraPosition
    @State var satellite: Bool = false

    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredators) { predator in
                Annotation(
                    predator.name,
                    coordinate: predator.location
                ) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button{
                satellite.toggle()
            } label:{
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(
        position:
        .camera(
            MapCamera(
                centerCoordinate: Predators().apexPredators[2].location,
                distance: 1000,
                // 地图朝向角度，地图视角相对于正北方向的旋转角度，0 表示北方（默认方向），90 是东，180 是南，270 是西。
                heading: 250,
                // 地图俯视角度，就是从垂直方向往地平线方向的倾斜角度。0 度表示直接俯视（完全垂直向下），而较大的角度会使地图更接近水平视角。80 度接近于水平视角，所以地图看起来会非常接近地平线，可以提供一个几乎是地平线的视角，给人一种接近地面、远距离观看的效果。
                pitch: 80
            )
        )
    )
    .preferredColorScheme(.dark)
}
