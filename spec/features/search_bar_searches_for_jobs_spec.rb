require "rails_helper"

RSpec.feature "SearchBarSearchesForJobs", type: :feature do
  context "as a visitor" do
    let!(:company) do
      Company.create(name: "Crash Keys",
                     information: "An organization dedicated to the betterment of the world.")
    end
    let!(:job) do
      company.jobs << Job.create(title: "Stop the Virus",
                                 description: "One of our computer systems has become infected.",
                                 location: "Seattle, WA")
    end
    let!(:bad_job) do
      company.jobs << Job.create(title: "Prevent Radical-6",
                                 description: "Please infiltrate the Mars Mission Test Site.",
                                 location: "Reno, NV")
    end

    it "can search for a job given criteria" do
      visit root_path
      fill_in :search_title, with: "Stop the Virus"
      fill_in :search_location, with: "Seattle, WA"
      click_button "Find Me A Job"

      expect(page).to have_content("Jobs")
      expect(page).to have_content("Stop the Virus")
      expect(page).to have_content("Crash Keys")
      expect(page).to have_content("Seattle, WA")
    end

    it "does not return jobs not matching the criteria" do
      visit root_path
      fill_in :search_title, with: "Stop the Virus"
      fill_in :search_location, with: "Seattle, WA"
      click_button "Find Me A Job"

      expect(page).to have_content("Jobs")
      expect(page).not_to have_content("Prevent Radical-6")
      expect(page).not_to have_content("Reno, NV")
    end
  end
end
