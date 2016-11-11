abstract sig PercentageDelta {
	delta: one Int
} {
	delta >= -100
	delta <= 100
}
one sig DiscountManyPeople extends PercentageDelta {} {
	delta = -10
}
one sig DiscountBatteryHigh extends PercentageDelta {} {
	delta = -20
}
one sig DiscountCarPlugged extends PercentageDelta {} {
	delta = -30
}
one sig RaiseFarCar extends PercentageDelta {} {
	delta = 30
}
one sig RaiseBatteryLow extends PercentageDelta {} {
	delta = 30
}
pred canApplyPercentageDelta[r: one Ride, p: one PercentageDelta] {
	p = RaiseBatteryLow => r.car.chargeLevel < 20
	p = RaiseFarCar => findNearestPositionOfRechargingStations[r.car.position].distance[r.position] > 9000000
	p = DiscountCarPlugged => r.car in RechargingStationArea.pluggedCars
	p = DiscountBatteryHigh => r.car.chargeLevel >= 50
	p = DiscountManyPeople => r.passengersFromBegin >= 3
}

//consistency among deltas
fact BatteryIsLowOrHigh {
	no b:Bill| {
		RaiseBatteryLow in b.percentageDeltas
		DiscountBatteryHigh in b.percentageDeltas
	}
}
