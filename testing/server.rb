require 'webrick'
require 'openssl'
require 'webrick/https'

class FakeServer
  include WEBrick
  attr_reader :server

  def initialize(attrs={})
    port = attrs.delete(:port) || 9753
    @server = HTTPServer.new(attrs.merge(Port: port))
    trap("INT"){ server.shutdown }
    setup_pages
  end

  def start
    @server.start
  end

  def stop
    @server.shutdown
  end

  def setup_pages
    @server.mount_proc '/200' do |req, res|
      res.body = '200'
      res.status = '200'
    end
  end
end

webrick_attrs = {
  :SSLEnable          => true,
  :SSLCertificate     => OpenSSL::X509::Certificate.new(  File.open("./server.crt").read),
  :SSLPrivateKey      => OpenSSL::PKey::RSA.new(          File.open("./server.key").read),
  :SSLCertName        => [ [ "CN", WEBrick::Utils::getservername ] ]
}

fake = FakeServer.new(webrick_attrs)
fake.start
