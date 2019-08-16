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
    translate([2.5 * radius, 0, 0]) {
        linear_extrude(
            height=height/2,
            twist=twist,
            slices=slices,
            scale=overall_scale
        ) {
            circle(r=radius, $fn=sides);
        }
        translate([0, 0, height/2])
        {
            linear_extrude(
                height=height/2,
                twist=twist,
                slices=slices,
                scale=(1/overall_scale)
            ) {
                circle(r=radius*overall_scale, $fn=sides);
            }
        }
    }
    
    scales=[1, 1.4, 1.43, 1.45, 1.5];
    iterations = len(scales) - 1;
    for (i  = [0:iterations - 1]) {
        current_scale = scales[i + 1];
        previous_scale = scales[i];
        echo(current_scale);
        echo(i);
        translate([0, 0, i * (height / (2 * iterations))]) {
            linear_extrude(
                height=height/(2 * iterations),
                twist=twist/iterations,
                scale=current_scale
            ) {
                rotate(-i * (twist / iterations)) {
                    circle(r=radius*previous_scale, $fn=sides);
                }
            }
        }
    }
}
