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
