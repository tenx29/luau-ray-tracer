# Render pipeline

Luau Ray Tracer uses a relatively simple path tracer to render images. The path tracer is implemented as a recursive function that traces rays from the camera to the scene. Ray bounces are created using user-defined shader objects.

```mermaid
flowchart LR
    subgraph Traced Ray
        A[Ray] --> B[Termination data];
        B --> C[Shaders];
        C -.-> R[Bounced Rays];
        R -.-> C;
        C --> D[Ray output];
    end

    subgraph Ray Tracer Buffers
        E[Color];
        F[Depth];
        G[Normal];
        I[Custom buffers];
    end

    B --> D;

    D --> E;
    D --> F;
    D --> G;
    D --> I;

    E & F & G & I <---> H[Post-processing shaders];
```