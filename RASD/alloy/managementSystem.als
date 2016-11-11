one sig ManagementSystem {
	users: set User,
	cars: set Car,
	safeAreas: set SafeArea,
	geographicalRegion: set GeographicalRegion
} {
	//users must be served
	users!=none =>	{
		cars!=none
		(safeAreas & RechargingStationArea) != none
	}
	//areas must be complete
	safeAreas = SafeArea
	cars = Car
	geographicalRegion = GeographicalRegion
}
