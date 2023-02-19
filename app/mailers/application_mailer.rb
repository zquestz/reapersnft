# frozen_string_literal: true

# ApplicationMailer provides email features.
class ApplicationMailer < ActionMailer::Base
  default from: 'info@pixelatedink.io'
  layout 'mailer'
end
