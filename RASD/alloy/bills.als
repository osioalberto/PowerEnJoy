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
