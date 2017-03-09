require 'open-uri'
require 'json'
require 'pp'
require 'addressable/uri'

###### CHANGE VARS BELOW
_ICINGA_WEB_API_PATH = "<icinga-web-api-url>"
_ICINGA_HOSTGROUP = "<host group name>"
_CUSTOMER_CODE = "customer1"
_ICINGA_AUTH_KEY = "<icinga-web-api-auth_key>"
#####

hosts_up_value = 0
hosts_critical_value = 0
hosts_warning_value = 0
hosts_unknown_value = 0

services_up_value = 0
services_critical_value = 0
services_warning_value = 0
services_unknown_value = 0

SCHEDULER.every '30s' do

  hosts_up_url = "#{_ICINGA_WEB_API_PATH}/host/filter[AND(HOST_CURRENT_STATE|=|0); AND(HOSTGROUP_NAME|=|#{_ICINGA_HOSTGROUP})]/columns[HOST_NAME]/countColumn=HOST_NAME/authkey=#{_ICINGA_AUTH_KEY}/json"
  hosts_up_safeurl = Addressable::URI.encode_component(hosts_up_url, Addressable::URI::CharacterClasses::QUERY)
  buffer_up = open(hosts_up_safeurl).read
  result_up = JSON.parse(buffer_up)
  hosts_up_value = result_up["total"]

  hosts_critical_url = "#{_ICINGA_WEB_API_PATH}/host/filter[AND(HOST_CURRENT_STATE|=|1); AND(HOSTGROUP_NAME|=|#{_ICINGA_HOSTGROUP})]/columns[HOST_NAME]/countColumn=HOST_NAME/authkey=#{_ICINGA_AUTH_KEY}/json"
  hosts_critical_safeurl = Addressable::URI.encode_component(hosts_critical_url, Addressable::URI::CharacterClasses::QUERY)
  buffer_critical = open(hosts_critical_safeurl).read
  result_critical = JSON.parse(buffer_critical)
  hosts_critical_value = result_critical["total"]

  hosts_warning_url = "#{_ICINGA_WEB_API_PATH}/host/filter[AND(HOST_CURRENT_STATE|=|2); AND(HOSTGROUP_NAME|=|#{_ICINGA_HOSTGROUP})]/columns[HOST_NAME]/countColumn=HOST_NAME/authkey=#{_ICINGA_AUTH_KEY}/json"
  hosts_warning_safeurl = Addressable::URI.encode_component(hosts_warning_url, Addressable::URI::CharacterClasses::QUERY)
  buffer_warning = open(hosts_warning_safeurl).read
  result_warning = JSON.parse(buffer_warning)
  hosts_warning_value = result_warning["total"]

  hosts_unknown_url = "#{_ICINGA_WEB_API_PATH}/host/filter[AND(HOST_CURRENT_STATE|=|3); AND(HOSTGROUP_NAME|=|#{_ICINGA_HOSTGROUP})]/columns[HOST_NAME]/countColumn=HOST_NAME/authkey=#{_ICINGA_AUTH_KEY}/json"
  hosts_unknown_safeurl = Addressable::URI.encode_component(hosts_unknown_url, Addressable::URI::CharacterClasses::QUERY)
  buffer_unknown = open(hosts_unknown_safeurl).read
  result_unknown = JSON.parse(buffer_unknown)
  hosts_unknown_value = result_unknown["total"]

  services_up_url = "#{_ICINGA_WEB_API_PATH}/service/filter[AND(SERVICE_CURRENT_STATE|=|0); AND(HOSTGROUP_NAME|=|#{_ICINGA_HOSTGROUP})]/columns[SERVICE_NAME]/countColumn=SERVICE_NAME/authkey=#{_ICINGA_AUTH_KEY}/json"
  services_up_safeurl = Addressable::URI.encode_component(services_up_url, Addressable::URI::CharacterClasses::QUERY)
  buffer_up = open(services_up_safeurl).read
  result_up = JSON.parse(buffer_up)
  services_up_value = result_up["total"]

  services_critical_url = "#{_ICINGA_WEB_API_PATH}/service/filter[AND(SERVICE_CURRENT_STATE|=|2); AND(HOSTGROUP_NAME|=|#{_ICINGA_HOSTGROUP})]/columns[SERVICE_NAME]/countColumn=SERVICE_NAME/authkey=#{_ICINGA_AUTH_KEY}/json"
  services_critical_safeurl = Addressable::URI.encode_component(services_critical_url, Addressable::URI::CharacterClasses::QUERY)
  buffer_critical = open(services_critical_safeurl).read
  result_critical = JSON.parse(buffer_critical)
  services_critical_value = result_critical["total"]

  services_warning_url = "#{_ICINGA_WEB_API_PATH}/service/filter[AND(SERVICE_CURRENT_STATE|=|1); AND(HOSTGROUP_NAME|=|#{_ICINGA_HOSTGROUP})]/columns[SERVICE_NAME]/countColumn=SERVICE_NAME/authkey=#{_ICINGA_AUTH_KEY}/json"
  services_warning_safeurl = Addressable::URI.encode_component(services_warning_url, Addressable::URI::CharacterClasses::QUERY)
  buffer_warning = open(services_warning_safeurl).read
  result_warning = JSON.parse(buffer_warning)
  services_warning_value = result_warning["total"]

  services_unknown_url = "#{_ICINGA_WEB_API_PATH}/service/filter[AND(SERVICE_CURRENT_STATE|=|3); AND(HOSTGROUP_NAME|=|#{_ICINGA_HOSTGROUP})]/columns[SERVICE_NAME]/countColumn=SERVICE_NAME/authkey=#{_ICINGA_AUTH_KEY}/json"
  services_unknown_safeurl = Addressable::URI.encode_component(services_unknown_url, Addressable::URI::CharacterClasses::QUERY)
  buffer_unknown = open(services_unknown_safeurl).read
  result_unknown = JSON.parse(buffer_unknown)
  services_unknown_value = result_unknown["total"]
  
  send_event("icinga_hosts_services_#{_CUSTOMER_CODE}", { hosts_up_value: hosts_up_value, hosts_unknown_value: hosts_unknown_value, hosts_warning_value: hosts_warning_value, hosts_critical_value: hosts_critical_value, services_up_value: services_up_value, services_unknown_value: services_unknown_value, services_warning_value: services_warning_value, services_critical_value: services_critical_value })
  
end
