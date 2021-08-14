import numpy as np
from utils import w_calculator


def HDR_radiance_map_grayscale(g, Z, ln_tj, epsilon=1e-12, n=256):
    w_vals = w_calculator(Z, n=n)+epsilon
    g_vals = g[Z]
    num = np.sum(w_vals*(g_vals-ln_tj), axis=1).reshape(-1, 1)
    den = np.sum(w_vals, axis=1).reshape(-1, 1)
    Ei = np.ravel(np.exp(num/den))
    return Ei


def HDR_radiance_map_RGB(r, g_r, g, g_g, b, g_b, B, epsilon=1e-12, n=256):
    _, image_size = np.shape(r)
    final = np.zeros((3, image_size))
    final[0] = HDR_radiance_map_grayscale(g_r, r.T, B, epsilon=epsilon, n=n)
    final[1] = HDR_radiance_map_grayscale(g_g, g.T, B, epsilon=epsilon, n=n)
    final[2] = HDR_radiance_map_grayscale(g_b, b.T, B, epsilon=epsilon, n=n)
    return final
