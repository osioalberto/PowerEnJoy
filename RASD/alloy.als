//TODO
//Add employee
//Add discounts and raises
//closed attribute on car?
//SIGNATURES
abstract sig Boolean {}
one sig True extends Boolean {}
one sig False extends Boolean {}

sig Position {
	x: one Int,//Shall be float
	y: one Int//Shall be float
} {
	//No need to use other numbers since this is a mapping of geographical coordinate
	x >= 0
	y >= 0
}

abstract sig Area {
	//Simplification,an area can be any kind of polygon, but for what we are
	//interested in, an area is a set of point inside that polygon
	points: some Position 
}
sig Plate {}
sig Credential {}
sig GeographicalRegion extends Area {}
abstract sig SafeArea extends Area {}
sig SafeParkingArea extends SafeArea {}
sig RechargingStationArea extends SafeArea {
	maxPlugs: one Int,
	pluggedCars: set Car
} {
	maxPlugs > 0
	#pluggedCars <= maxPlugs
}
one sig ManagementSystem {
	users: set User,
	cars: set Car,
	safeAreas: set SafeArea,
	geographicalRegion: set GeographicalRegion
} {
	//users must be served
	users!=none =>	{
		cars!=none
		(safeAreas & RechargingStationArea) != none
	}
	//areas must be complete
	safeAreas = SafeArea
	cars = Car
	geographicalRegion = GeographicalRegion
}
sig User {
	credential: lone Credential,
	registered: one Boolean,
	logged: one Boolean,
	banned: one Boolean,
	position: one Position
} {
	//An unregistered user cannot be banned or logged into the system
	registered = False => {
		logged = False
		banned = False
	}
	//all registered user belongs to the system, the other are free
	registered = True <=> {
		this in ManagementSystem.users
		credential != none
	}
}
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
	chargeLevel <= 50
	passengers >= 0					//passengers are persons... and include the driver
	costPerMinute > 0				//negative or zero cost ride are not allowed
	position in area.points			//the position must belong to the area
	locked = True => {
		passengers = 0
		ignited = False
		closed = True
	}
	chargeLevel = 0 => ignited = False
}
sig Reservation {
	reservor: one User,
	car: one Car,
	elapsedMinutes: one Int
} {
	elapsedMinutes >= 0
	car.locked = True
}

sig Ride {
	car: one Car,
	reservor: one User,
	elapsedMinutes: one Int
} {
	elapsedMinutes >= 0
	car.locked = False
}

//FACTS
fact noDuplicatesInPosition{
	no disjoint p1,p2:Position| {
		p1.x=p2.x
		p1.y=p2.y
	}
}
fact platesAreUniqueByCar {
	no disjoint c1,c2:Car| c1.plate = c2.plate 
}
fact platesAreAllUsed {
	Car.plate = Plate
}
fact credentialAreUniqueByUser {
	no disjoint u1,u2:User| {
		u1.registered = True
		u1.registered = u2.registered
		u1.credential = u2.credential
	}
}
fact credentialAreAllUsed {
	User.credential = Credential
}
fact geographicalRegionDoNotOverlap {
	no disjoint g1,g2:GeographicalRegion| g1.points&g2.points != none
}
fact safeAreaDoNotOverlap {
	no disjoint s1,s2:SafeArea| s1.points&s2.points != none
}
fact eachPositionBelongsToAtLeastGeographicalRegion {
	all p:Position| p in GeographicalRegion.points
}
fact reservationsMustExpire {
	all r:Reservation| r.elapsedMinutes < 60
}
fact onlyRegisteredNotBannedUserCanHaveReservations {
	all r:Reservation| {
		r.reservor.registered = True
		r.reservor.banned = False
	}
}
fact userCannotReserveManyCarsInTheSameArea {
	no disjoint r1,r2:Reservation| {
		r1.reservor = r2.reservor
		r1.car.area = r2.car.area
	}
}
fact onlyRegisteredNotBannedUserCanHaveARide {
	all r:Ride| {
		r.reservor.registered = True
		r.reservor.banned = False
	}
}
fact userCannotRideManyCarsAtTime {
	no disjoint r1,r2:Ride| r1.reservor = r2.reservor
}
fact unlockedCarsHaveARideAssociated {
	all c:Car| c.locked = False => one r:Ride| r.car = c
}
fact onlyLockedCarCanBeRecharged {
	no c:Car,rc:RechargingStationArea| c.locked = False and c in rc.pluggedCars
}
pred show(){
	#(RechargingStationArea.pluggedCars) > 0
}
run show for 5 but 7 Int
