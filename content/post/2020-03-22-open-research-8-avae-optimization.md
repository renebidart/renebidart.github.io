---
author: Rene Bidart
date: "2020-03-22T00:00:00Z"
title: 'Open Research 8: Optimizing Affine Transforms in VAEs'
---


### Optimizing Affine Transforms in VAEs
Our goal is to create a VAE which will only encode a subset of affine transforms, but generalize to all. This is shown below:
![avae_3d.png](../avae_3d.png)

[Previously](https://renebidart.com/post/or5/2020-03-02-open-research-5/) we showed takes a higher capacity VAE to encode all possible orientations of an object, compared to encoding a single orientation. Our goal is to create a smaller model by only encoding a subset of all orientations, but still generalize to all orientations at inference. But how can we do this, given a dataset at random orientations?

Because the VAE is a generative model, we can the optimize an affine transform to find the orinetation at which the VAE best encodes the data, or has lowest loss. Our approach is to use an inner optimization loop during training to optimize this affine transform. The goal is that this will force the model to encode only a subset of the distribution. Then at inference time, this affine optimization can be used to allow the model to generalize to all orientations.

Normally stochastic gradient descent is used to update the parameters of the network to reduce the loss of the VAE. Here we will take another approach, where the forward pass of the VAE will include an optimization over a set of parameters, where the parameters are optimized to reduce the VAE's loss, maximizing the ELBO. These are the parameters of an affine transform, so the process corresponds to finding the optimal orientation to encode an object at. This optimization objective is shown as:

$\underset{\alpha}{\text{argmin}}\\{ L_{VAE}[\tau_{\alpha}^{-1}(p_\rho(q_\phi(\tau_{\alpha}(x))))]\\}$

To train a network of this form is very expensive, because the above optimization must be solved once for each forward pass. As I discussed [before](https://renebidart.com/post/or7/2020-03-17-open-research-7/), optimizing $\alpha$ is differentiable, but is likely to get caught in a local optima. To overcome this, we evaluate the performance at a number of different random initializations of $\alpha$, and then select the top k of these initializations to do gradient descent on. Here we used 32 random initializations, and did gradient descent on the top 8 of these.

These tests take a while to run, so we'll look at results later, and give a rigorous interpretation of the above in terms of variational inference.