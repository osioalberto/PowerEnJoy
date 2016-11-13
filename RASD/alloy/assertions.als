assert reservationOnRideCar {
	no r:Reservation,rr:Ride| r.car = rr.car
}
assert noDoubleRide {
	no disjoint r1,r2: Ride| r1.reservor = r2.reservor
}
assert positionBelongsToOneRegion {
	no disjoint r1,r2: GeographicalRegion| (r1.boundaries & r2.boundaries) != none
}
assert noTwoPendingRideBill {
	no u:User| #({p:u.pendingBills| p in RideBill and p.status = PendingBill})>1
}
assert onRejectedNoReservation {
	no r:Reservation| {b:r.reservor.pendingBills| b.status = RejectedBill} != none
}
assert noOverFreeBonusCombo {
	no r:Ride| {
		sumPercentageDelta[{p:PercentageDelta| canApplyPercentageDelta[r,p]}]>100
	}
}
check reservationOnRideCar for 5 but 8 Int
check noDoubleRide for 5 but 8 Int
check positionBelongsToOneRegion for 5 but 8 Int
check noTwoPendingRideBill for 5 but 8 Int
check onRejectedNoReservation for 5 but 8 Int
check noOverFreeBonusCombo for 5 but 8 Int
