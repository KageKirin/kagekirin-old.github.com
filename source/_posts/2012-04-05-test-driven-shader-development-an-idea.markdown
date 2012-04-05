---
layout: post
title: "Test-Driven Shader Development (an idea)"
date: 2012-04-05 00:57
comments: true
categories: ["shader", "TDD"]
---

This post is more about an idea I had, than about its actual implementation.

Test-driven Shader Development

## Base idea
When doing shader development,
be it for R&D purposes or in a production environment,
you will run into a couple of possible issues:

-   shader not compiling
-   shader not linking (in GL)
-   incompatible vertex and pixel shader due to interpolator differences (Cg, DX)
-   shader not running due to wrong input
-   shader running but not giving the expected result (algorithmic error)
-   shader not returning the expected result due to wrong input
-   wrong output from one shader breaking another shader (happens often when playing with lighting models)
-   shader computationally too heavy (instruction-bound or texture-fetch-bound)
-   a lot of other stuff that can go wrong, and by Murphy's law, will go wrong.

In many of these cases,
nailing the problem down to a few causes,
at best a single one,
will allow for fast solutions
and let the programmer focus on the more interesting parts.

## Compiler/Driver issues
Those are mostly issues related to building and loading the shader.

The straightforward solution is to implement hot reload,
i.e. reloading while the engine or test environment is running,
and this everytime the shader file is saved.

The apported benefit is that this will allow for shader cooking,
i.e. editing and tweaking of the shader depending on its "visual" result.  
(One of the features I loved on CryENGINE3, and that I'm totally missing on the current engine at work).

An optimization to this:  
reload everytime a hash value depending on the full shader source,
i.e. the `main` function file and all of its includes, changes.

## Input issues

The straightforward solution is to have "static" inputs.
Those can be:

-   static textures to simulate a GBuffer
-   static camera values
-   static uniform settings
-   static vertex settings

In the same idea, being able to tweak parameters and see its outcome is likely to help finding input values that lead to computational errors. (Div-by-zero anyone?).

## Output issues

This kind of issues can be caught by creating a difference image to either  
-   a "reference" image (e.g. created through raytracing instead of rendering)
-   the last "good" result image

The frame "correctness" is the amount of errors/differences in relation to the reference image.

## Algorithmic issues
-   using "random" inputs
    -   shuffle inputs several times, test if output is correct

## Saving the tests
A great addition for this kind of framework is to save the test "artifacts" (in Jenkins' terms) along with its inputs to allow for later reproducibility.

-   inputs: the shader files, static input values, user input values
-   artifacts as such would be: random input values, output frames


## Generalization
Such a framework would be great to be generalized to work with both Direct3D (several versions, but at least DX9.5 for Xenon and DX11.1) and OpenGL (several versions as well, but ES2 would make my day).
And support for the exots like GX2 ("Café") and GCM (PS3, Vita). (The shader in latter systems are based on GLSL and Cg, respectively, making the porting easier).

Furthermore, OpenCL and ComputeShaders would equally profit fropm such a system.
(As would SPU jobs do, but that's limited to a certain type of hardware).

A general solution would allow to have "any" kind of data
processed by "any" kind of "processor", be it DX, GL, CL or C++AMP.

** tl;dr** Is there some student/grad student that would feel like implementing such a system as a master/diploma/doctorate thesis?

