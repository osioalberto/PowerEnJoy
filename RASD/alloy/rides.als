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
fact unlockedCarsHaveARideAssociated {
	all c:Car| c.locked = False => one r:Ride| {
		r.car = c
	}
}
