module Mutations
  class CreateUser < BaseMutation
    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end

    argument :name, String, required: true
    argument :auth_provider, AuthProviderSignupData, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(name: nil, auth_provider: nil)
      user = User.create!(
        name: name,
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password)
      )

      token = AuthToken.token_for_user(user)

      $session_token = token

      { user: user, token: token }
    end
  end
end
