	                  
import Foundation
import SwiftUI
import CoreMotion


class SensorViewModel : ObservableObject {
		           
    var classification : ClassificationViewModel = ClassificationViewModel()
	static var instance : SensorViewModel? = nil
	private var modelParser : ModelParser? = ModelParser(modelFileInfo: ModelFile.modelInfo)
	@Published var resultAccelerometer : String = ""	
	let motionManager = CMMotionManager()
	let queue = OperationQueue()
	@Published var xAccelerometer: Double = 0.0
	@Published var yAccelerometer: Double = 0.0
	@Published var zAccelerometer: Double = 0.0
	
	@Published var resultStepCounter : String = ""

	static func getInstance() -> SensorViewModel {
		if instance == nil
	     { instance = SensorViewModel()
	        }
	    return instance! }
                            
	func getAccelerometeraccelerometerClassification () {
        var accelerometerArray: [[Float]] = [[Float]]()
        motionManager.startAccelerometerUpdates(to: queue) {
            (data: CMAccelerometerData?, error: Error?) in
            guard let data = data else {
            print("Error: \(error!)")
            return
        } 
            let trackMotion: CMAcceleration = data.acceleration
            self.motionManager.accelerometerUpdateInterval = 0.2
            DispatchQueue.main.async { [self] in
                self.xAccelerometer = trackMotion.x
                self.yAccelerometer = trackMotion.y
                self.zAccelerometer = trackMotion.z
                
                let xyzArray : [Float] = [Float] ([Float(trackMotion.x)/4000, Float(trackMotion.y)/4000, Float(trackMotion.z)/4000])
                
                accelerometerArray.append(xyzArray)
                
                if accelerometerArray.count == 26 {
                    resultAccelerometer = classification.accelerometerClassification(obj: accelerometerArray) ?? ""
                    accelerometerArray.removeAll()
                }		
            }		
        }
    }
	func cancelAccelerometerClassification() {
		//cancel function
	}

	}
