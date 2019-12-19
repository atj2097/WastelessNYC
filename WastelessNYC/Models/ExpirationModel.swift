import UIKit

struct FoodGuidelines: Codable {
  let Categories: [Food]
}
struct Food: Codable {
  var data: FoodWrapper
}
class FoodWrapper: Codable{
   
  let foodItem: String?
  let dateExtension: String?
  let refigerated: String?
  let frozen: String?
   
  enum JSONError: Error {
    case decodingError(Error)
  }
   
   
  static func getFoodGuidelines() -> [Food] {
    guard let fileName = Bundle.main.path(forResource: "ExpirationGuidelines", ofType: "json")
      else {fatalError()}
    let fileURL = URL(fileURLWithPath: fileName)
    do {
      let data = try Data(contentsOf: fileURL)
      let food = try
        JSONDecoder().decode(FoodGuidelines.self, from: data)
      return food.Categories
       
    } catch {
      fatalError("\(error)")
    }
  }
   
}







