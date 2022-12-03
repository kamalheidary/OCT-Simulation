# OCT-Simulation
optical coherence tomography simulation package


# As a part of my MSc thesis, I developed a MATLAB code for simulating Optical Coherence Tomography. 

Optical Coherence Tomography (OCT) is a 3D imaging method that is widely used for biomedical applications. The basic principle of OCT is measuring the interference of a low-coherence light source.

By using numerical methods and simulating OCT and applying real effects like vibration, it will be possible for us to optimize the operation of analyzing and deconvolution of an actual OCT signal. 


In this code, we developed our simulation approach for generating a virtual laboratory for FD-OCT. We tried to develop an adaptive virtual lab to apply arbitrary samples and control the features of the light source and the spectrometer with arbitrary errors and noises in MATLAB programing language.

In this simulation, we used the angular spectrum method to propagate the light and Fersenel equations to calculate reflection and transition fields. Also, we applied vibration noise and dispersion of the sample. We can control the entrance angle of the light. For a model, we simulated and analyzed a single OCT signal from a human eye. Here we used a gaussian distribution for the beam's intensity and shape of the light source's spectrum. 

The center wavelength of the light source is considered 850 nanometers with a bandwidth of 40 nanometers. The resolution of the spectrometer assumed 0.1 nanometers. Here we considered an uncertainty of 50 micrometers for the sample and a Gaussian noise added to the interference signal. Also, we thought of up to three times of beam reflections into the layers of the sample.

All of the parameters in this simulation can change easily.
Parameters like the center wavelength, the bandwidth, resolution of the spectrometer, type, amplitude and range of vibration, number of reflection beams between layers,  number of layers and...




# These are my codes and I will be happy to develop them by somebody to write a paper. This idea can be about applying a novel deconvolution method, applying scattering and ....
 
