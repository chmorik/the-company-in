
class Clearbit

  @key = 'sk_30240e2d1dfc1d73d26ab80390d1fd49'

  def self.find_by_domain(domain)
    begin
      response = RestClient.get("https://company.clearbit.com/v2/companies/find?domain=#{domain}",
                                { Authorization: "Bearer #{@key}" })
    rescue StandardError
      return {}
    end

    json = JSON.parse(response.body)
    attrs = json.slice('name', 'domain', 'description', 'logo', 'location')
    attrs['industry'] = json['category']['industry']
    attrs['company_type'] = json['type']
    attrs['money_raised'] = json['metrics']['raised']
    attrs['market_cap'] = json['metrics']['marketCap']
    attrs['annual_revenue'] = json['metrics']['annualRevenue']
    attrs['number_of_employees'] = json['metrics']['employees']
    attrs
  end
end