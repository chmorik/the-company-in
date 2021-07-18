class CompaniesController < ActionController::Base

  def create
    domain = params.dig('company', 'domain').to_s
    return redirect_to :companies, alert: 'No domain' if domain.blank?

    @company = Company.find_by(domain: domain)
    return redirect_to :companies, alert: 'Domain in system' if @company.present?

    company = Clearbit.find_by_domain(domain)
    return redirect_to :companies, notice: 'Company was not saved' if company.blank?

    @company = Company.find_or_create_by(clearbit_id: company['id'])

    @company.update(company.slice('logo', 'name', 'company_type', 'domain',
                                  'description', 'industry', 'money_raised',
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

  def update
    @company = Company.find_by(id: params[:id])
    return redirect_to :companies, alert: 'No company found' if @company.blank?

    @company.update(likes: @company.likes.to_i + 1)
    redirect_to company_path(@company), notice: 'Liked'
  end
end
