import numpy as np
import matplotlib.pyplot as plt
from numba import njit

# Parameters
b = 0.175
x0 = np.array([3.0, 4.0, 2.0])  # initial condition
t_trans = 300.0
t_final = 1000.0

# Sampling details
Nsample = 100
t_samp = np.linspace(t_trans, t_final, Nsample)

# RK4 parameters
h = 0.2
T_full = np.arange(0.0, t_final + h/2, h)
idx_s = np.round(t_samp / h).astype(np.int32)

# Collapse tolerance
tol = 1e-5  

@njit
def rhs(u, a, b, c):
    x, y, z = u
    return np.array([
        (1/3)*y*z - a*x + z/np.sqrt(6),
        -x*z + b*y,
        x*y - np.sqrt(6)*x - c*z
    ])

@njit
def check_stable(a, b, c):
    u = x0.copy()
    ref = None
    samp_idx = 0

    for k in range(T_full.size - 1):
        # RK4 step
        k1 = rhs(u, a, b, c)
        k2 = rhs(u + 0.5*h*k1, a, b, c)
        k3 = rhs(u + 0.5*h*k2, a, b, c)
        k4 = rhs(u + h*k3, a, b, c)
        u = u + (h/6)*(k1 + 2*k2 + 2*k3 + k4)

        if samp_idx < len(idx_s) and k+1 == idx_s[samp_idx]:
            if ref is None:
                ref = u.copy()
            else:
                if np.linalg.norm(u - ref) > tol:
                    return False
            samp_idx += 1
            if samp_idx == Nsample:
                break
    return True

# Grid 
a_vals = np.linspace(0.05, 0.6, 121)
c_vals = np.linspace(0.05, 1.0, 101)

# Sweep
stable = []
for a in a_vals:
    for c in c_vals:
        if check_stable(a, b, c):
            stable.append((a, c))

# Plot
stable = np.array(stable)
plt.figure(figsize=(6,5))
if stable.size > 0:
    plt.scatter(stable[:,0], stable[:,1], s=10, color='C2')
else:
    print("No stable points found!")
plt.figure(figsize=(6,5))
plt.scatter(stable[:,0], stable[:,1], s=10, color='C2')
plt.xlabel('a')
plt.ylabel('c')
plt.title('Stable region in (a, c) plane')


plt.xlim(0.0, 1.0)
plt.ylim(0.0, 1.0)

plt.tight_layout()
plt.show()
