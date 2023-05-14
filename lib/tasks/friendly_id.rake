namespace :friendly_id do
    desc "Generate slugs for existing restaurants"
    task generate_slugs: :environment do
      Restaurant.find_each(&:save)
    end
  end