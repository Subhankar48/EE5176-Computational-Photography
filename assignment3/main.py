import matplotlib.pyplot as plt
from utils import *
from gsolve import *

n_exp_vals = 16
scale_factor = 2048
k = np.arange(n_exp_vals)
B = 2**k
B = np.log(B/scale_factor)
l = 1

n = 256
Z_max = n-1
Z_min = 0
Z_vals = np.arange(n)
w = w_calculator(Z_vals, n=n, Z_max=Z_max, Z_min=Z_min)

filename_base = 'exposure'
filetype = 'jpg'
folder = 'data'

all_images = read_images(filename_base, n_exp_vals, filetype, folder)
N = get_N(image_dict=all_images, Z_max=Z_max, Z_min=Z_min,
          im_size_fraction=0.00002, scale_factor=40)
print(f"Choosing {N} random points...")

r, g, b = format_images(all_images)
g_r, lE_r, g_g, lE_g, g_b, lE_b = gsolve_RGB(r, g, b, B, l, w, n_points=N, n=n)

plt.plot(g_r, Z_vals)
plt.plot(g_g, Z_vals)
plt.plot(g_b, Z_vals)
plt.show()
