require "spec_helper"

RSpec.describe ApplicationTester do
  let(:application) { described_class.new("http://www.test.com") }

  describe "#redirection_check" do
    let(:application) { described_class.new("http://test.com") }
    subject { application.redirection_check }

    context "valid URL" do
      it "returns a string with the result" do
        expect(subject).to eq "Redirects to www: true <p>Redirects to https: true</p>"
      end
    end

    context "invalid URL" do
      let(:application) { described_class.new("http://invalidUrl.com") }
      it "returns a string saying that the url is invalid" do
        expect(subject).to eq "Invalid URL"
      end
    end
  end

  describe "#robots_check" do
    subject { application.robots_check }

    it "returns a string with the result" do
      expect(subject).to eq "Has Robots.txt: true"
    end
  end

  describe "#sitemap_check" do
    subject { application.sitemap_check }

    context "sitemap exists" do
      it "returns a string with the result" do
        expect(subject).to eq "Has Sitemap links: true<p>All the Sitemap files exist and are not empty: true</p>"
      end
    end
    context "no sitemaps" do
    let(:application) { described_class.new("http://www.testfail.com") }
      it "returns a string saying that robots.txt doesn't exist" do
        expect(subject).to eq "Robots.txt does not exist. Sitemap is not specififed."
      end
    end
  end

  describe "#ssl_certificate_check" do
    subject { application.ssl_certificate_check }

    context "there is ssl certificate" do
      it "returns a string with the certificate expiration date" do
        allow(application.website).to receive(:ssl_certificate).and_return(SslCertificate.new("test.com"))
        allow(application.website.ssl_certificate).to receive(:certificate_string).and_return(ssl_string)
        expect(subject).to eq "Valid SSL certificate: true <p>Expires: 2015-12-31 10:43:04 UTC"
      end
    end

    context "no ssl certificate" do
      it "returns a string saying that the certificate doesn't exist" do
        allow(application.website).to receive(:ssl_certificate).and_return(nil)
        expect(subject).to eq "No SSL certificate exists"
      end
    end
  end
  let(:ssl_string) { "CONNECTED(00000003)
  depth=1 /C=FR/O=KEYNECTIS/CN=CLASS 2 KEYNECTIS CA
verify error:num=20:unable to get local issuer certificate
verify return:0
---
Certificate chain
 0 s:/C=RU/ST=Russia/L=Moscow/OU=ITO/O=Yandex/CN=yandex.ru
   i:/C=FR/O=KEYNECTIS/CN=CLASS 2 KEYNECTIS CA
-----BEGIN CERTIFICATE-----
MIIH2jCCBsKgAwIBAgISESen69XC+sw+Mcc5o8PJZ1LtMA0GCSqGSIb3DQEBBQUA
MEAxCzAJBgNVBAYTAkZSMRIwEAYDVQQKEwlLRVlORUNUSVMxHTAbBgNVBAMTFENM
QVNTIDIgS0VZTkVDVElTIENBMB4XDTE1MDYwNDA5NDMwNFoXDTE1MTIzMTEwNDMw
NFowYjELMAkGA1UEBhMCUlUxDzANBgNVBAgUBlJ1c3NpYTEPMA0GA1UEBxQGTW9z
Y293MQwwCgYDVQQLFANJVE8xDzANBgNVBAoUBllhbmRleDESMBAGA1UEAxMJeWFu
ZGV4LnJ1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwHGLJkOsqQKf
UbBI8R6HHVxjUYUtlvuYD4iugGsBw3HxtSN7OQ3naunJ3iZdvoQZT5BG7HE0MvTb
15RF/ME8Qu6romee6yECiSlA4Iv8KCmYpaqoPdKS7h9ATgWDcCWKKhu0TTH8CSWe
rQAHyS99Bp1CsAR7VKBKEpitT73Cu+1ythA3jHipoV49yNkl/fDDl6gWwoUiGua3
1X4FtWPhhG6jQswDnTQhVI660P71ZP/88nYGDEQU/vE19Ku6dwTfOE66WR8TlUFb
64FCB48kcfavoY8sJGMeH29hytbljfwWSMCm7+fumn4IWv98T2u1S6fTk2eCDEcf
bXjXqrlKzwIDAQABo4IEqjCCBKYwCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMCBaAw
HQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMIIDSgYDVR0RBIIDQTCCAz2C
CXlhbmRleC5ydYIKeWFuZGV4LmNvbYINeWFuZGV4LmNvbS50coIJeWFuZGV4LmJ5
ggl5YW5kZXgua3qCCXlhbmRleC51YYIQaW1hZ2VzLnlhbmRleC5ydYIRaW1hZ2Vz
LnlhbmRleC5jb22CFGltYWdlcy55YW5kZXguY29tLnRyghBpbWFnZXMueWFuZGV4
LmJ5ghBpbWFnZXMueWFuZGV4Lmt6ghBpbWFnZXMueWFuZGV4LnVhgg92aWRlby55
YW5kZXgucnWCEHZpZGVvLnlhbmRleC5jb22CE3ZpZGVvLnlhbmRleC5jb20udHKC
D3ZpZGVvLnlhbmRleC5ieYIPdmlkZW8ueWFuZGV4Lmt6gg92aWRlby55YW5kZXgu
dWGCDXd3dy55YW5kZXgucnWCDnd3dy55YW5kZXguY29tghF3d3cueWFuZGV4LmNv
bS50coINd3d3LnlhbmRleC5ieYINd3d3LnlhbmRleC5reoINd3d3LnlhbmRleC51
YYIUZ29yc2VsLnlhbmRleC5jb20udHKCEmdhbWUueWFuZGV4LmNvbS50coITZ2Ft
ZXMueWFuZGV4LmNvbS50coIScGxheS55YW5kZXguY29tLnRyghJveXVuLnlhbmRl
eC5jb20udHKCEHBlb3BsZS55YW5kZXgucnWCEHBlb3BsZS55YW5kZXgudWGCEHBl
b3BsZS55YW5kZXguYnmCEHBlb3BsZS55YW5kZXgua3qCEmFpbGUueWFuZGV4LmNv
bS50coIUZmFtaWx5LnlhbmRleC5jb20udHKCD20ueWFuZGV4LmNvbS50coITeG1s
c2VhcmNoLnlhbmRleC5ydYITeG1sc2VhcmNoLnlhbmRleC51YYITeG1sc2VhcmNo
LnlhbmRleC5ieYITeG1sc2VhcmNoLnlhbmRleC5reoIUeG1sc2VhcmNoLnlhbmRl
eC5jb22CF3htbHNlYXJjaC55YW5kZXguY29tLnRyggp5YW5kZXgubmV0ggxtLnlh
bmRleC5jb22CC20ueWFuZGV4LnJ1ggttLnlhbmRleC5reoILbS55YW5kZXgudWGC
C20ueWFuZGV4LmJ5ME8GA1UdHwRIMEYwRKBCoECGPmh0dHA6Ly9jcmwtc3NsLmNl
cnRpZmljYXQyLmNvbS9rZXluZWN0aXMvY2xhc3Mya2V5bmVjdGlzY2EuY3JsMEQG
CCsGAQUFBwEBBDgwNjA0BggrBgEFBQcwAYYoaHR0cDovL29jc3Atc3NsLmNlcnRp
ZmljYXQyLmNvbS9zc2wtb2NzcDBFBgNVHSAEPjA8MDoGDSsGAQQBga1aAgUCBQEw
KTAnBggrBgEFBQcCARYbaHR0cDovL3d3dy5vcGVudHJ1c3QuY29tL1BDMB0GA1Ud
DgQWBBROcfbv3qVRBoepyjXUDTVHeiRCPTAfBgNVHSMEGDAWgBQAEUHfO507y7ii
wTOSqIHM5X3nmTANBgkqhkiG9w0BAQUFAAOCAQEAEmxiUiYQu7MnNUzcCvftIWTA
uVgENLRl7CBFHrBIp5P7odQkj12yxFwNzOApPJuWK8vta3sKaARyjRJiiTZiFnBw
C2/dnO7ML6Sv+2RORPcUMCkJvH8TkJP8BhPwhkFYuOx23sYODYNkpqkH8jr96hbb
DSysn6AI8kpAMXKWPoPKrLcVvyZEUyY6MzsgzOZksgR8pMFzhXUQ+TPqV8lK8RvW
LtcnwmlvTranqIYty7ncB5friCBrDDjDF5tU+qveKDkwgVVIMxrOg67eCHxCO/DB
YKgcdqrzOBSIEYR+AlbYAosYLjIoqKgQMBrfW/CFRurM2qZjUgXHaXBDOTim2w==
-----END CERTIFICATE-----
 1 s:/C=FR/O=KEYNECTIS/CN=CLASS 2 KEYNECTIS CA
   i:/C=FR/O=Certplus/CN=Class 2 Primary CA
-----BEGIN CERTIFICATE-----
MIIEKzCCAxOgAwIBAgISESCW9sgDfJ4HsTi/LnIQitftMA0GCSqGSIb3DQEBBQUA
MD0xCzAJBgNVBAYTAkZSMREwDwYDVQQKEwhDZXJ0cGx1czEbMBkGA1UEAxMSQ2xh
c3MgMiBQcmltYXJ5IENBMB4XDTA3MDYwNTAwMDAwMFoXDTE5MDYyMDAwMDAwMFow
QDELMAkGA1UEBhMCRlIxEjAQBgNVBAoTCUtFWU5FQ1RJUzEdMBsGA1UEAxMUQ0xB
U1MgMiBLRVlORUNUSVMgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDGvv5EIwTU7y87hqo1WIHR4ZrWsdQnRSj80R5GhbpUIxF94GY/1KNXZnj5a+t0
fCq4N6XocK6CtU7Ugf5b4urnIhb4+de6OvaIVtzE8qCk5XUGYHIr+/WU7iyDKN6R
mrODOrCfCPrd2J6MJObfZlvIfqNiTT86hSPs6HGPCgCsiW1+2HLl3cGUjl/kc+bB
xgyHWE832tGpiCZ2tO4Rjfatsqe8c8TNHG4a5o1yVkSgmPeS+dd5mwPmaF+kXHw9
ULSDzOWsDeE+TxTytOR9v3Gkw5dzONZSfMikterpslRW1Ou4VzpAUlpeRiejezAt
CD2FHprwMqjyEKKDm+Io9p3LAgMBAAGjggEgMIIBHDASBgNVHRMBAf8ECDAGAQH/
AgEAMH0GA1UdIAR2MHQwOAYLKwYEAYGtWgIFAwMwKTAnBggrBgEFBQcCARYbaHR0
cDovL3d3dy5rZXluZWN0aXMuY29tL1BDMDgGCysGBAGBrVoCBQEDMCkwJwYIKwYB
BQUHAgEWG2h0dHA6Ly93d3cua2V5bmVjdGlzLmNvbS9QQzA3BgNVHR8EMDAuMCyg
KqAohiZodHRwOi8vd3d3LmNlcnRwbHVzLmNvbS9DUkwvY2xhc3MyLmNybDAOBgNV
HQ8BAf8EBAMCAQYwHQYDVR0OBBYEFAARQd87nTvLuKLBM5KogczlfeeZMB8GA1Ud
IwQYMBaAFONzLd/LDigM3t2zpMp5uI676DCJMA0GCSqGSIb3DQEBBQUAA4IBAQAI
iP4fosrN4qDxLnxnSfvclKx/QQ14Abox95v7MRh3L2YllLhtFnSB8cCuZ8YURXoB
0ROI/OKNIh29HgzHqX7Qw5f2N1tBXmeUjqtpAhcY9U04wkkoCW5am6Yn28Bfj0Sc
kGWZ2LMuwZLuGp0PckUg+iwMnF3NW1RBVE/T4sdZhD8Xe30Owu9ix7qxJmyDTtMZ
xf9Wp7RFP3qe+tA5PoBGdV1aeXozxQG8AkTOG8AxTkeWFW7n5HbwwpANoXj0OACR
K2V8eROoPpEU3IgFCNdvU/YVQ+7FU1YaArWmokaNHhPkZ8JFX0BeEEJYtc1Eo5RM
HFSQTZGaJoutooBQjRQU
-----END CERTIFICATE-----
---
Server certificate
subject=/C=RU/ST=Russia/L=Moscow/OU=ITO/O=Yandex/CN=yandex.ru
issuer=/C=FR/O=KEYNECTIS/CN=CLASS 2 KEYNECTIS CA
---
No client certificate CA names sent
---
SSL handshake has read 3257 bytes and written 456 bytes
---
New, TLSv1/SSLv3, Cipher is AES128-SHA
Server public key is 2048 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
SSL-Session:
    Protocol  : TLSv1
    Cipher    : AES128-SHA
    Session-ID: 1D6D8C7251B9F861A57BAD9E9D6B38BE726D0D6D02D3A97A1252ACD705EDEB39
    Session-ID-ctx:
    Master-Key: 7A41746AA3DAEA01A410494139D3B8E220D0E4CEDD30EF1382574AD20C390020510865C817280C8EBB977A1F6BCEC4F7
    Key-Arg   : None
    Start Time: 1440435406
    Timeout   : 300 (sec)
    Verify return code: 0 (ok)
---
DONE
" }
end
