# OpenCL Torch

This is a distro of [torch](http://torch.ch) library enabled for OpenCL

# Installation

## Pre-requisites

* python 2.7 installed: `python` command should point to python 2.7, during build (this is necessary for building [clBLAS](https://github.com/clMathLibraries/clBLAS) )
* have an OpenCL-1.2 enabled GPU device available, and appropriate OpenCL-1.2 enabled drivers installed

## Procedure

Please proceed as follows:
```
git clone --recursive https://github.com/hughperkins/distro -b distro-cl ~/torch-cl
cd ~/torch-cl
bash install-deps
./install.sh
```
Thats it!  To test, you can do for example:
```
source ~/torch-cl/install/bin/torch-activate
luajit -l torch -e 'torch.test()'
luajit -l nn -e 'nn.test()'
luajit -l cltorch -e 'cltorch.test()'
luajit -l clnn -e 'clnn.test()'
```
If you're using CUDA, you can also run:
```
luajit -l cutorch -e 'cutorch.test()'
luajit -l cunn -e 'nn.testcuda()'
```

## Alternative minimal no-gui install-deps

If you are using Ubuntu, and you dont need qt, itorch, or anything gui-like, then, instead of the line `bash install-deps` in the above instructions,
you can do instead, according to your ubuntu version one of:
```
bash install-deps-nogui-ubuntu1404.sh
```
or:
```
bash install-deps-nogui-ubuntu1604.sh
```

This will install faster, since no qt packages will be installed.

# Updating

Note that nn, torch, cutorch, and cunn are pinned, via the `rocks-cl` repository in your `~/torch-cl/install/etc/luarocks/config.lua` file.
So, doing any of `luarocks install nn`, `luarocks install torch`, `luarocks install cltorch`, `luarocks install clnn`,
`luarocks install cutorch`, or `luarocks install cunn` should no longer break your installation (though they will, if you remove
the pinning).  However, on the whole, the recommended way of updating `distro-cl` is:
```
cd ~/torch-cl
git pull
git submodule update --init --recursive
./install.sh
```
If any errors like `fatal: reference is not a tree`, you have two options:
* easy option: remove ~/torch-cl completely, reinstall
* harder, hacky option:
  * in the error message, you should see which submodule is broken.  Let's say it is `extra/nn`
  * so edit `.git/modules/extra/nn/config`, and in the `url` part, change `torch` to `hughperkins`
  * if it's not `extra/nn`, then modify the path of this file appropriatel
  * that's it!
  * now rerun `git submodule update --init --recursive`, and the updates should pull down ok (otherwise raise an issue)

## Unit-tests

To run, do:
```
source ~/torch-cl/install/bin/torch-activate
luajit -l torch -e 'torch.test()'
luajit -l nn -e 'nn.test()'
luajit -l cltorch -e 'cltorch.test()'
luajit -l clnn -e 'clnn.test()'
```
If you're using CUDA, you can also run:
```
luajit -l cutorch -e 'cutorch.test()'
luajit -l cunn -e 'nn.testcuda()'
```

# Requests for additional operations etc

* Please raise an issue for any operations etc which you particularly need, or you feel are not working for some reason.
* (Ditto for any build errors)

# FAQ

## Support?

Please note that currently, right now, I'm focused 100.000% on [cuda-on-cl](https://github.com/hughperkins/cuda-on-cl), so please be patient during this period
- I anticipate that I shall use cuda-on-cl to re-port the very latest cutting edge version of Torch in the nearish future (q1/q2 2017)

## How does this relate to mainline torch?

It's a stabilized version of torch mainline.  Torch mainline is kind of in permanent 'sid'-style
experimental mode.  This is great for rapidly evolving torch, but it kind of sucks to develop solid
libraries against :-D  This distro holds Torch stable, and allows for porting new features as and when,
without getting emails at 4am because something has changed in Torch mainline, and broken clnn :-D

## Wont this be behind main Torch bleeding edge?

Yes.  But hopefully stable.  And working.  Please file an issue for any features you want from upstream.

## Can I use `cunn` and `cutorch` from this distro?

Yes

## Do you support ubuntu 16.04?

Yes.  I am running Ubuntu 16.04 :-)

## How to request new features, or pull new features from upstream?

Please file an issue.

## Why dont you have any github stars?

They're all on the project pages (for now), ie:
* [cltorch](https://github.com/hughperkins/cltorch)
* [clnn](https://github.com/hughperkins/clnn)

# Related projects

The OpenCL is enabled by using the following two projects, which are installed implicitly by this distro:
* [cltorch](https://github.com/hughperkins/cltorch)
* [clnn](https://github.com/hughperkins/clnn)

An hcc implementation for Torch is in progress here:
* [hctorch](https://bitbucket.org/multicoreware/hctorch)

# Recent changes

* 22nd August:
  * added `:maskedSelect` (thanks to [Jacob Szuppe](https://github.com/haahh) for showing me how to do this, using boost compute)
  * behind the scenes:
    * added [boost compute](https://github.com/boostorg/compute)
    * this opens the door to implementing a few other missing methods, basically anything involving various types of
      `scan` operation
* 21st August:
  * fixed unit test errors and warnings in `nn` module
* 20th August:
  * bunch of patches to get neuralconvo to work:
    * in cltorch, `apply`, `map`, `map2` have now become `apply_on_gpu`, `map_on_gpu`, `map2_on_gpu2, and `apply` is now
    the same as the cutorch version, ie copies to main memory, does the calcs on the cpu, then copies back to gpu,
    for compatibility with cutorch
    * updated Tester.lua in torch to the same as upstream main torch distro, so that `rnn` tests can run now
    * created `rocks-cl` rocks sources, to override upstream rocks for: rnn, torch7, nn, cutorch, cunn
* 2nd May:
  * Re-applied:
    * 26th March:
      * added TemporalConvolution2: same API and usage as TemporalConvolution, but faster on GPUs
* 1st May:
  * Re-applied:
    * 10th March:
      * [@pawni](https://github.com/pawni) (Nick Pawlowski) added SpatialUpSamplingNearest.  Thank you Nick
    * 20th February:
      * [@gloine](https://github.com/gloine) (Jaehyung Lee) added support for non-batched input to ClassNLLCriterion.  Thank you Jaehyung
    * 27 March 2016:
      * migrated from clBLAS 2.4 to clBLAS 2.11/develop. This migration is not set in stone, depends on how well that works. However, there is a bug in 2.4 for certain configurations of matrix multiplication, and its not obvious how to fix that, so maybe using 2.11/develop is the easiest way forward?
* 30th April:
  * distro-cl first created, to stabilize Torch distribution
