# mapping_DSP_algorithms_to_hardware
All verilog, C/C++ and python codes used for "EE5332: Mapping digital signal processing algorithms to hardware" course at [IIT Madras](https://www.iitm.ac.in/), along with their usecase and summary is available. The course content (reading material, videos, etc.) can be found [here](https://www.youtube.com/playlist?list=PLco7dux9L7g1RrB8TqUVCMEeu86D7azeg).

## Reference
1. Read multiple papers on **efficient** FFT implementation and finally followed the approach in this [paper](https://ieeexplore.ieee.org/document/5776727). 
2. The above proposes novel **systematic** approaches for parallel & **pipelined (retimed)** architectures using **folding transformations** for computation of complex and real FFT, based on **radix-2n** algorithms, for better throughput & reductions in total area. 
3. Find a **short review** of that paper written by me [here](https://drive.google.com/file/d/13EEr6RtAh5V6N4mWk3bindacHIKLSNrA/view?usp=sharing).
