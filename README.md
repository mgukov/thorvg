# ThorVG

ThorVG is a platform-independent portable library for drawing vector-based shapes and images. It's written in C++, no dependencies and keeps super compact size. <br />
<br />
The next list shows drawing primitives ThorVG providing.<br />
 - Paints: Line, Arc, Curve, Path, Shapes, Polygons
 - Filling: Solid, Linear, Radial Gradient
 - Scene Graph & Affine Transformation (translation, rotation, scale ...)
 - Stroking: Width, Join, Cap, Dash
 - Composition: Blending, Masking, Path Clipping, etc
 - Pictures: SVG, Bitmap, ... 
<p align="center">
  <img width="930" height="212" src="https://github.com/Samsung/thorvg/blob/master/res/example_primitives.png">
</p>
<br />
Basically your program could use this library functions by calling slick and neat apis while switching drawing context (if you have your own drawing engine), ThorVG serializes drawing commands among volatile paints node, performs sync/asynchronous rendering by its decent engines. The engine is suggested to immediate rendering method so that your system could adaptively integrate with it. ThorVG supports vector images such as SVG, also will support coming popular formats by demands. On rendering, it might introduce intermediate frame buffers for compositing vector scenes but only when it's necessary and these are temporarily used for saving memory.
<br />
