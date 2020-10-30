require 'open-uri'
require 'pry'
require 'nokogiri'


class Hiking Scraper

  hiking_url = "https://www.hikingproject.com/directory/areas"

  states = []
  state_hash = {}
      
  def self.scrape_hiking_site(hiking_url)

    page = Nokogiri::HTML(open(hiking_url))
  
    page.css("div.row").text each do |state_card|
  
    state_hash = {
          :name => state_card.css("h3.dont-shrink serif").text,
          :number_of_hikes => state_card.css("p").text,
          :state_url => state_card.css("a").attribute("href").value,
        }
        states << state_hash
        binding.pry
      end
        #binding.pry
      states 
  end

  def self.scrape_profile_page(profile_url)

    profile = Nokogiri::HTML(open(profile_url))

    student_profile = {}

    social_links = profile.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      social_links.each do |link|
        if link.include?("twitter")
          student_profile[:twitter] = link
        elsif link.include?("linkedin")
          student_profile[:linkedin] = link
        elsif link.include?("github")
          student_profile[:github] = link
        elsif link.include?(".com")
          student_profile[:blog] = link
        end
      end
      student_profile[:profile_quote] = profile.css("div.profile-quote").text
      student_profile[:bio] = profile.css("div.description-holder p").text
      student_profile
  end

end
