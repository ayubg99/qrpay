namespace :carts do
    desc 'Cleanup inactive carts'
    task cleanup: :environment do
      Cart.where('last_active_at < ?', 10.minutes.ago).destroy_all
    end
end