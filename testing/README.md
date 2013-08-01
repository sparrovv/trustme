Testing is a bit manual at the moment.

1. Generate self-signed certificate, by running: `generate-self-signed-cert.sh` with **foo.bar** domain (Common Name)

2. Run Webrick with SSL support: `ruby server.rb`

3. `echo '127.0.0.1 foo.bar' | sudo tee -a /etc/hosts`

4. `open https://boo.bar:9753`
