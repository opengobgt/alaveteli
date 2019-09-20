# -*- encoding : utf-8 -*-
# Set up our available features and (optionally) get some defaults for
# them from the config/general.yml configuration.

# See Flipper's documentation for further examples of how you can enable
# and disable features, noting that (depending on the adapter used) there
# might well be settings stored in other places (the db, caches, etc) that
# you need to respect.
# https://github.com/jnunemaker/flipper/blob/master/lib/flipper/dsl.rb

# Annotations
# We enable annotations globally based on the ENABLE_ANNOTATIONS config
if AlaveteliConfiguration.enable_annotations
  AlaveteliFeatures.backend.enable(:annotations) unless AlaveteliFeatures.backend.enabled?(:annotations)
else
  AlaveteliFeatures.backend.disable(:annotations) unless !AlaveteliFeatures.backend.enabled?(:annotations)
end

# AlaveteliPro
# We enable alaveteli_pro globally based on the ENABLE_ALAVETELI_PRO config
if AlaveteliConfiguration.enable_alaveteli_pro
  AlaveteliFeatures.backend.enable(:alaveteli_pro) unless AlaveteliFeatures.backend.enabled?(:alaveteli_pro)
else
  AlaveteliFeatures.backend.disable(:alaveteli_pro) unless !AlaveteliFeatures.backend.enabled?(:alaveteli_pro)
end

# Pro Pricing
# We enable pro_pricing globally based on the ENABLE_PRO_PRICING config
if AlaveteliConfiguration.enable_pro_pricing
  AlaveteliFeatures.backend.enable(:pro_pricing) unless AlaveteliFeatures.backend.enabled?(:pro_pricing)
else
  AlaveteliFeatures.backend.disable(:pro_pricing) unless !AlaveteliFeatures.backend.enabled?(:pro_pricing)
end

# Pro Self Serve
# We enable pro_self_serve globally based on the ENABLE_PRO_SELF_SERVE config
if AlaveteliConfiguration.enable_pro_self_serve
  AlaveteliFeatures.backend.enable(:pro_self_serve) unless AlaveteliFeatures.backend.enabled?(:pro_self_serve)
else
  AlaveteliFeatures.backend.disable(:pro_self_serve) unless !AlaveteliFeatures.backend.enabled?(:pro_self_serve)
end
