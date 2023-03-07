
import Foundation
import SwiftUI
import CoreMotion


class ClassificationViewModel : ObservableObject {
        
static var instance : ClassificationViewModel? = nil
private var modelParser : ModelParser? = ModelParser(modelFileInfo: ModelFile.modelInfo)
private let pedometer = CMPedometer()
@Published var resultAccelerometer : String = ""
@Published var resultStepCounter : String = ""

static func getInstance() -> ClassificationViewModel {
if instance == nil
{ instance = ClassificationViewModel()
}
return instance! }

func accelerometerClassification(obj : [[Float]]) -> String? {
guard let result = self.modelParser?.runModel(input: obj)
else { return "Classification Error" }
return result
}
    
    func getStepCounter () {
        print("getSteps1")
        if CMPedometer.isStepCountingAvailable() {
            print("getSteps2")
            pedometer.startUpdates(from: Date()) { pedometerData, error in
                print("getSteps3")
                guard let pedometerData = pedometerData, error == nil else { return }
                print("getSteps4")
                DispatchQueue.main.async {
                    print(pedometerData.numberOfSteps.intValue)
                    self.resultStepCounter = String(pedometerData.numberOfSteps.intValue)
                }
            }
        }
    }

}
