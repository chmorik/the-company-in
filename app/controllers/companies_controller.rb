class CompaniesController < ActionController::Base

  def create
    return redirect_to :companies, alert: 'No Domain' if params.dig('company', 'domain').blank?

    company = Clearbit.find_by_domain(params.dig('company', 'domain').to_s)
    return redirect_to :companies, notice: 'Company was not saved' if company.blank?

    @company = Company.create(company.slice('logo', 'name', 'company_type', 'domain',
                                            'description', 'industry',
                                            'money_raised',
                                            'market_cap', 'annual_revenue',
                                            'location', 'number_of_employees'))
    redirect_to :companies, notice: 'New company saved'
  end

  def index
    @company = Company.new
    @companies = Company.select(:id, :logo, :name, :company_type).order('likes DESC').all
  end

  def show
    @company = Company.find_by(id: params[:id])
    return redirect_to :companies, alert: 'No company found' if @company.blank?

  end
end
