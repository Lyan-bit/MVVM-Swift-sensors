              
              
              
import SwiftUI

struct ContentView : View {
	
	@ObservedObject var sensorModel : SensorViewModel
    @ObservedObject var model : ClassificationViewModel
    
	var body: some View {
		TabView {
            AccelerometerClassificationScreen (model: sensorModel).tabItem {
                        Image(systemName: "1.square.fill")
	                    Text("AccelerometerClassification")} 
            CollectSensorScreen (model: model).tabItem { 
                        Image(systemName: "2.square.fill")
	                    Text("CollectSensor")} 
				}.font(.headline)
		}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sensorModel: SensorViewModel.getInstance(), model: ClassificationViewModel.getInstance())
    }
}

