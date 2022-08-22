# Render pipeline

Luau Ray Tracer uses a relatively simple path tracer to render images. The path tracer is implemented as a recursive function that traces rays from the camera to the scene. Ray bounces are created using user-defined shader objects.

```mermaid
flowchart LR
    subgraph Traced Ray
        A[Ray] --> B[Termination data];
        B --> C[Shaders];
        C -.-> R[Bounced Rays];
        C --> D[Color];
        R -.-> D;
    end

    subgraph Ray Tracer Buffers
        E[Color];
        F[Depth];
        G[Normal];
    end

    D --> E;
    B ----> F;
    B ----> G;

    E & F & G <---> H[Post-processing shaders];
```