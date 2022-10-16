import XCTest
import MyLibrary
@testable import MyLibrary


final class MyLibraryTests: XCTestCase {
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(8)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }
    
    func testFilepath(){
        let filePath = Bundle.module.path(forResource: "data", ofType: "json")
        //print(filePath)
        XCTAssertNotNil(filePath)
    }
    
    func testWeather() throws {

        //let bundle = Bundle(for: type(of: self))
//        guard let url = bundle.url(forResource: "data", withExtension: "json") else
//        {
//            XCTFail("Missing file: data.json")
//            return
//        }
        //print("0")
        
        // Given
        if let fileURL = Bundle.module.url(forResource: "data", withExtension: "json")
        {
//            if let data = try? String(contentsOf: fileURL){
//                print("1")
                //print(fileContents)
            // When
            var systemUnderTest: Weather!
            let data = try Data(contentsOf: fileURL)
            systemUnderTest = try JSONDecoder().decode(Weather.self, from: data)

            // Then
            XCTAssertEqual(systemUnderTest.main.temp, 281.56)
        }
    }

    
    
    
    
    
    
    
    
    
    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNil(isLuckyNumber)
    }
    
    
    
}
