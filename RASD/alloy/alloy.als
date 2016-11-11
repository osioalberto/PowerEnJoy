/*
	Simplification,an area can be any kind of polygon, but for what we are
	interested in, an area is a set of point inside such polygon
*/
abstract sig Area {
	points: some Position 
}
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
/*
	It finds a position with a minimal distance from the argument, such that
	the position found belongs to a RechargingStationArea
*/
fun findNearestPositionOfRechargingStations[pos:Position]:lone Position {
	{p:RechargingStationArea.points|
		all p2:RechargingStationArea.points| p.distance[pos] <= p2.distance[pos]
	}
}
/*
	Geographical regions cannot overlap, because of the way a geographical region can be modified
*/
fact geographicalRegionDoNotOverlap {
	no disjoint g1,g2:GeographicalRegion| g1.points&g2.points != none
}
/*
	Safe areas cannot overlap because the two subset are defined to be partitions of the superset.
	Overlapping within the same partition, even if logically possible, it is useless.
*/
fact safeAreaDoNotOverlap {
	no disjoint s1,s2:SafeArea| s1.points&s2.points != none
}
/*
	Since geographical region must cover all the territory, it is necessary that any position belongs
	to a geographical area
*/
fact eachPositionBelongsToAtLeastGeographicalRegion {
	all p:Position| p in GeographicalRegion.points
}
abstract sig Bill {
	cost: one Int,
	isRejected: lone Boolean
} {
	isRejected = none => {
		one r:Ride| this in r.reservor.pendingBills
	}
}
sig ExpirationBill extends Bill {} {
	cost = 1
}
sig RideBill extends Bill {
	percentageDeltas: set PercentageDelta,
} {
	cost >= 0
	isRejected = none => {
		one r:Ride| {
			all p:PercentageDelta| canApplyPercentageDelta[r, p] <=> p in percentageDeltas
			cost = div[mul[mul[r.elapsedMinutes,r.car.costPerMinute], 100+sum[percentageDeltas.delta]],100]
		}
	}
	isRejected = True => cost != 0
}

fact allBillAreUsed {
	User.pendingBills = Bill
}
fact billAreUniqueByUser {
	no disjoint u1,u2:User| {
		u1.pendingBills & u2.pendingBills != none
	}
}
fact notProcessedBillHaveARide {
	all b:Bill| b.isRejected = none => one r:Ride| {
		b in r.reservor.pendingBills
		r.car.isBecomingAvailable[]
	}
}
fact notStoringCompletedBills {
	no b:Bill|b.isRejected = False
}
fact atMostOneCurrentBillPerUser {
	all u:User| lone b:u.pendingBills|b.isRejected = none
}
abstract sig Boolean {}
one sig True extends Boolean {}
one sig False extends Boolean {}
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
	position in area.points			//the position must belong to the area
	locked = True => {
		passengers = 0
		ignited = False
		closed = True
	}
	chargeLevel = 0 => ignited = False
}
pred Car.isBecomingAvailable[]{
	this.ignited=False
	this.closed=True
	this.passengers = 0
	this.position in SafeArea.points
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
/*
	Represents a simplyfied version of a geographical position.
	Its components are integer.
*/
sig Position {
	latitude: one Int,
	longitude: one Int
}
/*
	It computes the approximate square distance between two position.
	It does not take into account the fact that the Earth is not a plane.
*/
fun Position.distance[p: Position]: one Int {
	mul[p.latitude-this.latitude, p.latitude-this.latitude]+mul[p.longitude-this.longitude,p.longitude-this.longitude]
}
/*
	It has no sense to have two position with the same longitude and latitude.
	Moreover, having such duplicates make comparsion of position more complicated
*/
fact noDuplicatesInPosition{
	no disjoint p1,p2:Position| {
		p1.latitude=p2.latitude
		p1.longitude=p2.longitude
	}
}
sig Reservation {
	reservor: one User,
	car: one Car,
	elapsedMinutes: one Int
} {
	elapsedMinutes >= 0
	car.locked = True
	car.chargeLevel > 20
}

fact reservationsMustExpire {
	all r:Reservation| r.elapsedMinutes < 60
}
fact onlyRegisteredNotBannedUserCanHaveReservations {
	all r:Reservation| {
		r.reservor.isRegistered[]
		not r.reservor.isBanned[]
	}
}
fact userCannotReserveManyCarsInTheSameArea {
	no disjoint r1,r2:Reservation| {
		r1.reservor = r2.reservor
		r1.car.area = r2.car.area
	}
}
fact sameCarReservationIsNotPossible {
	no r1,r2:Reservation| r1.car = r2.car
}
sig Ride {
	car: one Car,
	reservor: one User,
	elapsedMinutes: one Int,
	passengersFromBegin: one Int
} {
	elapsedMinutes >= 0
	passengersFromBegin >= 0
	car.ignited=True => passengersFromBegin <= car.passengers
}
fact onlyRegisteredNotBannedUserCanHaveARide {
	all r:Ride| {
		r.reservor.isRegistered[]
		not r.reservor.isBanned[]
	}
}
fact userCannotRideManyCarsAtTime {
	no disjoint r1,r2:Ride| {
		r1.reservor = r2.reservor
	}
}
fact unlockedCarsHaveARideAssociated {
	all c:Car| c.locked = False => one r:Ride| {
		r.car = c
	}
}
pred show(){
	#(RechargingStationArea.pluggedCars) > 0
	some r:Ride| r.elapsedMinutes>0
	(#Bill) > 0
}
run show for 5 but 8 Int
sig Credential {}
sig PaymentInformation {}
sig User {
	paymentInformation: lone PaymentInformation,
	credential: lone Credential,
	logged: one Boolean,
	position: one Position,
	pendingBills: set Bill
} {
	//An unregistered user cannot be banned or logged into the system
	not this.isRegistered[] => {
		logged = False
		not this.isBanned[]
	}
	//all registered user belongs to the system, the other are free
	this.isRegistered[] <=> {
		paymentInformation != none
		credential != none
	}
}
pred User.isBanned[] {
	this.pendingBills.isRejected = True
}
pred User.isRegistered[] {
	this in ManagementSystem.users
}
fact credentialAreAllUsed {
	User.credential = Credential
}
fact credentialsAreUniqueByUser {
	no disjoint u1,u2:User | {
		u1.isRegistered[]
		u2.isRegistered[]
		u1.credential = u2.credential
	}
}
fact paymentInfoAreAllUsed {
	User.paymentInformation = PaymentInformation
}
fact paymentInfoAreUniqueByUser {
	no disjoint u1,u2:User | {
		u1.isRegistered[]
		u2.isRegistered[]
		u1.paymentInformation = u2.paymentInformation
	}
}