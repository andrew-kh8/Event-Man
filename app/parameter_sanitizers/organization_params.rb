class OrganizationParams < Devise::ParameterSanitizer
  # devise params - https://github.com/heartcombo/devise?tab=readme-ov-file#strong-parameters
  def initialize(*)
    super
    permit(:sign_up, keys: %i[name email])
  end
end
