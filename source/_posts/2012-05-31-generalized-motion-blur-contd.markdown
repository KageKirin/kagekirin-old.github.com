---
layout: post
title: "Generalized Motion Blur (cont'd)"
date: 2012-05-31 01:17
comments: true
categories: ["graphics", "post-processing effects"]
---

I hope to cover some more aspects and enhancements of the
Generalized Motion Blur
I have not treated in my previous post.

As such there are:

*   particle motion blur  
*   generating other blur patterns through a different kind of particles  
*   batching screen-space deformation to our scene buffer lookups.


## Particle Motion blur

Particles,
especially fast moving ones,
should get a motion blur as well
to improve realism.
This can be done in the same way
we did it for object motion blur (unskinned geometry),
namely by computing and writing out the
frame-based position difference,
but there are a few things to take care of.

### Alpha testing and translucence
I did not cover this in the previous post,
but it pretty clear that alpha tested or alpha blended
geometry ideally requires the motion blur
to take the blending into account.  
Practically, not taking it into account
might lead to a few artifacts,
but I doubt they would be that visible in the final result,
so we can ignore this part
and simply blend this motion vector
on top of the motion in the buffer.
(We can alter the motion length by some factor
to account translucency
and to make it less apparent).

### World transform matrices
Depending on your architecture,
particles might get computed a bit differently
from normal objects.
While objects can be drawn one by one
using their world transform matrix,
this is likely to not being that optimal
when it comes to drawing thousands of particles.
In this, it is going to require
a little extra engineering effort
to buffer the last frame's particle positions
and to inject them into the drawing of this frame's ones
during the motion blur pass.

As this will double the drawcall cost,
it seems wiser to detect the particles that really
need motion blur,
and to just draw these.

### Geometry deformation
I covered this method in my previous post,
stating that its result might be unpredictable.
This still holds true for complex geometry,
but in the case of particles,
the geometry ought not be too complex,
since most particles are just quads
rendered as billboards.

Since rendering motion blur
on top of already blurred particles
will look pretty bad,
such motion blur deformed particles should
rendered after the motion blur pass.
But there is another type of particles,
that could avoid us the work required to
either blur thousands of particles at once,
or to separate the particle passes into
motion-blur-deformed and normal ones.


## Motion blur particles
(I did not find a better name despite intensive brainstorming, so beer with it).

The idea is to (slightly) abuse
the generalized motion blur method
by writing motion vectors
directly into the motion buffer.
This allows us to have a finer control
over what kind of motion vectors get written,
as they are based on a "motion vector" texture.  
For example,
a motion texture can hold a unique direction
-- the texture being then of one color with no grading --
and turn this vector to the "right" direction through rotation
to write a motion vector.

But since this texture based,
we can go one step further,
and use this method to generate
other blurs,
that are usually drawn in other passes.
Best example would a radial blur,
which is nothing more than a linear blur,
following centroid lines.

In fact, this is the point
where the generalized motion blur
can play its strength,
by allowing us to batch more
effects into one single pass.  
The next section covers even more batching.


## Screen-space warping/refraction/deformation
The main idea is
to batch particle based effects,
that produce a refractive-like visual,
like heat-haze or underwater "wobbling",
into the motion blur pass.  
Since the linear blur pass
mostly consists of texture fetches
from the scene buffer,
we can piggy-back on this
by "jittering" or "warping",
thus deforming,
the screen-space texture coordinates.

To batch this into our existing framework,
we need to change the layout of the motion buffer a bit.
Since the "warping" is nothing more
than offsetting the screen-space coordinates,
it requires 2 channels to be effective.
Hence, the motion vector has to be reduced to 2 channels as well,
which can be achieved by projecting the motion vector
into screen-space first,
and then write its 2 values
into the 2 remaining channels.

Using a QWVU texture format
(Q8W8V8U8 or Q16W16V16U16,
but not A2W10V10U10 since we need the Q-channel as well),
the new buffer layout looks as follows:

```
[    U8V8     ][     W8Q8      ]
[ssVelocity.xy][ssWarpOffset.xy]
```
(I reversed the channel order for simplicity).

### Drawing offsets

Just as with the motion vectors,
we can write the offset vectors
into the 2 channels of the motion buffer.
Writing needs to be additive as well,
to accumulate offset movements
from different layers
of particles,
so nothing really differs
from the motion (particle) passes,
but the target channels.
To avoid writing into the wrong channels,
one can set up write masks before the draw pass
(and reset them at the end).

Particles need to be Z-tested against the Z-buffer
to mask out foreground geometry,
and can profit from being smoothly depth-blended,
by modulating their strength
with respect to a factor
depending on the Z-buffer pixel depth
and the particle's.
But these conditions have to fulfilled
for the motion blur particles pass
as well.

To further optimize the particle passes,
it's possible to batch drawing
the motion blur particles
and the warp particles
at the same,
going as far as modifying the shader
to draw both values at once as needed.


So far for the second post on the
Generalized Motion Blur method.
We covered which particle passes
can be batched
and why drawing all particles again
to generate a motion vector field on them
might not be such a good idea.

In the next posts of the series,
We will cover the different aspects
of the actual linear blur pass,
and show even more effects
that can be batched into it.

**tl;dr**  
Bad idea: Drawing thousands of particles twice to generate motion blur on them.  
Good idea: Drawing special particles with motion vectors is more efficient.  
Super idea: Batch screen-space warping particles into the motion particles.  