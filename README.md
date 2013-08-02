
# Trustme

Quasi automated way to trust your self-signed certificate in **Chrome** browser by using **OS X**'s Keychain utility.

### Story

Self-signed certificates are common solution for the test and staging environments. 

Easy to create and deploy, but there is one drawback though:


![Not trusted](https://dl.dropboxusercontent.com/u/10911324/not_trusted.png)

Browsers don't trust those certificates, cause they are not signed by any known certificate authority.

Of course there is a solution to get rid off this nasty warning, and this is "almost" automated way to do this.

### Usage

Download the `trustme.rb` script and run:

  `ruby trustme.rb https://<domain-with-self-signed-cert>`


This script gets a self signed certificate from the server and adds it to the OSX's key chain.


### Caveats:

For unknown reason `-p ssl` switch sometimes doesn't work, so after you run script, you'll still have to:

  - Open Keychain Access utility
  - Find your certificate in the system keychain and open it
  - Go to the "Trust" section, select "Always Trust" from "Secure Scoekcts Layer) SSL"
  - Close it, and insert the password again


#### Credits:

- [adding-new-trusted-root-certificates-to-system-keychain/](http://derflounder.wordpress.com/2011/03/13/adding-new-trusted-root-certificates-to-system-keychain/)
