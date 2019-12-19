import UIKit

struct FoodGuidelines: Codable {
  let Categories: [FoodWrapper]
}

struct FoodWrapper: Codable {
  var data: Food
}

struct Food: Codable{
   
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
        return food.Categories.map {$0.data }
       
    } catch {
      fatalError("\(error)")
    }
  }
   
}







/*{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },
   {
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },
   {
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },
   {
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },{
       "data": {
           "foodItem": "",
           "dateExtension": "",
           "refigerated": "",
           "frozen": ""
       }
   },
   
*/
