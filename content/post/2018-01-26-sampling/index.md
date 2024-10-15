---
author: Rene Bidart
date: "2018-01-26T00:00:00Z"
title: Sequential Stratified Sampling
---

## Stratified Sampling
We want to get the estimate the mean of a population, and this population is broken into different groups. As long as these groups are homogeneous, we can produce a better estimate by estimating the means of the groups individually. For example, we could estimate the mean math ability of students in Ontario by dividing it up by schools. By allocating more samples to the schools with higher number of students and variance in ability, we can get a better estimate overall. 

Back in 1934 [Jerzy Neyman](http://www.stat.cmu.edu/~brian/905-2008/papers/neyman-1934-jrss.pdf) proved that the optimal way to allocate the number of samples for each stratum, $n_h$ is proportional to its standard deviation, $\sigma_{yh}$, and its size $W_h$: 

$$
n_h \propto W_h\sigma_{yh}
$$

In reality we won't know the stratum variances, so alternative methods using auxiliary information or two stage sampling to get an estimate of the variances are used. The two sample method is not optimal, and auxillary information may not be availiable. 

Today there are situations where we can take samples sequentially, which may not have been possible when these methods were first developed, such as with an online survey where it is easy to distribute and quick to analyse results, but may be costly to pay an individual to complete it. Here we will allocate each sample individually, but how do we pick which strata to sample from?


## Sequential Sampling

We will think of sampling over a number of time steps, taking one sample from a given stratum at each time. The goal is to sample from the stratum that will cause the largest expected decrease in variation of our estimate, ȳ at each iteration. We would like to find i to maximize:

V(ȳ<sub>st, i</sub>) - V(ȳ<sub>st</sub>) = ∑<sub>h=1</sub><sup>H</sup> W<sub>h,i</sub><sup>2</sup>(1 - n<sub>h,i</sub>/N<sub>h,i</sub>)s<sub>yh,i</sub><sup>2</sup>/n<sub>h,i</sub> - ∑<sub>h=1</sub><sup>H</sup> W<sub>h</sub><sup>2</sup>(1 - n<sub>h</sub>/N<sub>h</sub>)s<sub>yh</sub><sup>2</sup>/n<sub>h</sub>

This says we would like to maximize the decrease in variance.

Here ȳ<sub>st, i</sub> is used to denote this after another sample is taken from stratum i. For simplicity, assume that all strata have the same size, so W<sub>h</sub> are equal. Then, we can notice that all the terms in this sum are equal, except for those relating to stratum i:

(1 - (n<sub>i</sub> + 1)/N<sub>i</sub>)s<sub>i</sub><sup>*2</sup>/(n<sub>i</sub> + 1) - (1 - n<sub>i</sub>/N<sub>i</sub>)s<sub>i</sub><sup>2</sup>/n<sub>i</sub>

If we assume s<sub>i</sub><sup>*2</sup> = s<sub>i</sub><sup>2</sup>, after rearranging we obtain the objective as:

max<sub>i</sub> s<sub>i</sub><sup>2</sup>/(n(n+1))

This shows that the expected benefit is increasing in the variance of the sample, as would be expected from Neyman allocation, and is decreasing in the number of samples already taken from that strata, because as more samples are taken from a given strata, we have a better estimate of its mean.


## Procedure:
1. Take a small number of samples from all strata, compute variance, and the expected benefit estimates for all strata.
2. Compute the expected benefit for each of the strata
3. Sample from the strata with maximum expected benefit
4. Repeat this until a total of $n$ samples are taken

*Implementation Detail:  To make this computationally efficient, we can use the iterative update formulas for the mean and standard deviation. Using this means previous samples don't have to be stored.*

## Conclusion
This is a simple way to take advantage sequental sampling using stratified sampling. Compared to the two-sample method, this will more efficiently allocate samples, so should result in lower variance of the estimator. More details are [here](https://github.com/renebidart/stratified-sampling).





