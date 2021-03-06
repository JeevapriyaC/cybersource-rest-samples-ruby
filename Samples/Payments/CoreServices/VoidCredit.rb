require 'cybersource_rest_client'
require_relative 'ProcessCredit.rb'
require_relative '../../../Data/Configuration.rb'

# * This is a sample code to call VoidApi,
# * Void a Credit
# * Include the Credit ID in the POST request to cancel the Payment Credit.

public
class VoidCredit
  def main
    config = MerchantConfiguration.new.merchantConfigProp()
    request = CyberSource::VoidCreditRequest.new
    api_client = CyberSource::ApiClient.new
    api_instance = CyberSource::VoidApi.new(api_client, config)

    # Calling CreateCredit Sample code 
    response = CreateCredit.new.main
    resp = JSON.parse(response)
    id = resp['id']

    client_reference_information = CyberSource::Ptsv2paymentsClientReferenceInformation.new
    client_reference_information.code = "test_credit_void"
    request.client_reference_information = client_reference_information
    
    data, status_code, headers = api_instance.void_credit(request, id)
    puts data, status_code, headers
  rescue StandardError => err
    puts err.message
  end
  VoidCredit.new.main
end
