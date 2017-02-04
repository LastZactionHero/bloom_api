require 'rails_helper'

describe EarlySignUpController do
  it 'creates an EarlySignUp' do
    email = 'user@site.com'

    expect(EarlySignUp.count).to eq(0)
    post :signup, email: email
    expect(response.status).to eq(200)

    expect(EarlySignUp.count).to eq(1)
    expect(EarlySignUp.first.email).to eq(email)
    expect(EarlySignUp.first.newsletter).to eq(false)
  end

  it 'registers for the newsletter' do
    email = 'user@site.com'

    expect(EarlySignUp.count).to eq(0)
    post :signup, email: email, newsletter: true
    expect(response.status).to eq(200)

    expect(EarlySignUp.count).to eq(1)
    expect(EarlySignUp.first.email).to eq(email)
    expect(EarlySignUp.first.newsletter).to eq(true)
  end

  it 'returns an error if no email is provided' do
    expect(EarlySignUp.count).to eq(0)
    post :signup, email: nil
    expect(response.status).to eq(400)

    expect(JSON.parse(response.body)['errors']['email']).to eq(['must be provided'])
  end

end