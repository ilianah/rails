require File.dirname(__FILE__) + '/abstract_client'


module ClientSoapTest
  PORT = 8998

  class SoapClientLet < ClientTest::AbstractClientLet
    def do_POST(req, res)
      test_request = ActionController::TestRequest.new
      test_request.request_parameters['action'] = req.path.gsub(/^\//, '').split(/\//)[1]
      test_request.env['REQUEST_METHOD'] = "POST"
      test_request.env['HTTP_CONTENTTYPE'] = 'text/xml'
      test_request.env['HTTP_SOAPACTION'] = req.header['soapaction'][0]
      test_request.env['RAW_POST_DATA'] = req.body
      protocol_request = @controller.protocol_request(test_request)
      response = @controller.dispatch_request(protocol_request)
      res.header['content-type'] = 'text/xml'
      res.body = response.raw_body
    rescue Exception => e
      $stderr.puts e.message
      $stderr.puts e.backtrace.join("\n")
    end
  end

  class ClientContainer < ActionController::Base
    client_api :client, :soap, "http://localhost:#{PORT}/client/api", :api => ClientTest::API

    def get_client
      client
    end
  end

  class SoapServer < ClientTest::AbstractServer
    def create_clientlet(controller)
      SoapClientLet.new(controller)
    end

    def server_port
      PORT
    end
  end
end

class TC_ClientSoap < Test::Unit::TestCase
  include ClientTest
  include ClientSoapTest

  def setup
    @server = SoapServer.instance
    @container = @server.container
    @client = ActionService::Client::Soap.new(API, "http://localhost:#{@server.server_port}/client/api")
  end

  def test_void
    assert(@container.value_void.nil?)
    @client.void
    assert(!@container.value_void.nil?)
  end

  def test_normal
    assert(@container.value_normal.nil?)
    assert_equal(5, @client.normal(5, 6))
    assert_equal([5, 6], @container.value_normal)
  end

  def test_array_return
    assert(@container.value_array_return.nil?)
    new_person = Person.new
    new_person.firstnames = ["one", "two"]
    new_person.lastname = "last"
    assert_equal([new_person], @client.array_return)
    assert_equal([new_person], @container.value_array_return)
  end

  def test_struct_pass
    assert(@container.value_struct_pass.nil?)
    new_person = Person.new
    new_person.firstnames = ["one", "two"]
    new_person.lastname = "last"
    assert_equal(true, @client.struct_pass([new_person]))
    assert_equal([[new_person]], @container.value_struct_pass)
  end

  def test_client_container
    assert_equal(50, ClientContainer.new.get_client.client_container)
  end
end
