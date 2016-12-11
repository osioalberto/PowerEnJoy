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
	mul[p.latitude.minus[this.latitude], p.latitude.minus[this.latitude]]+mul[p.longitude.minus[this.longitude],p.longitude.minus[this.longitude]]
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
