# The automated testing of randomness with multiple statistical batteries

The randomness and pseudorandomness are important security property of output of a random number generator as well a cryptographic function. To some extent, these characteristics can be measured and tested by randomness statistical batteries like STS NIST or DIEHARDER. The thesis is aimed at development of a tool that would provide means for fast, simple and consistent testing of randomness of arbitrary data using multiple statistical batteries.

The thesis will provide an introduction to statistical randomness testing and interpretation of results obtained from a given test and battery. The toolkit for easy remote execution of statistical tests on a dedicated server will be developed with the following functionality:

  * Easy submission of data for testing, both locally (filesystem) and remotely (web interface)
  * At least three different statistical batteries will be incorporated via unified interface
  * Unified presentation of test results of executed batteries
  
The tool will be utilized in subsequent experiments aimed to compare classical batteries with EACirc framework and also evaluate test behavior of DIEHARDER on large amount of truly random data.

**Literature**
 * STS NIST battery, http://csrc.nist.gov/groups/ST/toolkit/rng/index.html [2017-03-13]
 * R. Brown, Dieharder battery, https://www.phy.duke.edu/~rgb/General/dieharder.php[2017-03-13]
