import numpy as np


def gsolve_grayscale(Z, B, l, w, n=256):
    x, y = np.shape(Z)

    A = np.zeros((x*y+n+1, n+x))
    x_, _ = np.shape(A)
    b = np.zeros((x_, 1))

    k = 0
    for i in range(x):
        for j in range(y):
            wij = w[int(Z[i, j])]
            A[k, int(Z[i, j])] = wij
            A[k, n+i] = -wij
            b[k] = wij * B[j]
            k += 1

    A[k, int(np.ceil(n/2))] = 1
    k = k+1

    for i in range(n-2):
        A[k, i] = l*w[i+1]
        A[k, i+1] = -2*l*w[i+1]
        A[k, i+2] = l*w[i+1]
        k += 1

    x = (np.linalg.pinv(A))@b
    g = x[:n]
    lE = x[n:]

    return g, lE


def sampler(r_, g_, b_, n_points):
    _, y_ = np.shape(r_)
    indices = np.random.choice(np.arange(y_), size=n_points, replace=False)
    r = r_[:, indices]
    g = g_[:, indices]
    b = b_[:, indices]
    return r, g, b


def gsolve_RGB(r_, g_, b_, B, l, w, n_points, n=256):
    r, g, b = sampler(r_, g_, b_, n_points)
    g_r, lE_r = gsolve_grayscale(r.T, B, l, w, n)
    g_g, lE_g = gsolve_grayscale(g.T, B, l, w, n)
    g_b, lE_b = gsolve_grayscale(b.T, B, l, w, n)

    return g_r, lE_r, g_g, lE_g, g_b, lE_b
