/*
	This is a signature representing a tuple composed of
		a unique driving licence number,
		a unique username,
		a password,
		a date of birth,
		a complete name
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
