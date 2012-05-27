---
layout: post
title: "Generalized Motion Blur idea"
date: 2012-05-26 14:03
comments: true
categories: 
---

The are several existing techniques
to apply Motion Blur,
each with a slightly different purpose and outcome.

I will try to roughly classify those techniques
by showing the method behind,
and then propose a possible generalization
that allows to apply those different techniques to the same scene
in a computation economical way.

Ideally, rendering at high framerates (>60 fps)
would not require any motion blur,
as the human brain would create
the impression of blur
to compensate for the
eye's framerate of 24 fps.
Sadly, such an approach is
technically
-- rendering a 60+ frames
on curreny gen consoles
is hardly possibly
or would require other limitations
in terms of rendering quality --
and artistically limited
-- motion blur might be wanted
to express certain aesthetics --
hence not practical.

The main goal is
to apply several kinds
of motion blur
to a given scene
in a as little
drawcalls and fullscreen passes as possible,
and also
using a little framebuffers (memory consumption) as possible.

I will also write about
possible ways to further optimize
the processus.


## Types of Motion Blur

### Last Frame Blended Motion Blur
This motion blur processus consists
in blending the (n) last frame(s)
with the current frame,
which results in an
impression of after image.

In the old OpenGL versions,
it could be implemented using an Accumulation Buffer,
but on modern machines,
I would implement it
to use the last frame's final image
(i.e. blurred with frame (t-2)'s final image)
as an input to blend with the current frame's final image.
This would result in a series of recursive blurs,
which might give a nice result.

On the downside, this would have me
store a fullres buffer of frame (t-1),
and possible fast camera movements
might yield very strange results,
such as after images instead of blurred lines.


### Object Deformation Motion Blur
This motion blur processus consists
in deforming moving objects
in the vertex shader
along their
frame interpolated movement vector.

It was used in a demo from AMD (insert link)[here].

The difficulty of the method lies
in the vertex shader
where we would need to transform
the vertices differently,
according to
their position relative to the center of the object
and the motion vector.
This works for simple objects where
the start and end of said object are easily defined
(e.g. spheres, as in the AMD demo),
but becomes more difficult
as the object's shape gets more complex.
(Although it could be done by
approximating each vertex to a unit sphere
around the center of the object
and distort vertices
from the lower hemisphere
with respect to the motion vector.
Something like this (untested):
```
float3 posRadius = normalize(os_position);	//unit sphere radius vector for a given vertex in object space
float hemisphere = sign(dot(posRadius, normalize(vMotion)));	//define which part of the sphere of the sphere we're on, w/r to the motion vector
os_position += vMotion * saturate(-hemisphere);	//distort the vertex along the motion vector when on the lower hemisphere
// continue vertex transform as usual
```
) The result of this is unpredictable, though,
and might lead to strangely deformed shapes).


On modern PC GPUs, this could be solved by issuing
more vertices to be drawn via a geometry shader.
Current gen console GPUs on the other don't
support geometry shader per se,
making this approach not practical
for cross-platform titles.


### Camera Motion Blur
This blur is applicable as post-processing effect,
as it does not modify any geometry.
It consists of using the current and the previous frames'
view-projection matrices to reproject the Z-buffer
into world space, and to build a difference in position (the movement)
from the coordinates.

```
float4x4 invViewProj_curr;
float4x4 invViewProj_prev;


float zDepth = tex2D(depthBuffer, ssTC);
float4 sscoords = float4x4(ssTC, zDepth, 1);

float4 wpos_curr = mul(invViewProj_curr, sscoords);
float4 wpos_prev = mul(invViewProj_prev, sscoords); 

float4 wmov = wpos_curr - wpos_prev;
```

We can then project the movement vector back to screen space
and use it to apply a linear blur on the scene texture.

### Object Motion Blur
This blur method requires the blurred objects
to be drawn in another render pass,
which resulting buffer is used later
to apply a per-pixel linear blur.

For each object,
we pass its current and previous world matrices as input,
project the project into screen space,
and write the per-pixel movement
computed from transforming each of the objects vertices
by the current and previous world space matrices.

Most of the work can be done in the vertex shader,
and the position difference can be done in the pixel shader for accuracy.


