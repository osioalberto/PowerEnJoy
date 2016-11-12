abstract sig Bill {
	cost: one Int,
	isRejected: lone Boolean
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
			this in r.reservor.pendingBills
			r.car.isBecomingAvailable[] => {
				all p:PercentageDelta| canApplyPercentageDelta[r, p] <=> p in percentageDeltas
				cost = div[mul[mul[r.elapsedMinutes,r.car.costPerMinute], 100+sum[percentageDeltas.delta]],100]
			}
			not r.car.isBecomingAvailable[] => {
				percentageDeltas = none
				cost = mul[r.elapsedMinutes, r.car.costPerMinute]
			}
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
fact allRideHaveAnAssociatedBill {
	all r:Ride| one b:RideBill| {
		b.isRejected = none
		b in r.reservor.pendingBills
	}
}
fact notStoringCompletedBills {
	no b:Bill|b.isRejected = False
}
