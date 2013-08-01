# Trustme

Quasi automated way to trust your self-signed certificate in **Chrome** browser by using **OS X**'s Keychain utility.

### Story

Self-signed certificates are common solution for the test and staging environments. 

Easy to create and deploy, but there is one drawback though:


![Not trusted](https://dl.dropboxusercontent.com/u/10911324/not_trusted.png)

Browsers doesn't trust those certificates, cause they are not signed by any known certificate authority.

Of course there is a solution to get rid off this nasty warning, and this is "almost" automated way to do this.

### Usage
  Download the `trustme.rb` script and run:

  `ruby trustme.rb https://<domain-with-self-signed-cert>`


This script gets a self signed certificate from the server and adds it to the OSX's key chain.


#### Credits:

- [adding-new-trusted-root-certificates-to-system-keychain/](http://derflounder.wordpress.com/2011/03/13/adding-new-trusted-root-certificates-to-system-keychain/)
