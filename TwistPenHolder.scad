//============================================================
// A twisty vase
//------------------------------------------------------------
$fn = 150 ;			// OpenSCAD Resolution


CurvedVase(sides=6, radius=15, height=30);

//------------------------------------------------------------
module CurvedVase(sides, radius, height)
{
    twist=360/sides;
    factors = GenerateFactors(10);
    radii = radius * factors;
    iterations = len(radii) - 1;
    for (i  = [0:iterations - 1]) {
        echo(i, radii[i], " -> ", radii[i+1]);
        // Get the scale to go from one radius to the next
        scale=radii[i+1]/radii[i];
        translate([0, 0, i * (height / iterations)]) {
            linear_extrude(
                height=height/iterations,
                twist=twist/iterations,
                scale=scale
            ) {
                rotate(-i * (twist / iterations)) {
                    circle(r=radii[i], $fn=sides);
                }
            }
        }
    }
}

function GenerateFactors(size) = concat(
    [for (i = [0:size]) (1 + 0.5 * sin(i * (180 / size)))]
);
