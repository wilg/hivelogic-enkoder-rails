module EnkoderRails
  class Railtie < Rails::Railtie
    
    initializer 'hivelogic_enkoder_rails.helper_additions' do
      ActiveSupport.on_load(:action_view) do
        ActiveSupport.on_load(:after_initialize) do
          extend HelperAdditions
        end
      end
    end
    
  end
end