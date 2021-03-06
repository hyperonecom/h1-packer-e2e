# rbx-packer-e2e

[![Build Status](https://travis-ci.com/hyperonecom/h1-packer-e2e.svg?branch=master)](https://travis-ci.com/hyperonecom/h1-packer-e2e)

The repository contains a script intended for permanent, cyclical verification of the correctness of the [HyperOne builder](http://www.packer.io/docs/builders/hyperone.html) in the [Packer](http://www.packer.io/) software through builder-specific [end-to-end tests](https://github.com/hashicorp/packer/blob/master/test/builder_hyperone.bats). Scripts are executed on the Travis CI platform daily.

The tests run real virtual machines on the platform and real images are built.

The test specification is located in the Packer repository.

Administrators of the repository are notified about the problems by TravisCI directly.
