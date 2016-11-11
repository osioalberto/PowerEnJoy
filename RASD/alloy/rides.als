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
