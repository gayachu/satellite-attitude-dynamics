# satellite-attitude-dynamics
A dynamical systems approach to satellite attitude dynamics. Investigating stability under disturbance torques and implementing control to suppress chaos.

## Overview
- Derived Euler’s rotational dynamics under disturbance torques.  
- Simulated system response in MATLAB.
- Used dynamical systems tools to analyze whether behaviour is stable or chaotic.
- Applied proportional control to suppress chaotic behaviour.  
- Identified stable regimes for attitude control.

## Equations

The system is given by:

$$
\dot{x} = \tfrac{1}{3} yz - a x + \tfrac{1}{\sqrt{6}} z
$$

$$
\dot{y} = - x z + b y
$$

$$
\dot{z} = x y - \sqrt{6}x - c z
$$

Where $x = \omega_x, \quad y = \omega_y, \quad z = \omega_z$ and $a = 0.4, \quad b = 0.175, \quad c = 0.4.$

Note: The values of the inertial axes are $I_x = 3, I_y = 2, I_z = 1,$ meaning the intermediate axis y will always be unstable.

## Initial condition
Initial condition for all simulations is (x,y,z) = (3,4,2), unless stated otherwise.

## Results
- Without control: chaotic divergence under disturbance torques
  - Phase Portraits
    <img width="1193" height="827" alt="image" src="https://github.com/user-attachments/assets/59bb70fb-4341-4230-bd94-4817c7e1a253" />
    <img width="1338" height="441" alt="image" src="https://github.com/user-attachments/assets/bd91c86f-4169-4855-9cfa-7f85bf6e7ca1" />
    - Tangles and loops, motion is bounded but never repeats, classic hallmarks of chaotic behaviour.
  - Bifurcation Diagram
    <img width="1016" height="940" alt="image" src="https://github.com/user-attachments/assets/42e27f82-fb64-45e2-9f5b-9d2e34c9ae95" />
    - For values of $a,b,c$ in our equations, all three plots show scattered points and no coherent branches, confirming each coordinate lies squarely in the chaotic regime.
  - Poincare Sections
    <img width="1008" height="367" alt="image" src="https://github.com/user-attachments/assets/24c78951-5b95-4af6-a615-32f538b5fa90" />
    - Strange attractor observed.
    - When integrated for a longer period of time and using random initial conditions to fill out the phase space, we see the full structure of the attractor.
      <img width="747" height="603" alt="image" src="https://github.com/user-attachments/assets/eb455ccb-d22e-422e-affc-aa6638b8da34" />
      <img width="746" height="621" alt="image" src="https://github.com/user-attachments/assets/491b9165-3dcb-4d44-a89b-804195504d0c" />
      <img width="746" height="607" alt="image" src="https://github.com/user-attachments/assets/7136aae6-2042-436e-9b1d-1a0f795dd8a3" />

 - Control Strategy
    - Since b is associated with the intermediate axis and will always be unstable, we shift our focus to reducing a,c.
    - For smaller values of a and c, we observe stable branches in the bifurcation diagrams.
    - Will a reduction of both a and c result in stability, or are there only specific pairs?
    - To find out the pairs, we do a parameter sweep and identify which pairs of a,c converge to a stable fixed point which would then lead to stability.
      <img width="926" height="758" alt="image" src="https://github.com/user-attachments/assets/9df6fd68-06df-4341-84aa-1055732f48b9" />
    - For effective control, we need a small value of $a$ and a larger value of $c$, so a P-controller applied to the x-axis which would result in a decrease in the value of parameter a should suffice.
  
    - Equations
       - Equation before control - $\dot{x} = \tfrac{1}{3} yz - a x + \tfrac{1}{\sqrt{6}} z$ with $a=0.4$
        
       - Equation after  control - $\dot{x} = \tfrac{1}{3} yz - a x + \tfrac{1}{\sqrt{6}} z + Kx$ where $K = 0.3$
  
  - Time series plots
     - Before control
       <img width="848" height="880" alt="image" src="https://github.com/user-attachments/assets/c9fa8151-8d8f-4565-8dc4-56fd9f9bde05" />
     - After control ( $a$ now reduced to 0.1)
        
       <img width="848" height="880" alt="image" src="https://github.com/user-attachments/assets/7154ef29-a36c-4e7c-b3ec-7ef533cfae6f" />

      





    

 
