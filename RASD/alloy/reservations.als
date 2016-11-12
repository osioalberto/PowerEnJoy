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
