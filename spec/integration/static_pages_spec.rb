require 'rails_helper'

describe "StaticPages", type: :integration do

  describe "Home Page" do
    it "should load home page" do
      visit root_path
      expect(page).to have_content("Home page")
    end
  end
    
end