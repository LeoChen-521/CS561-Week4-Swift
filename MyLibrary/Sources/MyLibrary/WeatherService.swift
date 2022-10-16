import Alamofire
import Foundation


public protocol WeatherService {
    func getTemperature() async throws -> Int
}

enum BaseUrl :String {
    case production = "https://api.openweathermap.org/data/2.5/weather?q=corvallis&units=imperial&appid=f714c6c950beba3a9c729d6017b5f4a6"
    case mockServer = "http://localhost:3000/data/2.5/weather"
}

class WeatherServiceImpl: WeatherService {
    
    let url = BaseUrl.production.rawValue
    //let url = BaseUrl.mockServer.rawValue

    func getTemperature() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

public struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
