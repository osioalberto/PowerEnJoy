pred show(){
	#(RechargingStationArea.pluggedCars) > 0
	some r:Ride| r.elapsedMinutes>0
	(#Bill) > 0
}
run show for 5 but 8 Int
