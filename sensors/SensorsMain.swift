              
              
import SwiftUI

@main 
struct sensorsMain : App {

	var body: some Scene {
	        WindowGroup {
                ContentView(sensorModel: SensorViewModel.getInstance(), model: ClassificationViewModel.getInstance())
	        }
	    }
	} 
