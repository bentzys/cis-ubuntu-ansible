# CIS for Ubuntu 14.04 and 16.04
# STILL AT DEVELOPMENT!!


Based on https://github.com/awailly/cis-ubuntu-ansible
and Uber's mountopts https://github.com/Uberspace/ansible-mountopts

## Supported CIS Benchmarks:
##         --  CIS_Ubuntu_Linux_14.04_LTS_Benchmark_v2.1.0.pdf
##         --  CIS_Ubuntu_Linux_16.04_LTS_Benchmark_v1.1.0.pdf

## Usage

### One liner installation & execution

The following will automatically install Ansible, download and run the playbook on your local system, according to your needs:

For CIS Level 1 complience:

```
$ \curl -sSL http://git.io/vbj3Y > /tmp/cis.sh && bash /tmp/cis.sh level1
```

For CIS Level 2 complience:

```
$ \curl -sSL http://git.io/vbj3Y > /tmp/cis.sh && bash /tmp/cis.sh level2
```
