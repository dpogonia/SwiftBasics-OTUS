import UIKit
import AVFoundation

class DownloadAVUrl {
    func downloadUrl() {
        print("Загружаем песню по адресу")
    }
    
    func saveTrack(_ trackName: String) {
        print("Сохраняем песню \(trackName)")
    }
}

class SetupPlayer {
    func addTrack(_ name: String) {
        print("Добавляем трек \(name) в плеер")
    }
    
    func play() {
        print("Запускаем плеер")
    }
}

class PlayerFacade {
    func startPlayer(track: String) {

        let d = DownloadAVUrl()
        let sp = SetupPlayer()

        //Check if already downloaded
        d.downloadUrl()
        d.saveTrack(track)

        //Check if track already in player
        sp.addTrack(track)
        sp.play()
    }
}

PlayerFacade().startPlayer(track: "Bon Jovi - It's my life")
