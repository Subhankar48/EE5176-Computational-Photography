import os
from tqdm import tqdm
import numpy as np
from imageio import imread


def w_calculator(Z_vals, n=256, Z_max=None, Z_min=None):
    if Z_max is None:
        Z_max = n-1
    if Z_min is None:
        Z_min = 0
    half_intensity = (Z_max+Z_min)/2
    w = np.zeros_like(Z_vals)
    truth_array = Z_vals <= half_intensity
    w[truth_array] = Z_vals[truth_array] - Z_min
    w[~truth_array] = Z_max - Z_vals[~truth_array]
    return w


def read_images(filename_base='exposure', n_exp_vals=16, filetype='jpg', folder='data'):
    all_images = {}
    print(f"Reading {n_exp_vals} images...")
    for i in tqdm(range(1, n_exp_vals+1)):
        filename = filename_base+str(i)+'.'+filetype
        filepath = os.path.join(folder, filename)
        image = imread(filepath)
        all_images[i] = image
    return all_images


def format_images(image_dict):
    keys = list(image_dict.keys())
    n_images = len(keys)
    x, y, _ = np.shape(image_dict[keys[0]])
    r = np.zeros((n_images, x*y))
    g = np.zeros((n_images, x*y))
    b = np.zeros((n_images, x*y))
    print(f"Formatting {n_images} images to be in the required shape...")
    for i in tqdm(range(n_images)):
        key = keys[i]
        image = image_dict[key]
        r[i, :] = np.ravel(image[:, :, 0])
        g[i, :] = np.ravel(image[:, :, 1])
        b[i, :] = np.ravel(image[:, :, 2])
    return r, g, b

def get_N(image_dict, Z_max, Z_min, im_size_fraction = 0.00001, scale_factor = 20):
    keys = list(image_dict.keys())
    n_images = len(keys)
    x, y, _ = np.shape(image_dict[keys[0]])
    imsize = x*y
    min_points = scale_factor*((Z_max-Z_min)//n_images+1)
    N = max(im_size_fraction*imsize, min_points)
    return int(min(N, imsize))