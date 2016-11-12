/*
	Simplification,an area can be any kind of polygon, but for what we are
	interested in, an area is a set of point inside such polygon
*/
abstract sig Area {
	boundaries: some Position 
}
sig GeographicalRegion extends Area {}
abstract sig SafeArea extends Area {}
sig SafeParkingArea extends SafeArea {}
sig RechargingStationArea extends SafeArea {
	maxPlugs: one Int,
	pluggedCars: set Car
} {
	maxPlugs > 0
	#pluggedCars <= maxPlugs
	all c:pluggedCars| c.position in boundaries
}
/*
	It finds a position with a minimal distance from the argument, such that
	the position found belongs to a RechargingStationArea
*/
fun findNearestPositionOfRechargingStations[pos:Position]:lone Position {
	{p:RechargingStationArea.boundaries|
		all p2:RechargingStationArea.boundaries| p.distance[pos] <= p2.distance[pos]
	}
}
/*
	Geographical regions cannot overlap, because of the way a geographical region can be modified
*/
fact geographicalRegionDoNotOverlap {
	no disjoint g1,g2:GeographicalRegion| g1.boundaries&g2.boundaries != none
}
/*
	Safe areas cannot overlap because the two subset are defined to be partitions of the superset.
	Overlapping within the same partition, even if logically possible, it is useless.
*/
fact safeAreaDoNotOverlap {
	no disjoint s1,s2:SafeArea| s1.boundaries&s2.boundaries != none
}
/*
	Since geographical region must cover all the territory, it is necessary that any position belongs
	to a geographical area
*/
fact eachPositionBelongsToAtLeastGeographicalRegion {
	all p:Position| p in GeographicalRegion.boundaries
}