```
float4x4 World_curr;
float4x4 World_prev;
float4x4 ViewProj;

struct VS_OUT
{
    float4 HPos : POSITION;
    float4 wp_curr : TEXCOORD0;
    float4 wp_prev : TEXCOORD1;
};

VS_OUT VS_main(float4 Position : POSITION)
{
    VS_OUT out = (VS_OUT)01;
    
    float4 w_curr = mul(World_curr, Position);
    float4 w_prev = mul(World_prev, Position);
    
    out.HPos = mul(ViewProj, w_curr);
    out.wp_curr = w_curr;
    out.wp_prev = w_prev;
    
    return out;
}

float4 PS_main(VS_OUT in) : COLOR0
{
    float4 Color = (float4)0;
    
    float4 wp_diff = in.wp_curr - in.wp_prev;
    Color = wp_diff;
    
    return Color;
}

```

Then again, as for the Camera motion blur,
we use this movement vector
(projected into screen space)
as input to the linear blur.


### Animation Motion Blur
This method is an extension
upon the object motion blur
for skinned objects
that takes the animation into account
to build the motion vector.

As such, the motion vector will be
the difference between
the world position of one vertex
using the current skin and world space matrices
and the world position of the same vertex
using the previous skin and world space matrices.

The algorithm differs
depending on how
the skinning is computed,
but given the case it's done on the GPU,
it will look like follows:

```
float4x4 World_curr;
float4x4 World_prev;
float4x4 ViewProj;

float4x4 skinning_matrices_curr[n];
float4x4 skinning_matrices_prev[n];

struct VS_OUT
{
    float4 HPos : POSITION;
    float4 wp_curr : TEXCOORD0;
    float4 wp_prev : TEXCOORD1;
};

VS_OUT VS_main(
    float4 Position : POSITION,
    float4 Weight : TEXOORD0,
    int4 Indeces : TEXCOORD1
)
{
    VS_OUT out = (VS_OUT)01;
    
    float4 skinnedPos_curr = computeSkinnedVertex(Position, Indeces, Weight, skinning_matrices_curr);
    float4 skinnedPos_prev = computeSkinnedVertex(Position, Indeces, Weight, skinning_matrices_prev);    
    
    float4 w_curr = mul(World_curr, skinnedPos_curr);
    float4 w_prev = mul(World_prev, skinnedPos_prev);
    
    out.HPos = mul(ViewProj, w_curr);
    out.wp_curr = w_curr;
    out.wp_prev = w_prev;
    
    return out;
}


```

The final movement vector
and linear blur computation
is the same as in the
Object motion blur.


## Generalization
Since 3 (4 with some algorithmic changes) of these methods
consist of writing the motion vector
into a motion (or velocity) buffer,
and using this buffer as input to
a per-pixel linear blur,
generalizing the blurs seems straightforward.

We choose a texture format
that allows blending
and signed values.
On Xbox360, such a format would be the 32-bit 
`D3DFMT_Q8W8V8U8`
or its 64-bit counterpart
`D3DFMT_Q16W16V16U16`.

Since the Xenon GPU does not allow floating-point textures
to be blended, it would be impractical to use such formats
and doing the blending after a readback of the previous draw pass,
as this would imply a lot of resolving and texture fetches.

Unsigned formats, on the other hand, make the
writing of negative values impossible,
hence they fall out of choice for screen or world space motion vectors.

As such, the generalized algorithm looks as follows:  
1.  write the Z-Buffer reprojected Camera motion into the velocity buffer as an opaque blend to overwrite any existing value from the previous frame.  
2.  write the Object motion with Z-testing against the previously used Z-buffer to avoid writing more than necessary. Blending should be additive.  
3.  write the Skinned Object motion in the same way, blending additively.  
4.  write some motion vectors (more on that in an ulterior post) 
5.  resolve into a texture of possibly the same format as the render target surface.
6.  using this velocity texture, apply a per-pixel linear blur on the scene texture.



## More blurring...
We can optimize and even batch more blurring into the motion blur pass,
but I will post more on it a later post.

**tl;dr**  
There are several types of Motion blur passes,
and they can be batched for a more optimal render process.
More on blurring later.



