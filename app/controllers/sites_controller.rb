# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string
#  host       :string
#  subdomain  :string
#  data       :hstore
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SitesController < ApplicationController
  before_action :find_site
  def show

  end

  def edit

  end

  private

  def find_site
    #@site = Site.find(params[:id])
    case request.host
    when "www.#{Setting.host}", Setting.host, nil
      @site = Site.find(params[:id])
    else
      if request.host.index(Setting.host)
        @site = Site.find_by_subdomain(request.host.split('.').first)
      else
        @site = Site.find_by_host(request.host)
      end

      if !@site
        render :file => 'public/404', layout: 'layouts/application', status: 404
      end
    end
  end

end