---
layout: post
title: "Generalized Motion Blur - the linear blur and beyond"
date: 2012-06-02 13:32
comments: true
categories: ["graphics". "post-processing effect"]
published: false
---

Welcome to the 3rd part of our series about
Generalized Motion Blur.  
So far, we have covered  
*   writing motion vectors into a motion buffer (or velocity buffer)
*   generating motion vectors by reprojecting the Zbuffer using the current and previous frames' viewprojectrion matrices
*   generating motion vectors from skinned and unskinned geometry using their world and skin matrices at the current and previous frames' values
*   writing motion vectors directly through particles
*   deforming particles to simulate the blur on them
*   extending the motion blur to include texture coordinate offsetting to produce a texture warping effect.

But we left out the most crucial part of the whole linear blur,
namely the blurring,
which will eventually yield the desired motion blur effect.

So for this part, we will cover:  
*   the linear blur algorithm
*   a little enhancement to this algorithm
*   adding the screen-space distortion (aka warping)
*   some depth-dependent enhancements


## Which buffer to blur, and when

A little word on the buffers
we are going to apply the linear blur to
before we start with the blur algorithm.

In order to conserve
the energy of lit elements,
by propagating bright streaks,
which yields physical accuracy,
the blur has to be applied
on the scene buffer in linear space,
i.e. using the HDR values
and before performing the tone mapping
which remaps the values into non-linear LDR.

This might be costly,
as texture fetches are more expensive
on HDR textures
(notably on 16-bit floating-point textures).
That said, there are some ways to improve the GPU time,
e.g. by copying the scene buffer in a half-res texture first 
and doing all the texture fetches from this buffer
(which improves the time spent on texture fetching a lot),
writing the blur into a half-res buffer as well
(less pixels to process, and faster resolving)
and blending this buffer with the full-res scene buffer
(which I do not plan to cover in this post).


## Vanilla linear blur

The 'vanilla' algorithm is pretty simple:  
Given a screen-space vector and a screen-space texture coordinate,
take _N_ samples along the vector in regular intervals,
starting at the texture offset.
The mean average of the samples yields the linear blur.

```
sampler2D sceneTex;
uniform unsigned int numSamples;

float4 blur(float2 baseTC, float2 blurVec)
{
	float4 color = (float4)0;
	for(int i = 0; i < numSamples; ++i)
	{
		color += tex2D(sceneTex, baseTC + i * blurVec);
	}
	return color / numSamples;
}
```

## Linear blur with motion buffer

In this code sample, you would obviously have

## Biased linear blur
instead just creating the average, we can weight and bias the samples.
e.g.

### Silhouette-biased linear blur
The goal is to apply a stronger blur on the silhouette of the geometries,
while conserving most of the details on their surface.
This is more an stylistic effect.

Using the Normal buffer,
we compute the rim of each object with respect to the view vector
and use it as a factor to weight and bias the samples
```
color = tex2D(sceneSampler, centerTC);
normal = getNormal(tex2D(normalSampler, centerTC));
sum = 1;

NdotV = dot(normal, view); 
rim = 1 - saturate(NdotV);
factor = bias + weight * rim;

for each sample:
	color += factor * tex2D(sceneSampler, centerTC + sample_motion * i);
	sum += factor;
	
color /= sum;
```

## Linear blur with warping


## Depth-dependent enhancements
### Depth-dependent heat-haze
compute slight noise, which strength is dependent on the scene depth.
the "fog" algorithms can come in handy for this
exp(z, 4)

### scene depth fog
compute fog value and lerp towards fog color inside the blur pass

### Depth of Field
You saw it coming, you can even batch DoF inside the blur.
More in a new post.
