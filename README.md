# cochlear-implant-signal-processor

A simple cochlear implant sound processor constructed using Matlab’s filterDesigner and evaluated by how well the rectified signals matched original testing sound files. 

The signal processor reads the inputted sound file, processes it and outputs the filtered sound file. The final processed output signal consists of N combined frequency bands.

One iteration of the initial design solution was performed by changing the Highpass and Bandpass filter types and the number of frequency channels (N).

Files:
- final_filter_designer.m (final iterated signal processor)
- filterDesigner (consists of Highpass/Bandpass filters experimented with during filter designing)
- iterations (iterations of different combinations of filters used to optimize design)
- input_files.zip (input files used to evaluate filter design)
- output_files.zip (final output files)

Filter Design
<img width="938" alt="43030855-7394cdb8-8c64-11e8-987d-3579021c74fb" src="https://user-images.githubusercontent.com/80727252/189493075-a47c7655-424a-4076-bf57-295db77faf5c.png">
