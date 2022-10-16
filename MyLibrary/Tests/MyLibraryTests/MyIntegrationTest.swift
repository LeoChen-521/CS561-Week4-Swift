import XCTest
import MyLibrary
@testable import MyLibrary


final class MyIntegrationTest: XCTestCase {
    
    
    func testWeather() async throws {
       
        // Given
        // Create a weather service (OOP)
        let myService = WeatherServiceImpl()
            
        // When
        // Got the temperature
        let temp = try await myService.getTemperature()
        
        // Then
        // Check the temperature is what you expect
        
        // Production Server
        XCTAssertEqual(temp, 62)
        
        // Mock Server
        // XCTAssertEqual(temp, 281)
        
        
    }
    
}

    
    
    
    

