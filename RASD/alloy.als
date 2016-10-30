//still incomplete model and not completely checked
abstract sig Area {
	points: set Position //simplification,an area can be any kind of polygon, but for what we are
						 //interested in, an area is a set of point inside that polygon
} {
	#points > 0
}
sig GeographicalArea extends Area {}
sig SafeParkingArea extends Area {}
sig QRCode {}
abstract sig Boolean {}
one sig True extends Boolean {}
one sig False extends Boolean {}
sig Position {
	x: one Int,//shall be float
	y: one Int//shall be float
} {x>=0 and y>=0}
fun Position.squareDistance[other:Position]:one Int {
	add[mul[this.x-other.x,this.x-other.x],mul[this.y-other.y,this.y-other.y]]
}

one sig ManagementSystem {
	users: set User,
	cars: set Car,
	parkingAreas: set SafeParkingArea
} {
	#users>0 =>	(#cars>0 and #parkingAreas > 0)
}
sig User {
	position: one Position,
	state: one UserState
}
sig Car {
	code: one QRCode,
	ignited: one Boolean,
	passengers: one Int,
	locked: one Boolean,
	position: one Position,
	area: one GeographicalArea,
	state: one CarState
} { passengers >= 0}

abstract sig CarState {}
one sig AvailableCarState extends CarState {}
sig UsingCarState extends CarState {
	usingBy: one User,
	costPerMinute: one Int,
	elapsedMinutes: one Int
} {elapsedMinutes>=0 and costPerMinute>0}

sig ReservedCarState extends CarState {
	reservedBy: one User,
	elapsedMinutes: one Int
} {
	elapsedMinutes >=0 and elapsedMinutes < 60
}
fun ReservedCarState.getCar[]: one Car {
	{c:Car| c.state=this}
}
abstract sig UserState { }
one sig UnregisteredUserState extends UserState {}
one sig RegisteredUserState extends UserState {}
one sig LoggedUserState extends UserState {}
sig SearchForNearbyCarsUserState extends UserState {
	distance: one Int,
	cars: set Car
} {
	distance >= 0 and
	all c:cars| {
		(
			c.state = AvailableCarState or
			(
				c.state in ReservedCarState and
				c.state.reservedBy = this.getUser[]
			)
		) and
		c.position.squareDistance[this.getUser[].position] <= mul[distance,distance]
	}
	no c:ManagementSystem.cars| {
		not (c in cars) and
		(
			c.state = AvailableCarState or
			(
				c.state in ReservedCarState and
				c.state.reservedBy = this.getUser[]
			)
		) and
		c.position.squareDistance[this.getUser[].position] <= mul[distance,distance]
	}
}
fun SearchForNearbyCarsUserState.getUser[]: one User {
	{u:ManagementSystem.users| u.state = this}
}
fact onlyIgnitedCarCanChargeUser {
	no c:Car| {
		c.ignited = False and c.state in UsingCarState and c.state.(UsingCarState <: elapsedMinutes) > 0
	}
}
fact userCanOnlyUseACarAtTime {
	no c1,c2:Car | {
		c1!=c2
		c1.state in UsingCarState
		c2.state in UsingCarState
		c1.state.usingBy = c2.state.usingBy
	}
}
fact usingCarHasSamePositionOfUser {
	no c:Car| c.state in UsingCarState and c.state.usingBy.position != c.position
}
fact onlyUsingCarMustBeUnlocked{
	all c:Car| {
		c.state in UsingCarState <=> c.locked = False
	}
}
fact ignitedCarMustBeUnlocked {
	all c:Car| {
		(c.ignited = True) => (c.locked = False)
	}
}
fact userCanReserveOnlyACarPerArea {
	no c1,c2:ManagementSystem.cars| {
		c1!=c2
		c1.area = c2.area
		c1.state in ReservedCarState
		c2.state in ReservedCarState
		c1.state.reservedBy = c2.state.reservedBy
	}
}
fact unregisteredUserCannotHaveACar {
	all u:User| u.state = UnregisteredUserState <=> no c:Car| {
		(c.state in UsingCarState and c.state.usingBy = u) or
		(c.state in ReservedCarState and c.state.reservedBy = u)
	}
}
fact allCarAreOfManagementSystem {
	#(ManagementSystem.cars) = #(Car)
}
fact allUserInManagementSystemAreNotUnregistered {
	(ManagementSystem.users.state & UnregisteredUserState) = none
}
fact allUserNotUnregisteredAreInAManagementSystem {
	#(ManagementSystem.users) = #(User - {u:User| u.state = UnregisteredUserState})
}
fact allSafeAreaAreUsed {
	#SafeParkingArea = #ManagementSystem.parkingAreas
}
fact carsContainPassengersOnlyIfUnlocked {
	all c:Car| { c.locked = True => c.passengers = 0 }
}
fact allMultiUserStateHaveAUser {
	all us:UserState| (not (us in (UnregisteredUserState+RegisteredUserState+LoggedUserState))) implies us in User.state
}
fact allMultiCarStateHaveACar {
	all cs:CarState| (not (cs in (AvailableCarState))) implies cs in Car.state
}
fact positionsMustBeAllUsed {
	#(Position) = #(User.position + Car.position)
}
fact geographicalAreasMustBeAllUsed {
	#(GeographicalArea) = #(Car.area)
}
fact noDoublesInPosition{
	no p1,p2:Position| {
		p1!=p2
		p1.x=p2.x
		p1.y=p2.y
	}
}
fact codesAreUniqueAmongCars {
	no c1,c2:Car| {
		c1!=c2 and c1.code = c2.code
	}
}
fact carPositionIsInItsArea {
	all c:Car| c.position in c.area.points
}
fact eachPositionBelongsToAtLeastAGeographicalArea {
	no p:Position| (p & GeographicalArea.points) = none
}
fact areasOfSameTypeDoNotOverlap {
	no a1,a2:GeographicalArea| {
		a1 != a2 and (a1.points & a2.points) != none
	}
	no a1,a2:SafeParkingArea| {
		a1 != a2 and (a1.points & a2.points) != none
	}
}
pred show(){
	some c:Car| c.ignited = True
}
run show for 20
