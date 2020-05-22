module Spree
  module LocationAbilityActivator
    private
    def abilities_to_register
      super << Spree::LocationManagerAbility
    end
  end
end

Spree::Ability.prepend Spree::LocationAbilityActivator