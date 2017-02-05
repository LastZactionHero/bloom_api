class EarlySignUpController < ApplicationController

  def signup
    email = params[:email]
    if email.present?
      EarlySignUp.create(
        email: email,
        newsletter: params[:newsletter] == 'true',
        zipcode: params[:zipcode])
      render status: 200, json: {}
    else
      render status: 400, json: {errors: {email: ['must be provided']}}
    end
  end

end