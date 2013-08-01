require 'net/http'
require 'openssl'
require 'tempfile'

module TrustMe
  def self.add_to_keychain(url)
    cert = cert_from_url(url)
    path = der_path(cert)
    add_to_system_keychain(path)

    if in_key_chain?(url)
      puts "Try to reload the page, if doesn't work restart Chrome"
      puts "If still doesn't work, then please create an issue"
    else
      puts 'There could be some issue, check Keychain Utility'
    end
  end

  def self.cert_from_url(url)
    uri = URI(url)
    res = Net::HTTP.start(
      uri.host,
      uri.port,
      :use_ssl => uri.scheme == 'https',
      :verify_mode => OpenSSL::SSL::VERIFY_NONE
    )

    res.peer_cert
  end

  def self.der_path(cert)
    cn = cert.subject.to_a.find { |r| r.include?('CN') }[1]
    file = Tempfile.new(cn)
    file.write cert.to_der
    file.close
    file.path
  end

  def self.add_to_system_keychain(der_path)
    `sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" -p ssl #{der_path}`
  end

  def self.in_key_chain?(url)
    host = URI(url).host
    `security find-certificate -c #{host}`
     $?.success?
  end
end

if __FILE__ == $0
  url = ARGV[0]
  raise 'Is it valid https uri?' unless url.match /^https:\/\/.+/
  TrustMe.add_to_keychain(url)
end
