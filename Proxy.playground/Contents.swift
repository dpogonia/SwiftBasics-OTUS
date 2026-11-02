import UIKit

protocol VideoServiceProtocol {
    func loadVideoList(url: URL?) -> [String]?
}

class VideoService: VideoServiceProtocol {
    func loadVideoList(url: URL?) -> [String]? {
        print("Call to internet")
        return ["Дата из интернета"]
    }
}

class Proxy: VideoServiceProtocol {
    
    var service: VideoServiceProtocol
    private var cashData: [String]?
    
    init(service: VideoServiceProtocol) {
        self.service = service
    }
    
    
    
    func loadVideoList(url: URL?) -> [String]? {
        if cashData == nil {
            cashData = service.loadVideoList(url: url)
        } else {
            print("Getting from cash")
        }
        
        return cashData
    }
}

var videoService = VideoService()
var proxy = Proxy(service: videoService)

proxy.loadVideoList(url: nil)
proxy.loadVideoList(url: nil)
