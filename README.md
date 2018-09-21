**gravitysim** is a dos app for particle gravity simulation with velocity colored traces.
Particles are randomly created (random initial mass, position and velocity) for the simulation, based
on supplied statistics. Simulation is performed by calculation acceleration of all particicles in a
given situation using
[Newton's law of universal gravitation](http://en.wikipedia.org/wiki/Newton%27s_law_of_universal_gravitation).
The new position and velocity of particles is calculated based on this acceleration for a small time value.
This process is repeated again and again.

Simulation of gravity is interesting in that even simple simulations like these show how the solar system,
and its planets might have formed. The movement trace of the particles is indeed both wierd and elegant.
The number of particles used in the simulation can be changed, but as expected it will slow down the
simulation. Also the particles which move too close to each other afre assumed to collide 100%
[inelastically](http://en.wikipedia.org/wiki/Inelastic_collision).
The net momentum of the particles is conserved.


## demo

<img src="https://raw.githubusercontent.com/wolfram77/qb-gravity-simulation/gh-pages/0/image/0.png"><br/>
`Gravity Simulation` configuration menu.
<br/><br/>


<img src="https://raw.githubusercontent.com/wolfram77/qb-gravity-simulation/gh-pages/0/image/1.png"><br/>
`Particle count` is the initial number of particles.<br/>
`Gravity factor` is the strength factor of gravity.<br/>
`Time delta` is the time difference between each simulation iteration.<br/>
`Matter density` is used to determine the size of particles for given mass.<br/>
`Max. velocity` is the maximum possible velocity of particles.<br/>
`Max. range` is the maximum possible position difference between particles.<br/>
`Max. mass` is the maximum possible mass of particles.<br/>
**controls**<br/>
`WASD` - camera move<br/>
`QE` - camera zoom
<br/><br/>

<img src="https://raw.githubusercontent.com/wolfram77/qb-gravity-simulation/gh-pages/0/image/2.png"><br/>
<img src="https://raw.githubusercontent.com/wolfram77/qb-gravity-simulation/gh-pages/0/image/3.png"><br/>
<img src="https://raw.githubusercontent.com/wolfram77/qb-gravity-simulation/gh-pages/0/image/4.png"><br/>
<img src="https://raw.githubusercontent.com/wolfram77/qb-gravity-simulation/gh-pages/0/image/5.png"><br/>
<img src="https://raw.githubusercontent.com/wolfram77/qb-gravity-simulation/gh-pages/0/image/6.png"><br/>
Simulation results.
<br/><br/>


[![qb40](https://i.imgur.com/xAWLn0I.jpg)](https://qb40.github.io)
