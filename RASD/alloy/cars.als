sig Plate {}
sig Car {
	plate: one Plate,
	ignited: one Boolean,
	passengers: one Int,
	locked: one Boolean,
	closed: one Boolean,
	position: one Position,
	costPerMinute: one Int,
	chargeLevel: one Int,			//percentage
	area: one GeographicalRegion
} {
	chargeLevel >= 0
	chargeLevel <= 100
	passengers >= 0					//passengers are persons... and include the driver
	costPerMinute > 0				//negative or zero cost ride are not allowed
	position in area.boundaries		//the position must belong to the area
	locked = True => {
		passengers = 0
		ignited = False
		closed = True
        position in SafeArea.boundaries
	}
	chargeLevel = 0 => ignited = False
}
pred Car.isBecomingAvailable[]{
	this.ignited=False
	this.closed=True
	this.locked=False
	this.passengers = 0
	this.position in SafeArea.boundaries
}
fact platesAreUniqueByCar {
	no disjoint c1,c2:Car| c1.plate = c2.plate 
}
fact platesAreAllUsed {
	Car.plate = Plate
}
fact onlyLockedCarCanBeRecharged {
	no c:Car,rc:RechargingStationArea| c.locked = False and c in rc.pluggedCars
}
