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

require 'rails_helper'

RSpec.describe SitesController, type: :request do
  let(:site) { FactoryGirl.create :site, :host =>"example.com" }

  context "#show" do
    before { get "http://#{Setting.host}/sites/#{site.id}" }
    it { expect(response).to be_success }
  end

  context "#show through subdomain" do
    before { get "http://#{site.subdomain}.#{Setting.host}" }
    it { expect(response).to be_success }
  end

  context "#show through customized domain" do
    it "assigns site" do
      host!(site.host)
      get "/"
      expect(assigns(:site).id).to eq(site.id)
    end
  end

  context "#edit" do
    before { get "http://#{Setting.host}/sites/#{site.id}/edit" }
    it { expect(response).to be_success }
  end

  context "#edit through subdomain" do
    before { get "http://#{site.subdomain}.#{Setting.host}/edit" }
    it { expect(response).to be_success }
  end

  context "#edit through customized domain" do
    it "assigns site" do
      host!(site.host)
      get "/edit"
      expect(assigns(:site).id).to eq(site.id)
    end
  end


end
