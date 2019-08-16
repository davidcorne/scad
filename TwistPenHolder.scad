//============================================================
// A twisty vase
//------------------------------------------------------------
$fn = 150 ;			// OpenSCAD Resolution


CurvedVase(sides=6, radius=15, height=20);

//------------------------------------------------------------
module CurvedVase(sides, radius, height)
{
    twist=360/sides;
    // scale gets to 2
    overall_scale=1.5;
    slices=height/4;
        
    radii = radius * [1, 1.2, 1.3, 1.35, 1.4, 1.43, 1.45, 1.48, 1.5];
    iterations = len(radii) - 1;
    for (i  = [0:iterations - 1]) {
        echo(i, radii[i], " -> ", radii[i+1]);
        // Get the scale to go from one radius to the next
        scale=radii[i+1]/radii[i];
        translate([0, 0, i * (height / (2 * iterations))]) {
            linear_extrude(
                height=height/(2 * iterations),
                twist=twist/iterations,
                scale=scale
            ) {
                rotate(-i * (twist / iterations)) {
                    circle(r=radii[i], $fn=sides);
                }
            }
        }
    }
        translate([0, 0, height/2]) {
        radii = radius * [1.5, 1.48, 1.45, 1.43, 1.4, 1.35, 1.3, 1.2, 1];
        iterations = len(radii) - 1;
        for (i  = [0:iterations - 1]) {
            echo(i, radii[i], " -> ", radii[i+1]);
            // Get the scale to go from one radius to the next
            scale=radii[i+1]/radii[i];
            translate([0, 0, i * (height / (2 * iterations))]) {
                linear_extrude(
                    height=height/(2 * iterations),
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
}
