The algorithms listed here can be useful, but it is not mandatory to implement exactly the following algorithms as long as the result is equivalent

### Computing the bill amount ###
Assuming time subtraction yields a time offset and PercentageDelta.delta are normalized in the interval [-1, 1],
this function computes the bill amount from a ride and a list of all percentageDeltas implemented in the system
function computeBillAmount(ride: Ride, discounts: PercentageDelta[]):
    let multiplier = 1;
    let elapsedMinutes = (Time.now() - ride.startTime).totalMinutes
    for discount in discounts:
        if discount.canBeApplyed(ride) then:
            multiplier = multiplier + discount.delta
    return elapsedMinutes * multiplier * COST_PER_MINUTE

### Getting the MULTIPOLYGON representation of a Path ###
It is assumed that a path is an ordered set of segments, as such it cannot have duplicate items.
The entry point for this algorithm is **getMultiPolyRepresentation**.

**getMultiPolyRepresentation**(*path*: Path): Path[][]
This algorithm converts a generic path to a multipolygon representation suitable for storing in a dbms or to apply simpler algorithm
1. Let *polygons* be an empty sequence
2. Iterate over the **complex polygons of *path***, at each time
    1. Let *simplePolygons* be the **simple polygons of the *current polygon***
    2. Iterate over *simplePolygons*, at each time
        1. Let *point* be one random interior point of the *current simple polygon*
        2. Apply the even-odd algorithm (https://drive.google.com/file/d/0BzPnfgeA6pjZLVRqNHdWdXNRUVE/view) to the *current complex polygon* and *point*
        3. If the *point* is outside the *complex polygon*, then mark the *current simple polygon* as "hole"
        4. Otherwise, mark the *current simple polygon* as "fill"
        5. **Insert the *current simple polygon* inside *polygons***
3. Iterate over *polygons*, at each time
    1. Iterate over the remaining part of *polygons*, at each time
        1. If the *two polygons* have at least a segment in common and all the common segments are contiguos, then
            1. Remove from *polygons* the *two polygons*
            2. **Insert inside *polygons* the sequence containing only *merged polygon***
            3. Repeat 3.1
        2. Otherwise, do nothing
4. Iterate over *polygons*, at each time
    1. Let *fill* be the current polygon
    2. If *fill* is marked as "hole", then skip this polygon
    3. Let holes be an empty sequence
    4. Iterate over the remaining part of *polygons*, at each time
        1. Let *newHole* be the *current polygon*
        2. If *newHole* is not contained inside *fill* or it is marked as "fill", then skip this polygon
        3. Iterate over *holes*, at each time
            1. If *newHole* is contained by the *current hole polygon*, then go to the next iteration of 4.4
            2. If *newHole* contains the *current hole polygon*, then remove the *current hole polygon* from *holes*
        4. Add *newHole* to *holes*
    5. Prepend *fill* to *holes*
    6. Append *holes* to *result*
5. Return *result*

**getComplexPolygons**(*path*: Path): Path[]
This algorithm returns a sequence of complex polygons from a single path object
1. Iterate over the point sequence of *path*, at each time
    1. If the *current point* is not marked yet, then mark it
    2. Otherwise collect all points in the sequence marked from the *current point* up to the previous marked one, and name this sequence *currentPath*
    3. Remove the marking for each point in the *currentPath* sequence
    4. **Remove the leaf segments from *currentPath***
    5. If *currentPath* is not empty, then add *currentPath* to the *result* sequence
2. Return the *result*

**removeLeafSegments**(*path*: Path): Path
This algorithm returns a path where all the trailing segment not connected will be removed from path
1. Let *points* be the point sequence of *path*
2. Iterate over *points* except for the last point, at each time
    1. If the *current point* is equal to the last point in points, then return a path constructed from *points*
3. Remove the last item from *points*
4. If *points* is empty, then return an empty path
5. Repeat the steps from 2

**getSimplePolygons**(*path*: Path): Path[]
This algorithm returns a sequence of simple polygons starting from a complex polygon
1. Let *segments* be the segment sequence of *path*
2. Iterate over *segments*, at each time
    1. Let *first* be the *current segment*
    2. Iterate over the remaining portion of *segments*, at each time
        1. Let *second* be the *current segment*
        2. If *first* and *second* intersects in the point *intersectionPoint*, then
            1. Let *firstSplit* be the split of first in two segments by *intersectionPoint*
            2. Let *secondSplit* be the split of second in two segments by *intersectionPoint*
            3. Replace *first* with *firstSplit* in *segments*
            4. Replace *second* with *secondSplit* in *segments*
3. Let *newPath* be a path constructed from *segments*
4. Return the **complex polygons from *newPath***, these are not complex anymore

**insertSimplePolygonToSequence**(*polygon*: Path, *sequence*: Path[])
This algorithm adds the polygon to the sequence preventing any violation of the property of the multipolygon representation
1. If the same point sequence of *polygon* is already in *sequence*, then
    1. Let *presentPolygon* be the polygon whoose point sequence is the same as *polygon*
    2. **Update the mark of *presentPolygon* with respect to *polygon***
    3. Return
2. Let *polySequence* a sequence containing only *polygon*
3. **Compute the simple polygon intersection of *sequence* with *polySequence***
4. Iterate over *polySequence*, at each time
    1. **Insert the *current polygon* inside *sequence***

**computeSimpleIntersection**(*sequence*: Path[], *simple*: Path[])
This algorithm computes the intersection polygons and updates the two sequence inserting theese intermediate polygons
1. Iterate over *simple*, at each time:
2. Let *currentSimple* be the *current polygon*
    1. Iterate over *sequence*, at each time:
        1. Let *currentSequence* be the *current polygon*
        2. If *currentSequence* intersects with *currentSimple*, then
            1. Remove *currentSimple* from *simple*
            2. Remove *currentSequence* from *sequence*
            3. Let *segments* be the union of the segments of *currentSimple* with *currentSequence*
            4. Let *polySequence* be the sequence of **simple polygons of the path constructed by *segments***
            5. Iterate over *polySequence*, at each time
                1. call the **addSimpleIntersection**(*simple*, *currentSimple*, *current polygon*)
                2. call the **addSimpleIntersection**(*sequence*, *currentSequence*, *current polygon*)
        3. Otherwise, do nothing

**addSimpleIntersection**(*sequence*: Path[], *originalPolygon*: Path, *newPolygon*: Path):
This procedure adds a copy of newPolygon to sequence if the originalPolygon intersects with the newPolygon
1. If *originalPolygon* intersects with *newPolygon*, then
    1. Let *copy* be the copy of *newPolygon*
    2. Set the mark of *copy* to the same of *originalPolygon*
    3. **Insert *copy* inside *sequence***
2. Otherwise, do nothing

**updateMark**(*target*: Path, *source*: Path)
This procedure will assign the correct mark to target
1. If *target* is marked as "fill" and *source* is marked as "fill", then mark *target* as "hole"
2. If *target* is marked as "hole" and *source* is marked as "fill", then mark *target* as "fill"
3. Otherwise, do nothing

