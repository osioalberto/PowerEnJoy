/*
	Simplification,an area can be any kind of polygon, but for what we are
	interested in, an area is a set of point inside such polygon
*/
abstract sig Area {
	boundaries: some Position 
} {
	#boundaries>2
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
	all c:pluggedCars| c.position in boundaries
}
/*
	It finds a position with a minimal distance from the argument, such that
	the position found belongs to a RechargingStationArea
*/
fun findNearestPositionOfRechargingStations[pos:Position]:lone Position {
	{p:RechargingStationArea.boundaries|
		all p2:RechargingStationArea.boundaries| p.distance[pos] <= p2.distance[pos]
	}
}
/*
	Geographical regions cannot overlap, because of the way a geographical region can be modified
*/
fact geographicalRegionDoNotOverlap {
	no disjoint g1,g2:GeographicalRegion| g1.boundaries&g2.boundaries != none
}
/*
	Safe areas cannot overlap because the two subset are defined to be partitions of the superset.
	Overlapping within the same partition, even if logically possible, it is useless.
*/
fact safeAreaDoNotOverlap {
	no disjoint s1,s2:SafeArea| s1.boundaries&s2.boundaries != none
}
/*
	Since geographical region must cover all the territory, it is necessary that any position belongs
	to a geographical area
*/
fact eachPositionBelongsToAtLeastGeographicalRegion {
	all p:Position| p in GeographicalRegion.boundaries
}
enum BillStatus { PendingBill, PaidBill, RejectedBill }
abstract sig Bill {
	amount: one Int,
	status: one BillStatus
}
sig ExpirationBill extends Bill {} {
	amount = 1
}
sig RideBill extends Bill {
	percentageDeltas: set PercentageDelta,
} {
	amount >= 0
	status = PendingBill => {
		one r:Ride| {
			this in r.reservor.pendingBills
			r.car.isBecomingAvailable[] => {
				all p:PercentageDelta| canApplyPercentageDelta[r, p] <=> p in percentageDeltas
				amount = div[mul[mul[r.elapsedMinutes,r.car.costPerMinute], 100+sum[percentageDeltas.delta]],100]
			}
			not r.car.isBecomingAvailable[] => {
				percentageDeltas = none
				amount = mul[r.elapsedMinutes, r.car.costPerMinute]
			}
		}
	}
	status = RejectedBill => amount != 0
}
fact thereCannotTwoRideBillsOneIsPending {
	no rb1,rb2:RideBill| {
		rb1.status = PendingBill
		rb2.status = RejectedBill
	}
}
fact allBillAreUsed {
	User.pendingBills = Bill
}
fact billAreUniqueByUser {
	no disjoint u1,u2:User| {
		u1.pendingBills & u2.pendingBills != none
	}
}
fact allRideHaveAnAssociatedBill {
	all r:Ride| one b:RideBill| {
		b.status = PendingBill
		b in r.reservor.pendingBills
	}
}
fact notStoringCompletedBills {
	no b:Bill|b.status = PaidBill
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
	position in area.boundaries		//the position must belong to the area
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
/*
	The elapsedMinutes relation is a simplification of the creationTime field in the class diagram.
	The elapsedMinutes is the only relevant information for the system as it is, and can be computed
	quite easly from the creationTime.
*/
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
/*
	The elapsedMinutes relation is a simplification of the creationTime field in the class diagram.
	The elapsedMinutes is the only relevant information for the system as it is, and can be computed
	quite easly from the creationTime.
	The beforeGettingBanned expresses a temporal constraint, the system cannot prevent a user from
	riding in the following situation:
		a user reserves two cars,
		then he starts a ride in one of the two,
		the other reservation expires and the user is banned because he cannot pay
*/
sig Ride {
	car: one Car,
	reservor: one User,
	elapsedMinutes: one Int,
	passengersFromBegin: one Int,
	private beforeGettingBanned: one Boolean
} {
	elapsedMinutes >= 0
	passengersFromBegin >= 0
	car.ignited=True => passengersFromBegin <= car.passengers
}
fact onlyRegisteredNotBannedUserCanHaveARide {
	all r:Ride| {
		r.reservor.isRegistered[]
		r.beforeGettingBanned = False => not r.reservor.isBanned[]
	}
}
fact userCannotRideManyCarsAtTime {
	no disjoint r1,r2:Ride| {
		r1.reservor = r2.reservor
	}
}
fact onlyUnlockedCarsHaveARideAssociated {
	all c:Car| c.locked = False <=> one r:Ride| {
		r.car = c
	}
}
pred show(){
	#(RechargingStationArea.pluggedCars) > 0
	some r:Ride| r.elapsedMinutes>0
	(#Bill) > 0
}
run show for 5 but 8 Int
/*
	This is a signature representing a tuple composed of
		a unique driving licence number,
		a unique username,
		a password
*/
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
	this.isRegistered[] <=> credential != none
	this.isRegistered[] <=> paymentInformation != none
}
pred User.isBanned[] {
	some b:this.pendingBills| b.status = RejectedBill
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
