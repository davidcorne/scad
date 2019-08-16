//============================================================
// A twisty vase
//------------------------------------------------------------
$fn = 150 ;			// OpenSCAD Resolution


CurvedVase(sides=6, radius=15, height=20);

//------------------------------------------------------------
module OldVase(sides, radius, height)
{
    twist=360/sides;
    scale=1.5;
    slices=height/4;
    linear_extrude(height=height/3, twist=twist, scale=scale, slices=slices) {
        circle(r=radius, $fn=sides);
    }
    translate([0, 0, height/3])
    linear_extrude(height=height/3, twist=twist, slices=slices) {
        circle(r=(radius * scale), $fn=sides);
    }
    translate([0, 0, 2*(height/3)])
    linear_extrude(height=height/3, twist=twist, scale=(1/scale), slices=slices) {
        circle(r=(radius * scale), $fn=sides);
    }
}

//------------------------------------------------------------
module Vase(sides, radius, height)
{
    twist=360/sides;
    // scale gets to 1.5
    scale=1.5;
    slices=height/4;
    
    next_radius=radius;
    iterations=2;
    for (i = [0:iterations-1]) {
        current_scale=1 + (i * ((scale - 1)/iterations));

        translate([0, 0, i * (height/iterations)])
        linear_extrude(
            height=height/iterations, 
            twist=twist,
            slices=slices,
            scale=current_scale
        ) {
            circle(r=next_radius, $fn=sides);
        }
        next_radius=radius*current_scale;
    }
}

//------------------------------------------------------------
module TwelfthVase(sides, radius, height)
{
    twist=360/sides;
    // scale gets to 1.5
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
    
    twelfth = (overall_scale - 1) / 12;
    translate([0, 0, 0]) {
        linear_extrude(
            height=height/12,
            twist=twist/12,
            scale=1 + twelfth
        ) {
            circle(r=radius, $fn=sides);
        }
    }
    translate([0, 0, height/12]) {
        rotate(-twist/12) {
            linear_extrude(
                height=height/12,
                twist=twist/12,
                scale=1 + (2 * twelfth)
            ) {
                circle(r=radius * (1 + twelfth), $fn=sides);
            }
        }
    }
    translate([0, 0, 2 * (height/12)]) {
        rotate(2 * (-twist/12)) {
            linear_extrude(
                height=height/12,
                twist=twist/12,
                scale=1 + (3 * twelfth)
            ) {
                circle(r=radius * (1 + twelfth) * (1 + 2*twelfth), $fn=sides);
            }
        }
    }
}

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
