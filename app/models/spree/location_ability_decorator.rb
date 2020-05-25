module Spree::LocationAbilityDecorator
  private
  def abilities_to_register
    super << Spree::LocationManagerAbility
  end
end

Spree::Ability.prepend Spree::LocationAbilityDecorator